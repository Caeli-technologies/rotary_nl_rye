import React, { useState, useEffect, useMemo, useCallback } from 'react';
import {
  Image,
  ImageProps,
  ActivityIndicator,
  View,
  StyleSheet,
  Pressable,
  Modal,
  Dimensions,
  Platform,
  Text,
} from 'react-native';
import { useTheme } from '@/hooks/use-theme';
import { SafeAreaView } from 'react-native-safe-area-context';
import { getInitials } from '@/utils/communications';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';

interface NetworkImageProps extends Omit<ImageProps, 'source'> {
  imageUrl?: string;
  name: string;
  size?: number;
  showInitials?: boolean;
  expandable?: boolean;
}

const { width: screenWidth, height: screenHeight } = Dimensions.get('window');

// Check if URL is valid for image loading
const isValidImageUrl = (url?: string): boolean => {
  return !!(url && !url.includes('Profile_avatar_placeholder_large.png'));
};

export function NetworkImage({
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

  const initials = useMemo(() => getInitials(name), [name]);

  const shouldShowImage = useMemo(() => isValidImageUrl(imageUrl), [imageUrl]);

  useEffect(() => {
    setImageState(shouldShowImage ? 'loading' : 'placeholder');
  }, [imageUrl, shouldShowImage]);

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

  const handleImageError = useCallback(
    (e: any) => {
      console.warn('Image failed to load:', imageUrl, e.nativeEvent?.error);
      setImageState('error');
    },
    [imageUrl],
  );

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
  }, [imageSize, style, showInitials, size, initials, expandable, handleImagePress]);

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
  ]);

  const renderExpandedContent = useCallback(() => {
    if (imageState === 'loaded' && shouldShowImage) {
      return <Image source={{ uri: imageUrl }} style={styles.expandedImage} resizeMode="contain" />;
    }

    return (
      <View style={[styles.expandedPlaceholder, { backgroundColor: themeColors.primary + '20' }]}>
        <Text style={[styles.expandedInitials, { color: themeColors.primary }]}>{initials}</Text>
      </View>
    );
  }, [imageState, shouldShowImage, imageUrl, initials]);

  return (
    <>
      {renderImage()}

      {showExpandedImage && (
        <Modal
          visible={showExpandedImage}
          animationType="fade"
          transparent={true}
          onRequestClose={closeModal}>
          <SafeAreaView
            style={[styles.modalOverlay, { backgroundColor: 'rgba(0, 0, 0, 0.95)' }]}
            edges={['top', 'left', 'right', 'bottom']}>
            <Pressable style={styles.modalBackground} onPress={closeModal}>
              <View style={styles.expandedImageContainer}>{renderExpandedContent()}</View>
            </Pressable>
            <Pressable
              style={({ pressed }) => [
                styles.closeButton,
                { backgroundColor: themeColors.surface + '99' },
                pressed && [
                  styles.closeButtonPressed,
                  { backgroundColor: themeColors.surface + 'CC' },
                ],
              ]}
              onPress={closeModal}>
              <Ionicons name="close" size={24} color={themeColors.onSurface} />
            </Pressable>
          </SafeAreaView>
        </Modal>
      )}
    </>
  );
}

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
  modalOverlay: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalBackground: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    width: '100%',
  },
  expandedImageContainer: {
    width: screenWidth * 0.9,
    height: screenWidth * 0.9,
    maxHeight: screenHeight * 0.7,
    justifyContent: 'center',
    alignItems: 'center',
  },
  expandedImage: {
    width: '100%',
    height: '100%',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
  },
  expandedPlaceholder: {
    width: screenWidth * 0.6,
    height: screenWidth * 0.6,
    borderRadius: (screenWidth * 0.6) / 2,
    alignItems: 'center',
    justifyContent: 'center',
  },
  expandedInitials: {
    fontSize: screenWidth * 0.15,
    fontWeight: Platform.OS === 'ios' ? '700' : '800',
    textAlign: 'center',
  },
  closeButton: {
    position: 'absolute',
    top: Platform.OS === 'ios' ? 20 : 30,
    right: 20,
    width: Platform.OS === 'ios' ? 44 : 48,
    height: Platform.OS === 'ios' ? 44 : 48,
    borderRadius: Platform.OS === 'ios' ? 22 : 24,
    alignItems: 'center',
    justifyContent: 'center',
  },
  closeButtonPressed: {
    opacity: 0.8,
    transform: [{ scale: 0.95 }],
  },
});
