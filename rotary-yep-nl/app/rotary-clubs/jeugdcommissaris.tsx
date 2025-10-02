import React, { useCallback } from 'react';
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';

interface DocumentItem {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  pdfUrl: string;
}

export default function JeugdcommissarisScreen() {
  const handleDocumentPress = useCallback(async (pdfUrl: string, title: string) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push({
        pathname: '/pdf-viewer',
        params: {
          url: pdfUrl,
          title: title,
        },
      });
    } catch (error) {
      console.error('Error opening PDF:', error);
      router.push({
        pathname: '/pdf-viewer',
        params: {
          url: pdfUrl,
          title: title,
        },
      });
    }
  }, []);

  const renderDocumentItem = useCallback(
    ({ item }: { item: DocumentItem }) => {
      return (
        <Pressable
          style={({ pressed }) => [styles.documentItem, pressed && styles.documentItemPressed]}
          onPress={() => handleDocumentPress(item.pdfUrl, item.title)}
          android_ripple={{
            color: 'rgba(0, 122, 255, 0.2)',
            borderless: false,
          }}
          accessibilityRole="button"
          accessibilityLabel={`Open ${item.title} PDF document`}
          accessibilityHint="Tap to view PDF in document viewer"
          hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
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
    },
    [handleDocumentPress],
  );

  const documents: DocumentItem[] = [
    {
      title: 'Handboek Jeugdcommissaris',
      icon: 'book' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/handboek-jeugdcommissaris-versie-2025-2026-def.pdf',
    },
    {
      title: 'Document huisbezoek',
      icon: 'suitcase-rolling' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/huisbezoek-gastgezinnen-24-25-def.pdf',
    },
    {
      title: 'Verzamelformulier VOG gegevens',
      icon: 'passport' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/formulier-aanlevering-vog-aanvragen-2022-2023.pdf',
    },
    {
      title: 'Verklaring Jeugd Vrijwilliger (VJV)',
      icon: 'hands-helping' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/24-25/verklaring-jeugd-vrijwilliger-gedragscode-mdjc-jan23-definitieve-versie.pdf',
    },
    {
      title: 'Presentielijst DJC training',
      icon: 'euro-sign' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/presentielijst-training-clubs-gastouders-24-25.pdf',
    },
    {
      title: 'Schooldocument',
      icon: 'school' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/rotary-exchange-voor-middelbare-scholen-2022-2023.pdf',
    },
    {
      title: 'Actielijst voorbereiding komst Jaarkind',
      icon: 'clipboard-list' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/24-25/actielijst-rotary-clubs-2025-2026-voorbereiding-ontvangst-inbound-student-def.pdf',
    },
    {
      title: 'Rules and Information Inbounds',
      icon: 'balance-scale-left' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/def-25-26-rules-and-information-for-inbounds-to-the-netherlands1.pdf',
    },
    {
      title: 'Reis Regels',
      icon: 'suitcase-rolling' as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/travel-rules-within-and-outside-the-netherlands-2024-2025.pdf',
    },
  ];

  const ListHeaderComponent = useCallback(
    () => (
      <View style={styles.content}>
        <Text style={styles.description}>
          Hier vindt u alle belangrijke documenten en informatie voor jeugdcommissarissen.
        </Text>
      </View>
    ),
    [],
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <View style={styles.container}>
        <FlatList
          data={documents}
          renderItem={renderDocumentItem}
          keyExtractor={useCallback((item: DocumentItem) => item.pdfUrl, [])}
          ListHeaderComponent={ListHeaderComponent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
          contentContainerStyle={styles.listContainer}
          removeClippedSubviews={true}
          maxToRenderPerBatch={10}
          windowSize={10}
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
