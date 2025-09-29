import React, { useState, useEffect } from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView, 
  Pressable, 
  ActivityIndicator,
  RefreshControl,
  Alert,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router } from 'expo-router';
import { fetch } from 'expo/fetch';
import { StatusBar } from 'expo-status-bar';

interface NewsItem {
  id: number;
  images: string;
  pdf: string | null;
  title: string;
  description: string;
  isPdf: string;
  text?: Array<{
    heading?: string;
    body?: Array<{
      paragraph?: string[];
      videoUrl?: string;
      imageUrl?: string;
    }>;
  }>;
}

interface NewsData {
  news: NewsItem[];
}

function NewsCard({ item, onPress }: { item: NewsItem; onPress: () => void }) {
  return (
    <Pressable 
      style={({ pressed }) => [
        styles.newsCard,
        pressed && styles.newsCardPressed
      ]}
      onPress={onPress}
      android_ripple={{
        color: 'rgba(0, 122, 255, 0.2)',
        borderless: false
      }}
    >
      <View style={styles.cardContent}>
        <View style={styles.imageContainer}>
          <Image
            source={{ uri: item.images }}
            style={styles.newsImage}
            contentFit="cover"
            placeholder="https://via.placeholder.com/300x200/E0E0E0/999999?text=Loading"
          />
          {item.isPdf === "yes" && (
            <View style={styles.pdfBadge}>
              <Ionicons name="document-text" size={16} color="#fff" />
              <Text style={styles.pdfText}>PDF</Text>
            </View>
          )}
        </View>
        <View style={styles.textContainer}>
          <Text style={styles.newsTitle} numberOfLines={2}>
            {item.title}
          </Text>
          {item.description && (
            <Text style={styles.newsDescription} numberOfLines={3}>
              {item.description}
            </Text>
          )}
        </View>
      </View>
    </Pressable>
  );
}

export default function NewsScreen() {
  const [newsData, setNewsData] = useState<NewsItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchNews = async (isRefresh = false) => {
    try {
      if (!isRefresh) setLoading(true);
      setError(null);
      
      const response = await fetch('https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/news/news.json');
      
      if (!response.ok) {
        throw new Error(`Failed to load news: ${response.status}`);
      }
      
      const data: NewsData = await response.json();
      setNewsData(data.news || []);
    } catch (err) {
      console.error('Error fetching news:', err);
      setError(err instanceof Error ? err.message : 'Failed to load news');
    } finally {
      setLoading(false);
      if (isRefresh) setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchNews();
  }, []);

  const handleRefresh = () => {
    setRefreshing(true);
    fetchNews(true);
  };

  const handleNewsItemPress = (item: NewsItem) => {
    if (item.isPdf === "yes" && item.pdf) {
      router.push({
        pathname: '/pdf-viewer' as any,
        params: { url: item.pdf, title: item.title }
      });
    } else if (item.text?.length) {
      router.push({
        pathname: '/news/[id]' as any,
        params: { 
          id: item.id.toString(),
          title: item.title,
          content: JSON.stringify(item)
        }
      });
    } else {
      Alert.alert('Notice', 'This news item has no additional content available.');
    }
  };

  const renderCenteredContent = () => {
    if (loading && !refreshing) {
      return (
        <View style={styles.centered}>
          <ActivityIndicator size="large" color="#007AFF" />
          <Text style={styles.loadingText}>Loading news...</Text>
        </View>
      );
    }
    
    if (error && newsData.length === 0) {
      return (
        <View style={styles.centered}>
          <Ionicons name="alert-circle" size={64} color="#ff6b6b" />
          <Text style={styles.errorText}>Failed to load news</Text>
          <Text style={styles.errorSubtext}>{error}</Text>
          <Pressable style={styles.retryButton} onPress={() => fetchNews()}>
            <Text style={styles.retryText}>Try Again</Text>
          </Pressable>
        </View>
      );
    }
    
    return null;
  };

  const centeredContent = renderCenteredContent();
  if (centeredContent) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['top']}>
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
            <Text style={styles.headerTitle}>News</Text>
          </View>
          <View style={styles.placeholder} />
        </View>
        <View style={styles.container}>
          {centeredContent}
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
          <Text style={styles.headerTitle}>News</Text>
        </View>
        <View style={styles.placeholder} />
      </View>
      
      <View style={styles.container}>
        <ScrollView
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          refreshControl={
            <RefreshControl
              refreshing={refreshing}
              onRefresh={handleRefresh}
              colors={['#007AFF']}
              tintColor="#007AFF"
            />
          }
        >
          {newsData.length > 0 ? (
            newsData.map((item) => (
              <NewsCard
                key={item.id}
                item={item}
                onPress={() => handleNewsItemPress(item)}
              />
            ))
          ) : (
            <View style={styles.emptyState}>
              <Ionicons name="newspaper-outline" size={64} color="#ccc" />
              <Text style={styles.emptyText}>No news available</Text>
            </View>
          )}
        </ScrollView>
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
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 22,
    fontWeight: '600',
    color: '#000000',
    letterSpacing: Platform.OS === 'ios' ? -0.41 : 0,
  },
  placeholder: {
    width: 44,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 34,
  },
  newsCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    marginBottom: 12,
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
    overflow: 'hidden',
  },
  newsCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  cardContent: {
    flexDirection: 'row',
  },
  imageContainer: {
    width: 120,
    height: 100,
    position: 'relative',
  },
  newsImage: {
    width: '100%',
    height: '100%',
  },
  pdfBadge: {
    position: 'absolute',
    top: 8,
    right: 8,
    backgroundColor: 'rgba(31, 78, 121, 0.9)',
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 4,
  },
  pdfText: {
    color: '#fff',
    fontSize: 10,
    fontWeight: 'bold',
    marginLeft: 2,
  },
  textContainer: {
    flex: 1,
    padding: 16,
    justifyContent: 'center',
  },
  newsTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 8,
    lineHeight: 22,
  },
  newsDescription: {
    fontSize: 14,
    fontWeight: '400',
    color: '#8E8E93',
    lineHeight: 20,
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
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
  retryButton: {
    marginTop: 20,
    backgroundColor: '#007AFF',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
  },
  retryText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  emptyState: {
    alignItems: 'center',
    padding: 40,
  },
  emptyText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
  },
});