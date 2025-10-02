import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Pressable,
  Alert,
  Linking,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useLocalSearchParams } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

interface NewsText {
  heading?: string;
  body?: {
    paragraph?: string[];
    videoUrl?: string;
    imageUrl?: string;
  }[];
}

interface NewsItem {
  id: number;
  images: string;
  pdf: string | null;
  title: string;
  description: string;
  isPdf: string;
  text?: NewsText[];
}

export default function NewsDetailScreen() {
  const { id, title, content } = useLocalSearchParams<{
    id: string;
    title: string;
    content: string;
  }>();

  let newsItem: NewsItem | null = null;

  try {
    if (content) {
      newsItem = JSON.parse(content);
    }
  } catch (error) {
    console.error('Error parsing news content:', error);
  }

  if (!newsItem) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['bottom']}>
        
        <View style={styles.container}>
          <View style={styles.centered}>
            <Text style={styles.errorText}>News item not found</Text>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  const handleVideoPress = (videoUrl: string) => {
    Linking.openURL(videoUrl).catch((err) => {
      console.error('Error opening video:', err);
      Alert.alert('Error', 'Could not open video');
    });
  };

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      
      <View style={styles.container}>
        <ScrollView
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
        >
          {/* Header Image */}
          <View style={styles.imageContainer}>
            <Image
              source={{ uri: newsItem.images }}
              style={styles.headerImage}
              contentFit="cover"
              placeholder="https://via.placeholder.com/400x200/E0E0E0/999999?text=Loading"
            />
          </View>

          <View style={styles.contentContainer}>
            {/* Title */}
            <Text style={styles.newsTitle}>{newsItem.title}</Text>

            {/* Description */}
            {newsItem.description && (
              <Text style={styles.newsDescription}>{newsItem.description}</Text>
            )}

            {/* Content Sections */}
            {newsItem.text &&
              newsItem.text.map((section, sectionIndex) => (
                <View key={sectionIndex} style={styles.section}>
                  {section.heading && (
                    <Text style={styles.sectionHeading}>{section.heading}</Text>
                  )}

                  {section.body &&
                    section.body.map((bodyItem, bodyIndex) => (
                      <View key={bodyIndex} style={styles.bodyItem}>
                        {/* Paragraphs */}
                        {bodyItem.paragraph &&
                          bodyItem.paragraph.map(
                            (paragraph, paragraphIndex) => (
                              <Text
                                key={paragraphIndex}
                                style={styles.paragraph}
                              >
                                {paragraph}
                              </Text>
                            ),
                          )}

                        {/* Video */}
                        {bodyItem.videoUrl && (
                          <Pressable
                            style={styles.videoContainer}
                            onPress={() => handleVideoPress(bodyItem.videoUrl!)}
                          >
                            <View style={styles.videoPlaceholder}>
                              <Ionicons
                                name="play-circle"
                                size={64}
                                color="#007AFF"
                              />
                              <Text style={styles.videoText}>
                                Tap to play video
                              </Text>
                            </View>
                          </Pressable>
                        )}

                        {/* Image */}
                        {bodyItem.imageUrl && (
                          <View style={styles.contentImageContainer}>
                            <Image
                              source={{ uri: bodyItem.imageUrl }}
                              style={styles.contentImage}
                              contentFit="cover"
                              placeholder="https://via.placeholder.com/300x200/E0E0E0/999999?text=Loading"
                            />
                          </View>
                        )}
                      </View>
                    ))}
                </View>
              ))}
          </View>
        </ScrollView>
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
  scrollContent: {
    paddingBottom: 34,
  },
  imageContainer: {
    height: 200,
  },
  headerImage: {
    width: '100%',
    height: '100%',
  },
  contentContainer: {
    padding: 20,
    backgroundColor: '#FFFFFF',
  },
  newsTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 16,
    lineHeight: 32,
  },
  newsDescription: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    lineHeight: 24,
    marginBottom: 20,
  },
  section: {
    marginBottom: 24,
  },
  sectionHeading: {
    fontSize: 20,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 12,
    lineHeight: 28,
  },
  bodyItem: {
    marginBottom: 16,
  },
  paragraph: {
    fontSize: 16,
    fontWeight: '400',
    color: '#3C3C43',
    lineHeight: 24,
    marginBottom: 12,
  },
  videoContainer: {
    marginVertical: 16,
    borderRadius: 12,
    overflow: 'hidden',
    backgroundColor: '#f0f0f0',
  },
  videoPlaceholder: {
    height: 200,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#e8e8e8',
  },
  videoText: {
    marginTop: 8,
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '600',
  },
  contentImageContainer: {
    marginVertical: 16,
    borderRadius: 12,
    overflow: 'hidden',
  },
  contentImage: {
    width: '100%',
    height: 200,
  },
  centered: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  errorText: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#ff6b6b',
    textAlign: 'center',
  },
});
