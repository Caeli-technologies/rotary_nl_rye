import React, { useState, useEffect } from 'react';
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
import { router, useLocalSearchParams } from 'expo-router';
import PdfRendererView from 'react-native-pdf-renderer';
import { File, Directory, Paths } from 'expo-file-system';
import { StatusBar } from 'expo-status-bar';
import * as Sharing from 'expo-sharing';

export default function PDFViewerScreen() {
  const { url, title } = useLocalSearchParams<{
    url: string;
    title: string;
  }>();
  
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [localFilePath, setLocalFilePath] = useState<string | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);

  const downloadPDF = async () => {
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
      
      const response = await fetch(url);
      if (!response.ok) {
        throw new Error(`Failed to download PDF`);
      }
      
      const arrayBuffer = await response.arrayBuffer();
      await localFile.write(new Uint8Array(arrayBuffer));
      
      setLocalFilePath(localFile.uri);
    } catch (err) {
      setError('Failed to load PDF');
    } finally {
      setLoading(false);
    }
  };

  const handleShare = async () => {
    if (!localFilePath) return;
    
    try {
      const isAvailable = await Sharing.isAvailableAsync();
      if (isAvailable) {
        await Sharing.shareAsync(localFilePath, {
          mimeType: 'application/pdf',
          dialogTitle: `Share ${title || 'PDF Document'}`,
        });
      }
    } catch (error) {
      Alert.alert('Share Error', 'Failed to share the PDF file.');
    }
  };

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

  useEffect(() => {
    downloadPDF();
  }, [url]);

  if (error) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['top']}>
        <StatusBar style="auto" />
        <View style={styles.header}>
          <Pressable 
            style={({ pressed }) => [
              styles.headerButton,
              pressed && styles.headerButtonPressed
            ]}
            onPress={() => router.back()}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            <Ionicons name="chevron-back" size={28} color="#007AFF" />
          </Pressable>
          <View style={styles.headerTitleContainer}>
            <Text style={styles.headerTitle}>PDF Error</Text>
          </View>
          <View style={styles.placeholder} />
        </View>
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
      <SafeAreaView style={styles.safeArea} edges={['top']}>
        <StatusBar style="auto" />
        <View style={styles.header}>
          <Pressable 
            style={({ pressed }) => [
              styles.headerButton,
              pressed && styles.headerButtonPressed
            ]}
            onPress={() => router.back()}
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
          >
            <Ionicons name="chevron-back" size={28} color="#007AFF" />
          </Pressable>
          <View style={styles.headerTitleContainer}>
            <Text style={styles.headerTitle}>{title || 'PDF Viewer'}</Text>
          </View>
          <View style={styles.placeholder} />
        </View>
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
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <Pressable 
          style={({ pressed }) => [
            styles.headerButton,
            pressed && styles.headerButtonPressed
          ]}
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons name="chevron-back" size={28} color="#007AFF" />
        </Pressable>
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle} numberOfLines={1}>
            {title || 'PDF Document'}
          </Text>
          {totalPages > 0 && (
            <Text style={styles.pageInfo}>
              Page {currentPage + 1} of {totalPages}
            </Text>
          )}
        </View>
        <Pressable 
          style={({ pressed }) => [
            styles.headerButton,
            pressed && styles.headerButtonPressed
          ]}
          onPress={handleShare}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons name="share-outline" size={24} color="#007AFF" />
        </Pressable>
      </View>
      
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
    backgroundColor: '#FFFFFF',
  },
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'android' ? 16 : 8,
    paddingBottom: 16,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
  },
  headerButton: {
    width: 44,
    height: 44,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 22,
  },
  headerButtonPressed: {
    opacity: Platform.OS === 'ios' ? 0.6 : 0.8,
    backgroundColor: Platform.OS === 'ios' ? 'rgba(0, 122, 255, 0.1)' : '#E0E0E0',
  },
  headerTitleContainer: {
    flex: 1,
    alignItems: 'center',
    marginHorizontal: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 22,
    fontWeight: '600',
    color: '#000000',
    letterSpacing: Platform.OS === 'ios' ? -0.41 : 0,
    textAlign: 'center',
  },
  placeholder: {
    width: 44,
  },
  pageInfo: {
    color: '#8E8E93',
    fontSize: 13,
    fontWeight: '400',
    marginTop: 4,
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