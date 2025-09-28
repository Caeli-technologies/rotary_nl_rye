import React, { useState, useEffect } from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView, 
  TouchableOpacity, 
  ActivityIndicator,
  RefreshControl,
  Alert
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router } from 'expo-router';
import { fetch } from 'expo/fetch';

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
    <TouchableOpacity style={styles.newsCard} onPress={onPress} activeOpacity={0.7}>
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
    </TouchableOpacity>
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
          <ActivityIndicator size="large" color="#1f4e79" />
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
          <TouchableOpacity style={styles.retryButton} onPress={() => fetchNews()}>
            <Text style={styles.retryText}>Try Again</Text>
          </TouchableOpacity>
        </View>
      );
    }
    
    return null;
  };

  const centeredContent = renderCenteredContent();
  if (centeredContent) {
    return (
      <View style={styles.container}>
        <View style={styles.header}>
          <TouchableOpacity 
            style={styles.backButton} 
            onPress={() => router.back()}
          >
            <Ionicons name="arrow-back" size={24} color="#fff" />
          </TouchableOpacity>
          <Text style={styles.title}>News</Text>
          <View style={styles.placeholder} />
        </View>
        {centeredContent}
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
        <Text style={styles.title}>News</Text>
        <View style={styles.placeholder} />
      </View>
      
      <ScrollView
        style={styles.content}
        showsVerticalScrollIndicator={false}
        refreshControl={
          <RefreshControl
            refreshing={refreshing}
            onRefresh={handleRefresh}
            colors={['#1f4e79']}
            tintColor="#1f4e79"
          />
        }
      >
        <View style={styles.newsContainer}>
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
        </View>
      </ScrollView>
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
  title: {
    color: '#fff',
    fontSize: 28,
    fontWeight: 'bold',
    flex: 1,
    textAlign: 'center',
  },
  placeholder: {
    width: 40,
  },
  content: {
    flex: 1,
  },
  newsContainer: {
    padding: 16,
  },
  newsCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
    overflow: 'hidden',
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
    fontWeight: 'bold',
    color: '#1A237E',
    marginBottom: 8,
    lineHeight: 22,
  },
  newsDescription: {
    fontSize: 14,
    color: '#666',
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
    backgroundColor: '#1f4e79',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
  },
  retryText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
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