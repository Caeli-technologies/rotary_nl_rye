import React, {
  useState,
  useEffect,
  useLayoutEffect,
  useCallback,
} from 'react';
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  ActivityIndicator,
  Alert,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams, useNavigation } from 'expo-router';
import PdfRendererView from 'react-native-pdf-renderer';
import { File, Directory, Paths } from 'expo-file-system';
import { StatusBar } from 'expo-status-bar';
import * as Sharing from 'expo-sharing';

export default function PDFViewerScreen() {
  const navigation = useNavigation();
  const { url, title } = useLocalSearchParams<{
    url: string;
    title: string;
  }>();

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [localFilePath, setLocalFilePath] = useState<string | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
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

      const filename = url.split('/').pop() || 'document.pdf';
      const documentsDir = new Directory(Paths.document);
      const localFile = new File(documentsDir, filename);

      if (localFile.exists) {
        setLocalFilePath(localFile.uri);
        setLoading(false);
        return;
      }

      // Download the PDF using fetch and write using the File API
      const response = await fetch(url);
      if (!response.ok) {
        throw new Error('Failed to download PDF');
      }

      const arrayBuffer = await response.arrayBuffer();
      const base64String = btoa(
        String.fromCharCode(...new Uint8Array(arrayBuffer)),
      );
      localFile.write(base64String, { encoding: 'base64' });

      setLocalFilePath(localFile.uri);
    } catch {
      setError('Failed to load PDF');
    } finally {
      setLoading(false);
    }
  }, [url]);

  const handleShare = useCallback(async () => {
    if (!localFilePath) return;

    try {
      const isAvailable = await Sharing.isAvailableAsync();
      if (isAvailable) {
        await Sharing.shareAsync(localFilePath, {
          mimeType: 'application/pdf',
          dialogTitle: `Share ${title || 'PDF Document'}`,
        });
      }
    } catch {
      Alert.alert('Share Error', 'Failed to share the PDF file.');
    }
  }, [localFilePath, title]);

  const handlePageChange = (current: number, total: number) => {
    setCurrentPage(current);
    setTotalPages(total);
    if (loading && total > 0) {
      setLoading(false);
    }
  };

  const handleError = (error?: string) => {
    setError(error || 'Failed to load PDF document');
    setLoading(false);
  };

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
              color: '#1A237E',
              textAlign: 'center',
            }}
            numberOfLines={1}
          >
            {title || 'PDF Document'}
          </Text>
          {totalPages > 0 && (
            <Text
              style={{
                color: '#8E8E93',
                fontSize: 13,
                fontWeight: '400',
                marginTop: 2,
              }}
            >
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
              opacity: pressed ? 0.6 : 1,
              padding: 8,
            })}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            <Ionicons name="share-outline" size={24} color="#007AFF" />
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
  ]);

  useEffect(() => {
    downloadPDF();
  }, [downloadPDF, url]);

  if (error) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['bottom']}>
        
        <View style={styles.container}>
          <View style={styles.content}>
            <Ionicons name="alert-circle-outline" size={64} color="#ff6b6b" />
            <Text style={styles.errorText}>{error}</Text>
            <Pressable style={styles.retryButton} onPress={downloadPDF}>
              <Text style={styles.buttonText}>Try Again</Text>
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
            <ActivityIndicator size="large" color="#007AFF" />
            <Text style={styles.loadingText}>Loading PDF...</Text>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      
      <View style={styles.container}>
        <PdfRendererView
          source={localFilePath}
          style={styles.pdf}
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
    backgroundColor: '#F2F2F7',
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
    backgroundColor: '#F2F2F7',
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
    color: '#8E8E93',
    marginTop: 16,
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
