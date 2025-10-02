import React, { useState, useLayoutEffect, useRef } from 'react';
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  Alert,
  Platform,
  Dimensions,
  ActivityIndicator,
  Share,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams, useNavigation } from 'expo-router';
import Pdf from 'react-native-pdf';

export default function PDFViewerScreen() {
  const navigation = useNavigation();
  const pdfRef = useRef<Pdf>(null);
  const { url, title } = useLocalSearchParams<{
    url: string;
    title: string;
  }>();

  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [scale, setScale] = useState(1);

  const handleShare = async () => {
    if (!url) return;

    try {
      const result = await Share.share({
        message: `Check out this PDF: ${title || 'PDF Document'}`,
        url: url,
        title: title || 'PDF Document',
      });

      if (result.action === Share.sharedAction) {
        if (result.activityType) {
          // Shared with activity type
        } else {
          // Shared
        }
      } else if (result.action === Share.dismissedAction) {
        // Dismissed
      }
    } catch (shareError) {
      console.error('Share error:', shareError);
      Alert.alert('Share Error', 'Failed to share the PDF file.');
    }
  };

  // Configure navigation header with controls
  useLayoutEffect(() => {
    navigation.setOptions({
      title: title || 'PDF Document',
      headerTitle: () => (
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle} numberOfLines={1}>
            {title || 'PDF Document'}
          </Text>
          {totalPages > 0 && (
            <Text style={styles.pageInfo}>
              Page {currentPage} of {totalPages}
            </Text>
          )}
        </View>
      ),
      headerRight: () => (
        <View style={styles.headerControls}>
          <Pressable onPress={handleShare} style={styles.controlButton}>
            <Ionicons name="share-outline" size={20} color="#007AFF" />
          </Pressable>
        </View>
      ),
    });
  }, [navigation, title, currentPage, totalPages, scale]);

  if (!url) {
    return (
      <SafeAreaView style={styles.safeArea}>
        <View style={styles.centerContent}>
          <Ionicons name="alert-circle-outline" size={64} color="#ff6b6b" />
          <Text style={styles.errorText}>No PDF URL provided</Text>
        </View>
      </SafeAreaView>
    );
  }

  if (error) {
    return (
      <SafeAreaView style={styles.safeArea}>
        <View style={styles.centerContent}>
          <Ionicons name="alert-circle-outline" size={64} color="#ff6b6b" />
          <Text style={styles.errorText}>{error}</Text>
          <Pressable
            style={styles.retryButton}
            onPress={() => {
              setError(null);
              setLoading(true);
            }}>
            <Text style={styles.buttonText}>Try Again</Text>
          </Pressable>
        </View>
      </SafeAreaView>
    );
  }

  const source = { uri: url, cache: true };

  return (
    // <SafeAreaView style={styles.container}>
    <View style={styles.pdfContainer}>
      <Pdf
        ref={pdfRef}
        source={source}
        scale={scale}
        minScale={0.5}
        maxScale={3}
        onLoadProgress={(percent) => {
          // Loading progress tracking
        }}
        onLoadComplete={(numberOfPages, filePath, { width, height }, tableContents) => {
          setTotalPages(numberOfPages);
          setCurrentPage(1);
          setLoading(false);
        }}
        onPageChanged={(page, numberOfPages) => {
          setCurrentPage(page);
          setTotalPages(numberOfPages);
        }}
        onError={(error) => {
          setError('Failed to load PDF document. Please check the URL and try again.');
          setLoading(false);
        }}
        onPressLink={(uri) => {
          // Link pressed in PDF
        }}
        style={styles.pdf}
        enablePaging
        horizontal={false}
        enableRTL={false}
        enableAnnotationRendering={true}
        enableAntialiasing={true}
        enableDoubleTapZoom={true}
        fitPolicy={0}
        spacing={10}
      />
    </View>
    // </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'center',
  },
  pdfContainer: {
    flex: 1,
    width: Dimensions.get('window').width,
    height: Dimensions.get('window').height,
  },
  pdf: {
    flex: 1,
  },
  safeArea: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  centerContent: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  headerTitleContainer: {
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 18 : 20,
    fontWeight: '600',
    color: '#1A237E',
    textAlign: 'center',
  },
  pageInfo: {
    color: '#8E8E93',
    fontSize: 13,
    fontWeight: '400',
    marginTop: 2,
  },
  headerControls: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  controlButton: {
    padding: 8,
  },
  disabledButton: {
    opacity: 0.3,
    backgroundColor: 'rgba(0, 0, 0, 0.05)',
  },
  loadingOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.9)',
    zIndex: 1000,
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '500',
  },
  navigationContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 12,
    backgroundColor: '#fff',
    borderTopWidth: 1,
    borderTopColor: '#E5E5EA',
  },
  navButton: {
    padding: 12,
    borderRadius: 8,
    backgroundColor: 'rgba(0, 122, 255, 0.1)',
  },
  disabledNavButton: {
    opacity: 0.3,
    backgroundColor: 'rgba(0, 0, 0, 0.05)',
  },
  pageIndicator: {
    fontSize: 16,
    fontWeight: '500',
    color: '#1A237E',
    minWidth: 80,
    textAlign: 'center',
  },
  errorText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#ff6b6b',
    textAlign: 'center',
    marginVertical: 20,
  },
  retryButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
    marginTop: 20,
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});
