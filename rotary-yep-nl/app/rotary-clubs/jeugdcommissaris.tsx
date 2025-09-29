import React from 'react';
import { 
  StyleSheet, 
  View, 
  Text, 
  FlatList, 
  Pressable,
  Platform
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

interface DocumentItem {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  pdfUrl: string;
}

const renderDocumentItem = ({ item }: { item: DocumentItem }) => {
  const handlePress = () => {
    router.push({
      pathname: '/pdf-viewer',
      params: {
        url: item.pdfUrl,
        title: item.title
      }
    });
  };

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
    >
      <View style={styles.documentContent}>
        <View style={styles.iconContainer}>
          <FontAwesome5 name={item.icon} size={20} color="#007AFF" />
        </View>
        <View style={styles.textContainer}>
          <Text style={styles.documentTitle}>{item.title}</Text>
          <Text style={styles.documentSubtext}>Tik om PDF te openen</Text>
        </View>
        <Ionicons 
          name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'} 
          size={18} 
          color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'} 
        />
      </View>
    </Pressable>
  );
};

export default function JeugdcommissarisScreen() {
  const documents: DocumentItem[] = [
    {
      title: 'Handboek Jeugdcommissaris',
      icon: 'book' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/handboek-jeugdcommissaris-versie-2025-2026-def.pdf'
    },
    {
      title: 'Document huisbezoek',
      icon: 'suitcase-rolling' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/huisbezoek-gastgezinnen-24-25-def.pdf'
    },
    {
      title: 'Verzamelformulier VOG gegevens',
      icon: 'passport' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/formulier-aanlevering-vog-aanvragen-2022-2023.pdf'
    },
    {
      title: 'Verklaring Jeugd Vrijwilliger (VJV)',
      icon: 'hands-helping' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/24-25/verklaring-jeugd-vrijwilliger-gedragscode-mdjc-jan23-definitieve-versie.pdf'
    },
    {
      title: 'Presentielijst DJC training',
      icon: 'euro-sign' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/presentielijst-training-clubs-gastouders-24-25.pdf'
    },
    {
      title: 'Schooldocument',
      icon: 'school' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/rotary-exchange-voor-middelbare-scholen-2022-2023.pdf'
    },
    {
      title: 'Actielijst voorbereiding komst Jaarkind',
      icon: 'clipboard-list' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/24-25/actielijst-rotary-clubs-2025-2026-voorbereiding-ontvangst-inbound-student-def.pdf'
    },
    {
      title: 'Rules and Information Inbounds',
      icon: 'balance-scale-left' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/24-25rules-and-information-for-inbound-exchange-students-to-the-netherlands.pdf'
    },
    {
      title: 'Reis Regels',
      icon: 'suitcase-rolling' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl: 'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/travel-rules-within-and-outside-the-netherlands-2024-2025.pdf'
    }
  ];

  const ListHeaderComponent = () => (
    <View style={styles.content}>
      <Text style={styles.description}>
        Hier vindt u alle belangrijke documenten en informatie voor jeugdcommissarissen.
      </Text>
    </View>
  );

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <Pressable 
          style={({ pressed }) => [
            styles.backButton,
            pressed && styles.backButtonPressed
          ]}
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons 
            name={Platform.OS === 'ios' ? 'chevron-back' : 'arrow-back'} 
            size={Platform.OS === 'ios' ? 28 : 24} 
            color={Platform.OS === 'ios' ? '#007AFF' : '#1A237E'} 
          />
        </Pressable>
        <Text style={styles.headerTitle}>Info Jeugdcommissaris</Text>
        <View style={styles.placeholder} />
      </View>

      <FlatList
        data={documents}
        renderItem={renderDocumentItem}
        keyExtractor={(item, index) => index.toString()}
        ListHeaderComponent={ListHeaderComponent}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.listContainer}
      />
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
  backButtonPressed: {
    opacity: Platform.OS === 'ios' ? 0.6 : 0.8,
    backgroundColor: Platform.OS === 'ios' ? 'rgba(0, 122, 255, 0.1)' : '#E0E0E0',
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
  listContainer: {
    paddingBottom: Platform.OS === 'ios' ? 20 : 16,
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
  documentItem: {
    backgroundColor: '#fff',
    borderRadius: Platform.OS === 'ios' ? 10 : 8,
    marginBottom: Platform.OS === 'ios' ? 6 : 12,
    marginHorizontal: Platform.OS === 'ios' ? 16 : 20,
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
  documentItemPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
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