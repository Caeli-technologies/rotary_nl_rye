import React, { useState, useEffect, useLayoutEffect, useCallback } from 'react';
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  ActivityIndicator,
  Alert,
  Platform,
  Share,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams, useNavigation } from 'expo-router';
import PdfRendererView from 'react-native-pdf-renderer';
import { File, Paths } from 'expo-file-system';
import { useTheme } from '@/hooks/use-theme';
export default function PDFViewerScreen() {
  const { colors: themeColors } = useTheme();

  const navigation = useNavigation();
  const { url, title } = useLocalSearchParams<{
    url: string;
    title: string;
  }>();

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [localFilePath, setLocalFilePath] = useState<string | null>(null);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);

  const downloadPDF = useCallback(async () => {
    if (!url) {
      setError('No PDF URL provided');
      setLoading(false);
      return;
    }

    try {
      setLoading(true);
      setError(null);

      // Generate filename from URL or use default
      const filename = url.split('/').pop()?.split('?')[0] || 'document.pdf';
      // Use Documents directory instead of cache for sharing compatibility
      const file = new File(Paths.document, 'pdfs', filename);

      // Check if file already exists
      if (file.exists) {
        setLocalFilePath(file.uri);
        setLoading(false);
        return;
      }

      // Safely create directory if it doesn't exist
      try {
        if (!file.parentDirectory.exists) {
          file.parentDirectory.create();
        }
      } catch (dirError) {
        // Directory might already exist or be created by another process
        console.log('Directory creation handled:', dirError);
      }

      // Download the PDF using the new File.downloadFileAsync method
      const downloadedFile = await File.downloadFileAsync(url, file.parentDirectory);

      setLocalFilePath(downloadedFile.uri);
    } catch (error) {
      console.error('PDF download error:', error);
      setError('Failed to load PDF');
    } finally {
      setLoading(false);
    }
  }, [url]);

  const handleShare = useCallback(async () => {
    if (!localFilePath) return;

    try {
      await Share.share(
        {
          url: localFilePath,
          title: title || 'PDF Document',
        },
        {
          dialogTitle: `Share ${title || 'PDF Document'}`,
        },
      );
    } catch {
      Alert.alert('Share Error', 'Failed to share the PDF file.');
    }
  }, [localFilePath, title]);

  const handlePageChange = useCallback(
    (current: number, total: number) => {
      setCurrentPage(current);
      setTotalPages(total);
      if (loading && total > 0) {
        setLoading(false);
      }
    },
    [loading],
  );

  const handleError = useCallback((error?: string) => {
    console.error('PDF rendering error:', error);
    setError(error || 'Failed to load PDF document');
    setLoading(false);
  }, []);

  // Configure navigation header with share button and page info
  useLayoutEffect(() => {
    navigation.setOptions({
      title: title || 'PDF Document',
      headerTitle: () => (
        <View style={{ alignItems: 'center' }}>
          <Text
            style={{
              fontSize: Platform.OS === 'ios' ? 18 : 20,
              fontWeight: '600',
              textAlign: 'center',
              color: themeColors.text,
            }}
            numberOfLines={1}>
            {title || 'PDF Document'}
          </Text>
          {totalPages > 0 && (
            <Text
              style={{
                fontSize: 13,
                fontWeight: '400',
                marginTop: 2,
                color: themeColors.textSecondary,
              }}>
              Page {currentPage + 1} of {totalPages}
            </Text>
          )}
        </View>
      ),
      headerRight: () =>
        localFilePath && !loading ? (
          <Pressable
            onPress={handleShare}
            style={({ pressed }) => ({
              padding: 8,
              borderRadius: 6,
              backgroundColor: pressed ? themeColors.surface : 'transparent',
            })}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
            <Ionicons name="share-outline" size={24} color={themeColors.link} />
          </Pressable>
        ) : null,
    });
  }, [
    navigation,
    title,
    localFilePath,
    loading,
    currentPage,
    totalPages,
    handleShare,
    themeColors.link,
    themeColors.text,
    themeColors.textSecondary,
  ]);

  useEffect(() => {
    downloadPDF();

    // Cleanup function - optional: remove cached file on unmount if needed
    return () => {
      // Could implement cache cleanup logic here if needed
    };
  }, [downloadPDF, url]);

  if (error) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['bottom']}>
        <View style={styles.container}>
          <View style={styles.content}>
            <Ionicons name="alert-circle-outline" size={64} color="#ff6b6b" />
            <Text style={[styles.errorText, { color: '#ff6b6b' }]}>{error}</Text>
            <Pressable
              style={[styles.retryButton, { backgroundColor: themeColors.link }]}
              onPress={downloadPDF}>
              <Text style={[styles.buttonText, { color: themeColors.card }]}>Try Again</Text>
            </Pressable>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  if (loading || !localFilePath) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['bottom']}>
        <View style={styles.container}>
          <View style={styles.content}>
            <ActivityIndicator size="large" color={themeColors.link} />
            <Text style={[styles.loadingText, { color: themeColors.textSecondary }]}>
              Loading PDF...
            </Text>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView
      style={[styles.safeArea, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <View style={[styles.container, { backgroundColor: themeColors.background }]}>
        <PdfRendererView
          source={localFilePath}
          style={styles.pdf}
          distanceBetweenPages={16}
          maxZoom={20}
          maxPageResolution={2048}
          onPageChange={handlePageChange}
          onError={handleError}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  pdf: {
    flex: 1,
  },
  errorText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#ff6b6b',
    textAlign: 'center',
    marginVertical: 20,
  },
  loadingText: {
    fontSize: 16,
    fontWeight: '400',
    marginTop: 16,
  },
  retryButton: {
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
  pageIndicatorContainer: {
    position: 'absolute',
    bottom: 32,
    left: 0,
    right: 0,
    alignItems: 'center',
    pointerEvents: 'none',
  },
  pageIndicator: {
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    color: 'white',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
    fontSize: 14,
    fontWeight: '500',
    textAlign: 'center',
  },
});
