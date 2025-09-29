import React, { useCallback } from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView, 
  Pressable,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import * as Haptics from 'expo-haptics';

interface DocumentItemProps {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  pdfUrl: string;
}

const DocumentItem = React.memo(({ title, icon, pdfUrl }: DocumentItemProps) => {
  const handlePress = useCallback(async () => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push({
        pathname: '/pdf-viewer',
        params: {
          url: pdfUrl,
          title: title
        }
      });
    } catch (error) {
      console.error('Error opening PDF:', error);
      router.push({
        pathname: '/pdf-viewer',
        params: {
          url: pdfUrl,
          title: title
        }
      });
    }
  }, [pdfUrl, title]);

  return (
    <Pressable 
      style={({ pressed }) => [
        styles.documentItem,
        pressed && styles.documentItemPressed
      ]}
      onPress={handlePress}
      android_ripple={{
        color: 'rgba(0, 122, 255, 0.2)',
        borderless: false
      }}
      accessibilityRole="button"
      accessibilityLabel={`Open ${title} PDF document`}
      accessibilityHint="Tap to view PDF in document viewer"
      hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
    >
      <View style={styles.documentContent}>
        <View style={styles.iconContainer}>
          <FontAwesome5 name={icon} size={22} color="#007AFF" />
        </View>
        <View style={styles.textContainer}>
          <Text style={styles.documentTitle}>{title}</Text>
          <Text style={styles.documentSubtext}>Tik om PDF te openen</Text>
        </View>
        <Ionicons 
          name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'} 
          size={20} 
          color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'} 
        />
      </View>
    </Pressable>
  );
});

export default function GastgezinScreen() {
  const renderDocument = useCallback((document: DocumentItemProps, index: number) => (
    <DocumentItem
      key={index}
      title={document.title}
      icon={document.icon}
      pdfUrl={document.pdfUrl}
    />
  ), []);

  const documents = [
    {
      title: 'Handboek Gastgezin',
      icon: 'home' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/handboek-gastgezin-versie-2025-2026-def.pdf'
    },
    {
      title: 'First Night Questions',
      icon: 'question-circle' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/questions-first-night-host-family.pdf'
    },
    {
      title: 'Travel rules within and outside the Netherlands',
      icon: 'suitcase-rolling' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/travel-rules-within-and-outside-the-netherlands-2024-2025.pdf'
    }
  ];

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <StatusBar style="auto" />
      <View style={styles.container}>
        <ScrollView 
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
        >
          <Text style={styles.description}>
            Informatie en documentatie voor gastgezinnen die een exchange student ontvangen.
          </Text>
          
          {documents.map(renderDocument)}
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
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 34,
  },
  description: {
    fontSize: 15,
    lineHeight: 22,
    color: '#8E8E93',
    marginBottom: 20,
    textAlign: 'center',
    paddingHorizontal: 16,
  },
  documentItem: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    marginBottom: 12,
    overflow: 'hidden',
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
  },
  documentItemPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  documentContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: 72,
  },
  iconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F2F2F7',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 16,
  },
  textContainer: {
    flex: 1,
    marginRight: 8,
  },
  documentTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 4,
    lineHeight: 22,
  },
  documentSubtext: {
    fontSize: 13,
    fontWeight: '400',
    color: '#8E8E93',
  },
});