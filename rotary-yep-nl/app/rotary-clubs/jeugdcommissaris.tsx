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
          <Ionicons 
            name={Platform.OS === 'ios' ? 'chevron-back' : 'arrow-back'} 
            size={Platform.OS === 'ios' ? 28 : 24} 
            color="#007AFF" 
          />
        </Pressable>
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle}>Info Jeugdcommissaris</Text>
        </View>
        <View style={styles.placeholder} />
      </View>

      <View style={styles.container}>
        <FlatList
          data={documents}
          renderItem={renderDocumentItem}
          keyExtractor={(item, index) => index.toString()}
          ListHeaderComponent={ListHeaderComponent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
          contentContainerStyle={styles.listContainer}
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
  listContainer: {
    padding: 16,
    paddingBottom: 34,
  },
  content: {
    marginBottom: 16,
  },
  description: {
    fontSize: 15,
    lineHeight: 22,
    color: '#8E8E93',
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