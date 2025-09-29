import React from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  ScrollView, 
  TouchableOpacity,
  TouchableNativeFeedback,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

interface DocumentItemProps {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  pdfUrl: string;
}

function DocumentItem({ title, icon, pdfUrl }: DocumentItemProps) {
  const handlePress = () => {
    router.push({
      pathname: '/pdf-viewer',
      params: {
        url: pdfUrl,
        title: title
      }
    });
  };

  const content = (
    <View style={styles.documentContent}>
      <View style={styles.iconContainer}>
        <FontAwesome5 name={icon} size={20} color="#007AFF" />
      </View>
      <View style={styles.textContainer}>
        <Text style={styles.documentTitle}>{title}</Text>
        <Text style={styles.documentSubtext}>Tik om PDF te openen</Text>
      </View>
      <Ionicons 
        name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'} 
        size={18} 
        color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'} 
      />
    </View>
  );

  if (Platform.OS === 'android') {
    return (
      <View style={styles.documentItem}>
        <TouchableNativeFeedback
          onPress={handlePress}
          background={TouchableNativeFeedback.Ripple('rgba(0, 122, 255, 0.2)', false)}
        >
          {content}
        </TouchableNativeFeedback>
      </View>
    );
  }

  return (
    <TouchableOpacity 
      style={styles.documentItem} 
      onPress={handlePress}
      activeOpacity={0.6}
    >
      {content}
    </TouchableOpacity>
  );
}

export default function CounselorScreen() {
  const documents = [
    {
      title: 'Handboek Counselor',
      icon: 'hands-helping' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/handboek-counselor-versie-2025-2026-def.pdf'
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
    <SafeAreaView style={styles.container} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <TouchableOpacity 
          style={styles.backButton} 
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons 
            name={Platform.OS === 'ios' ? 'chevron-back' : 'arrow-back'} 
            size={Platform.OS === 'ios' ? 28 : 24} 
            color={Platform.OS === 'ios' ? '#007AFF' : '#1A237E'} 
          />
        </TouchableOpacity>
        <Text style={styles.headerTitle}>Info Counselor</Text>
        <View style={styles.placeholder} />
      </View>

      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          <Text style={styles.description}>
            Informatie en handleidingen voor counselors die exchange students begeleiden.
          </Text>
          
          <View style={styles.documentsContainer}>
            {documents.map((document, index) => (
              <DocumentItem
                key={index}
                title={document.title}
                icon={document.icon}
                pdfUrl={document.pdfUrl}
              />
            ))}
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#F5F5F5',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: Platform.OS === 'ios' ? 15 : 12,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#FFFFFF',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 1,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  backButton: {
    width: Platform.OS === 'ios' ? 32 : 40,
    height: Platform.OS === 'ios' ? 32 : 40,
    borderRadius: Platform.OS === 'ios' ? 16 : 20,
    backgroundColor: Platform.OS === 'ios' ? 'transparent' : '#F5F5F5',
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 17 : 18,
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    color: Platform.OS === 'ios' ? '#000' : '#1A237E',
    textAlign: 'center',
    flex: 1,
  },
  placeholder: {
    width: Platform.OS === 'ios' ? 32 : 40,
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 20,
  },
  description: {
    fontSize: Platform.OS === 'ios' ? 16 : 15,
    lineHeight: Platform.OS === 'ios' ? 22 : 20,
    color: Platform.OS === 'ios' ? '#8E8E93' : '#666',
    marginBottom: Platform.OS === 'ios' ? 20 : 24,
    textAlign: 'center',
    paddingHorizontal: Platform.OS === 'ios' ? 0 : 10,
  },
  documentsContainer: {
    flex: 1,
    paddingBottom: Platform.OS === 'ios' ? 20 : 16,
  },
  documentItem: {
    backgroundColor: '#fff',
    borderRadius: Platform.OS === 'ios' ? 10 : 8,
    marginBottom: Platform.OS === 'ios' ? 6 : 12,
    overflow: 'hidden',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.05,
        shadowRadius: 2,
      },
      android: {
        elevation: 1,
      },
    }),
  },
  documentContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Platform.OS === 'ios' ? 12 : 16,
    minHeight: Platform.OS === 'ios' ? 60 : 72,
  },
  iconContainer: {
    width: Platform.OS === 'ios' ? 32 : 40,
    height: Platform.OS === 'ios' ? 32 : 40,
    borderRadius: Platform.OS === 'ios' ? 8 : 20,
    backgroundColor: Platform.OS === 'ios' ? '#E5F4FD' : '#F5F5F5',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: Platform.OS === 'ios' ? 12 : 15,
  },
  textContainer: {
    flex: 1,
    paddingRight: 8,
  },
  documentTitle: {
    fontSize: Platform.OS === 'ios' ? 17 : 16,
    fontWeight: Platform.OS === 'ios' ? '400' : '600',
    color: Platform.OS === 'ios' ? '#000' : '#333',
    marginBottom: Platform.OS === 'ios' ? 2 : 4,
    lineHeight: Platform.OS === 'ios' ? 22 : 20,
  },
  documentSubtext: {
    fontSize: Platform.OS === 'ios' ? 13 : 14,
    color: Platform.OS === 'ios' ? '#8E8E93' : '#666',
  },
});