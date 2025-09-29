import React, { useState, useEffect, useMemo, useCallback } from 'react';
import { Image, ImageProps, ActivityIndicator, View, StyleSheet, TouchableOpacity, Modal, Dimensions, Platform } from 'react-native';
import { ThemedView } from './themed-view';
import { ThemedText } from './themed-text';
import { getInitials } from '@/utils/communications';
import { Ionicons } from '@expo/vector-icons';

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
  const [imageState, setImageState] = useState<'loading' | 'loaded' | 'error' | 'placeholder'>(
    isValidImageUrl(imageUrl) ? 'loading' : 'placeholder'
  );
  const [showExpandedImage, setShowExpandedImage] = useState(false);

  const imageSize = useMemo(() => ({ 
    width: size, 
    height: size, 
    borderRadius: size / 2 
  }), [size]);

  const initials = useMemo(() => getInitials(name), [name]);

  const shouldShowImage = useMemo(() => isValidImageUrl(imageUrl), [imageUrl]);

  useEffect(() => {
    setImageState(shouldShowImage ? 'loading' : 'placeholder');
  }, [imageUrl, shouldShowImage]);

  const handleImagePress = useCallback(() => {
    if (expandable && imageState === 'loaded') {
      setShowExpandedImage(true);
    }
  }, [expandable, imageState]);

  const handleImageLoad = useCallback(() => {
    setImageState('loaded');
  }, []);

  const handleImageError = useCallback((e: any) => {
    console.warn('Image failed to load:', imageUrl, e.nativeEvent?.error);
    setImageState('error');
  }, [imageUrl]);

  const closeModal = useCallback(() => {
    setShowExpandedImage(false);
  }, []);

  const renderPlaceholder = useCallback(() => {
    const placeholder = (
      <ThemedView style={[styles.placeholder, imageSize, style]}>
        {showInitials && (
          <ThemedText style={[styles.initials, { fontSize: size * 0.3 }]}>
            {initials}
          </ThemedText>
        )}
      </ThemedView>
    );

    return expandable ? (
      <TouchableOpacity onPress={handleImagePress} activeOpacity={0.7}>
        {placeholder}
      </TouchableOpacity>
    ) : placeholder;
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
            <ActivityIndicator size="small" color="#1f4e79" />
          </View>
        )}
      </View>
    );

    return expandable ? (
      <TouchableOpacity onPress={handleImagePress} activeOpacity={0.7}>
        {imageContent}
      </TouchableOpacity>
    ) : imageContent;
  }, [shouldShowImage, imageState, renderPlaceholder, imageSize, style, imageUrl, handleImageLoad, handleImageError, props, expandable, handleImagePress]);

  const renderExpandedContent = useCallback(() => {
    if (imageState === 'loaded' && shouldShowImage) {
      return (
        <Image
          source={{ uri: imageUrl }}
          style={styles.expandedImage}
          resizeMode="contain"
        />
      );
    }
    
    return (
      <ThemedView style={styles.expandedPlaceholder}>
        <ThemedText style={styles.expandedInitials}>
          {initials}
        </ThemedText>
      </ThemedView>
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
          onRequestClose={closeModal}
        >
          <View style={styles.modalOverlay}>
            <TouchableOpacity 
              style={styles.modalBackground}
              onPress={closeModal}
              activeOpacity={1}
            >
              <View style={styles.expandedImageContainer}>
                {renderExpandedContent()}
              </View>
            </TouchableOpacity>
            <TouchableOpacity 
              style={styles.closeButton}
              onPress={closeModal}
            >
              <Ionicons name="close" size={24} color="#fff" />
            </TouchableOpacity>
          </View>
        </Modal>
      )}
    </>
  );
}

const styles = StyleSheet.create({
  placeholder: {
    backgroundColor: '#1f4e79',
    alignItems: 'center',
    justifyContent: 'center',
  },
  initials: {
    fontWeight: '600',
    color: '#fff',
  },
  loadingContainer: {
    backgroundColor: '#f0f0f0',
    alignItems: 'center',
    justifyContent: 'center',
    position: 'absolute',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.9)',
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
    borderRadius: 12,
  },
  expandedPlaceholder: {
    width: screenWidth * 0.6,
    height: screenWidth * 0.6,
    backgroundColor: '#1f4e79',
    borderRadius: (screenWidth * 0.6) / 2,
    alignItems: 'center',
    justifyContent: 'center',
  },
  expandedInitials: {
    fontSize: screenWidth * 0.15,
    fontWeight: '600',
    color: '#fff',
  },
  closeButton: {
    position: 'absolute',
    top: Platform.OS === 'ios' ? 60 : 40,
    right: 20,
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    alignItems: 'center',
    justifyContent: 'center',
  },
});