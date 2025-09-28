import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  ActivityIndicator,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { router, useLocalSearchParams } from 'expo-router';
import PdfRendererView from 'react-native-pdf-renderer';
import { File, Directory, Paths } from 'expo-file-system';
import { fetch } from 'expo/fetch';

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
      const filename = url.split('/').pop() || 'document.pdf';
      const documentsDir = new Directory(Paths.document);
      const localFile = new File(documentsDir, filename);
      
      const response = await fetch(url);
      if (!response.ok) {
        throw new Error(`Failed to download PDF: ${response.status}`);
      }
      
      const arrayBuffer = await response.arrayBuffer();
      await localFile.write(new Uint8Array(arrayBuffer));
      
      setLocalFilePath(localFile.uri);
    } catch (err) {
      console.error('Error downloading PDF:', err);
      setError('Failed to download PDF');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    downloadPDF();
  }, [url]);

  const handlePageChange = (current: number, total: number) => {
    setCurrentPage(current);
    setTotalPages(total);
    // Ensure loading is false once PDF is rendered and pages are available
    if (loading && total > 0) {
      setLoading(false);
    }
  };

  const handleError = () => {
    setError('Failed to load PDF');
    setLoading(false);
  };

  if (error) {
    return (
      <View style={styles.container}>
        <View style={styles.header}>
          <TouchableOpacity 
            style={styles.backButton} 
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={24} color="#fff" />
          </TouchableOpacity>
          <Text style={styles.title}>PDF Viewer</Text>
          <View style={styles.placeholder} />
        </View>
        <View style={styles.centered}>
          <Ionicons name="alert-circle" size={64} color="#ff6b6b" />
          <Text style={styles.errorText}>{error}</Text>
        </View>
      </View>
    );
  }

  if (loading || !localFilePath) {
    return (
      <View style={styles.container}>
        <View style={styles.header}>
          <TouchableOpacity 
            style={styles.backButton} 
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={24} color="#fff" />
          </TouchableOpacity>
          <Text style={styles.title}>{title || 'PDF Viewer'}</Text>
          <View style={styles.placeholder} />
        </View>
        <View style={styles.centered}>
          <ActivityIndicator size="large" color="#1f4e79" />
          <Text style={styles.loadingText}>Loading PDF...</Text>
        </View>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton} 
          onPress={() => router.back()}
        >
          <Ionicons name="arrow-back" size={24} color="#fff" />
        </TouchableOpacity>
        <View style={styles.titleContainer}>
          <Text style={styles.title} numberOfLines={1}>
            {title || 'PDF Viewer'}
          </Text>
          {totalPages > 0 && (
            <Text style={styles.pageInfo}>
              {currentPage + 1} of {totalPages}
            </Text>
          )}
        </View>
        <View style={styles.placeholder} />
      </View>

      <PdfRendererView
        source={localFilePath}
        style={styles.pdf}
        distanceBetweenPages={16}
        maxZoom={3}
        onPageChange={handlePageChange}
        onError={handleError}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    paddingTop: 50,
    paddingHorizontal: 20,
    paddingBottom: 20,
    backgroundColor: '#1f4e79',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  backButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  titleContainer: {
    flex: 1,
    alignItems: 'center',
    marginHorizontal: 10,
  },
  title: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  pageInfo: {
    color: '#fff',
    fontSize: 12,
    opacity: 0.8,
    marginTop: 2,
  },
  placeholder: {
    width: 40,
  },
  pdf: {
    flex: 1,
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  errorText: {
    marginTop: 16,
    fontSize: 18,
    fontWeight: 'bold',
    color: '#ff6b6b',
    textAlign: 'center',
  },
  errorSubtext: {
    marginTop: 8,
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
  },
});