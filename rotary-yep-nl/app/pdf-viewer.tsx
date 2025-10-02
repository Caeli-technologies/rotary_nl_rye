import React, { useState, useLayoutEffect, useRef } from 'react';
import { StyleSheet, View, Text, Pressable, Alert, Platform, Dimensions, ActivityIndicator } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams, useNavigation } from 'expo-router';
import Pdf from 'react-native-pdf';
import * as Sharing from 'expo-sharing';

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
      const isAvailable = await Sharing.isAvailableAsync();
      if (isAvailable) {
        await Sharing.shareAsync(url, {
          dialogTitle: `Share ${title || 'PDF Document'}`,
        });
      }
    } catch (shareError) {
      console.error('Share error:', shareError);
      Alert.alert('Share Error', 'Failed to share the PDF file.');
    }
  };

  const zoomIn = () => {
    const newScale = Math.min(scale * 1.2, 3);
    setScale(newScale);
  };

  const zoomOut = () => {
    const newScale = Math.max(scale / 1.2, 0.5);
    setScale(newScale);
  };

  const goToPage = (pageNumber: number) => {
    if (pdfRef.current && pageNumber >= 1 && pageNumber <= totalPages) {
      pdfRef.current.setPage(pageNumber);
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
          <Pressable
            onPress={zoomOut}
            style={[styles.controlButton, scale <= 0.5 && styles.disabledButton]}
            disabled={scale <= 0.5}>
            <Ionicons name="remove" size={20} color={scale <= 0.5 ? "#ccc" : "#007AFF"} />
          </Pressable>
          <Pressable
            onPress={zoomIn}
            style={[styles.controlButton, scale >= 3 && styles.disabledButton]}
            disabled={scale >= 3}>
            <Ionicons name="add" size={20} color={scale >= 3 ? "#ccc" : "#007AFF"} />
          </Pressable>
          <Pressable
            onPress={handleShare}
            style={styles.controlButton}>
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
          <Pressable style={styles.retryButton} onPress={() => {
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
    <SafeAreaView style={styles.container}>
      {loading && (
        <View style={styles.loadingOverlay}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.loadingText}>Loading PDF...</Text>
        </View>
      )}
      
      <View style={styles.pdfContainer}>
        <Pdf
          ref={pdfRef}
          source={source}
          scale={scale}
          minScale={0.5}
          maxScale={3}
          onLoadProgress={(percent) => {
            console.log(`Loading progress: ${percent}`);
          }}
          onLoadComplete={(numberOfPages, filePath, { width, height }, tableContents) => {
            console.log(`Number of pages: ${numberOfPages}`);
            console.log(`PDF dimensions: ${width}x${height}`);
            if (tableContents) {
              console.log('Table of contents:', tableContents);
            }
            setTotalPages(numberOfPages);
            setCurrentPage(1);
            setLoading(false);
          }}
          onPageChanged={(page, numberOfPages) => {
            console.log(`Current page: ${page}`);
            setCurrentPage(page);
            setTotalPages(numberOfPages);
          }}
          onError={(error) => {
            console.log('PDF Error:', error);
            setError('Failed to load PDF document. Please check the URL and try again.');
            setLoading(false);
          }}
          onPressLink={(uri) => {
            console.log(`Link pressed: ${uri}`);
          }}
          style={styles.pdf}
          enablePaging
          horizontal={false}
          enableRTL={false}
          enableAnnotationRendering={true}
          enableAntialiasing={true}
          fitPolicy={0}
          spacing={10}
        />
      </View>

      {/* Navigation Controls */}
      {totalPages > 1 && (
        <View style={styles.navigationContainer}>
          <Pressable
            onPress={() => goToPage(currentPage - 1)}
            style={[styles.navButton, currentPage === 1 && styles.disabledNavButton]}
            disabled={currentPage === 1}>
            <Ionicons name="chevron-back" size={24} color={currentPage === 1 ? "#ccc" : "#007AFF"} />
          </Pressable>
          
          <Text style={styles.pageIndicator}>
            {currentPage} / {totalPages}
          </Text>
          
          <Pressable
            onPress={() => goToPage(currentPage + 1)}
            style={[styles.navButton, currentPage === totalPages && styles.disabledNavButton]}
            disabled={currentPage === totalPages}>
            <Ionicons name="chevron-forward" size={24} color={currentPage === totalPages ? "#ccc" : "#007AFF"} />
          </Pressable>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'flex-start',
    alignItems: 'center',
    marginTop: 25,
  },
  pdfContainer: {
    flex: 1,
    width: Dimensions.get('window').width,
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
    borderRadius: 6,
    backgroundColor: 'rgba(0, 122, 255, 0.1)',
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
