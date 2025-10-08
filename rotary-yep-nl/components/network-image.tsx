import React, { useState, useMemo, useCallback } from 'react';
import {
  Image,
  ImageProps,
  ActivityIndicator,
  View,
  StyleSheet,
  Pressable,
  Platform,
  Text,
} from 'react-native';
import { useTheme } from '@/hooks/use-theme';
import { getInitials } from '@/utils/communications';
import * as Haptics from 'expo-haptics';
import { ImageModal } from './image-modal';

interface NetworkImageProps extends Omit<ImageProps, 'source'> {
  imageUrl?: string;
  name: string;
  size?: number;
  showInitials?: boolean;
  expandable?: boolean;
}

// Check if URL is valid for image loading
const isValidImageUrl = (url?: string): boolean => {
  return !!(url && !url.includes('Profile_avatar_placeholder_large.png'));
};

export const NetworkImage = React.memo(function NetworkImage({
  imageUrl,
  name,
  size = 60,
  showInitials = true,
  expandable = true,
  style,
  ...props
}: NetworkImageProps) {
  const { colors: themeColors } = useTheme();
  const [imageState, setImageState] = useState<'loading' | 'loaded' | 'error' | 'placeholder'>(
    isValidImageUrl(imageUrl) ? 'loading' : 'placeholder',
  );
  const [showExpandedImage, setShowExpandedImage] = useState(false);

  const imageSize = useMemo(
    () => ({
      width: size,
      height: size,
      borderRadius: size / 2,
    }),
    [size],
  );

  const initials = getInitials(name);
  const shouldShowImage = isValidImageUrl(imageUrl);

  const handleImagePress = useCallback(async () => {
    if (expandable && imageState === 'loaded') {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      setShowExpandedImage(true);
    }
  }, [expandable, imageState]);

  const handleImageLoad = useCallback(() => {
    setImageState('loaded');
  }, []);

  const handleImageError = useCallback(() => {
    setImageState('error');
  }, []);

  const closeModal = useCallback(async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    setShowExpandedImage(false);
  }, []);

  const renderPlaceholder = useCallback(() => {
    const placeholder = (
      <View
        style={[
          styles.placeholder,
          imageSize,
          { backgroundColor: themeColors.primary + '20' },
          style,
        ]}>
        {showInitials && (
          <Text
            style={[
              styles.initials,
              { fontSize: Math.min(size * 0.26, 26), color: themeColors.primary },
            ]}>
            {initials}
          </Text>
        )}
      </View>
    );

    return expandable ? (
      <Pressable
        style={({ pressed }) => [{ opacity: pressed ? 0.8 : 1 }]}
        onPress={handleImagePress}>
        {placeholder}
      </Pressable>
    ) : (
      placeholder
    );
  }, [
    imageSize,
    style,
    showInitials,
    size,
    initials,
    expandable,
    handleImagePress,
    themeColors.primary,
  ]);

  const renderImage = useCallback(() => {
    if (!shouldShowImage || imageState === 'error' || imageState === 'placeholder') {
      return renderPlaceholder();
    }

    const imageContent = (
      <View style={[imageSize, style]}>
        <Image
          source={{ uri: imageUrl }}
          style={[imageSize, { position: 'absolute' }]}
          onLoad={handleImageLoad}
          onError={handleImageError}
          resizeMode="cover"
          {...props}
        />
        {imageState === 'loading' && (
          <View style={[styles.loadingContainer, imageSize]}>
            <ActivityIndicator size="small" color={themeColors.primary} />
          </View>
        )}
      </View>
    );

    return expandable ? (
      <Pressable
        style={({ pressed }) => [{ opacity: pressed ? 0.8 : 1 }]}
        onPress={handleImagePress}>
        {imageContent}
      </Pressable>
    ) : (
      imageContent
    );
  }, [
    shouldShowImage,
    imageState,
    renderPlaceholder,
    imageSize,
    style,
    imageUrl,
    handleImageLoad,
    handleImageError,
    props,
    expandable,
    handleImagePress,
    themeColors.primary,
  ]);

  return (
    <>
      {renderImage()}

      <ImageModal visible={showExpandedImage} onClose={closeModal} source={imageUrl} name={name} />
    </>
  );
});

const styles = StyleSheet.create({
  placeholder: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 8,
  },
  initials: {
    fontWeight: Platform.OS === 'ios' ? '600' : '700',
    textAlign: 'center',
  },
  loadingContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    position: 'absolute',
  },
});
