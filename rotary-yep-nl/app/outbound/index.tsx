import React, { useCallback } from 'react';
import { FlatList, Platform, Pressable, StyleSheet, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { FontAwesome5, Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';

import * as Haptics from 'expo-haptics';

interface ProgramItem {
  title: string;
  subtitle: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
  enabled?: boolean;
}

export default function OutboundScreen() {
  const handleProgramPress = useCallback(async (route: string, enabled: boolean = true) => {
    if (!enabled) return;

    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push(route as any);
    } catch (error) {
      console.error('Error navigating to route:', error);
      router.push(route as any);
    }
  }, []);

  const renderProgramItem = useCallback(
    ({ item }: { item: ProgramItem }) => (
      <Pressable
        style={({ pressed }) => [
          styles.programItem,
          pressed && styles.programItemPressed,
          !item.enabled && styles.programItemDisabled,
        ]}
        onPress={() => handleProgramPress(item.route, item.enabled)}
        accessibilityRole="button"
        accessibilityLabel={item.title}
        accessibilityHint={
          item.enabled ? 'Tap to view program details' : 'This program is not yet available'
        }
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
        disabled={!item.enabled}>
        <View style={styles.programContent}>
          <View style={[styles.iconContainer, !item.enabled && styles.iconContainerDisabled]}>
            <FontAwesome5 name={item.icon} size={22} color={item.enabled ? '#007AFF' : '#8E8E93'} />
          </View>
          <View style={styles.textContainer}>
            <Text style={[styles.programTitle, !item.enabled && styles.programTitleDisabled]}>
              {item.title}
            </Text>
            <Text style={styles.programSubtitle}>{item.subtitle}</Text>
          </View>
          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'}
            size={20}
            color={item.enabled ? (Platform.OS === 'ios' ? '#C7C7CC' : '#666') : '#C7C7CC'}
          />
        </View>
      </Pressable>
    ),
    [handleProgramPress],
  );

  const longTermPrograms: ProgramItem[] = [
    {
      title: 'Long Term Exchange Program',
      subtitle: 'Year Exchange',
      icon: 'calendar-alt' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term',
      enabled: true,
    },
  ];

  const shortTermPrograms: ProgramItem[] = [
    {
      title: 'Zomerkampen',
      subtitle: 'Zomerkampen & Culturele Programmas',
      icon: 'campground' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/camps-and-tours',
      enabled: true,
    },
    {
      title: 'Family to Family',
      subtitle: 'Exchange between families',
      icon: 'home' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/family-to-family',
      enabled: true,
    },
  ];

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <Text style={styles.introTitle}>Kandidaten</Text>
        <Text style={styles.introText}>
          Wat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor uitwisseling.
          Wereldwijd gaan er jaarlijks zo&apos;n 8.000 studenten via Rotary op jaaruitwisseling, een
          hele organisatie.
        </Text>
      </View>
    ),
    [],
  );

  const SectionHeader = useCallback(
    ({ title }: { title: string }) => (
      <View style={styles.sectionHeaderContainer}>
        <Text style={styles.sectionHeaderTitle}>{title}</Text>
        <View style={styles.sectionHeaderDivider} />
      </View>
    ),
    [],
  );

  const renderContent = useCallback(() => {
    return [
      { type: 'intro' },
      { type: 'sectionHeader', title: 'Long Term Exchange Program' },
      ...longTermPrograms.map((item) => ({ type: 'program', item })),
      { type: 'spacer' },
      { type: 'sectionHeader', title: 'Short Term Exchange Program' },
      ...shortTermPrograms.map((item) => ({ type: 'program', item })),
    ];
  }, []);

  const renderItem = useCallback(
    ({ item }: { item: any }) => {
      switch (item.type) {
        case 'intro':
          return <IntroSection />;
        case 'sectionHeader':
          return <SectionHeader title={item.title} />;
        case 'program':
          return renderProgramItem({ item: item.item });
        case 'spacer':
          return <View style={styles.spacer} />;
        default:
          return null;
      }
    },
    [IntroSection, SectionHeader, renderProgramItem],
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <View style={styles.container}>
        <FlatList
          data={renderContent()}
          renderItem={renderItem}
          keyExtractor={useCallback((item: any, index: number) => `${item.type}-${index}`, [])}
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
  introContainer: {
    marginBottom: 32,
  },
  introTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
  },
  introText: {
    fontSize: 15,
    lineHeight: 22,
    color: '#3C3C43',
    textAlign: 'left',
  },
  sectionHeaderContainer: {
    marginBottom: 16,
    marginTop: 8,
  },
  sectionHeaderTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
  },
  sectionHeaderDivider: {
    height: 2,
    backgroundColor: '#E5E5EA',
    borderRadius: 1,
  },
  programItem: {
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
  programItemPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  programItemDisabled: {
    opacity: 0.6,
  },
  programContent: {
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
  iconContainerDisabled: {
    backgroundColor: '#F8F8F8',
  },
  textContainer: {
    flex: 1,
    marginRight: 8,
  },
  programTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 4,
    lineHeight: 22,
  },
  programTitleDisabled: {
    color: '#8E8E93',
  },
  programSubtitle: {
    fontSize: 13,
    fontWeight: '400',
    color: '#8E8E93',
  },
  spacer: {
    height: 10,
  },
});
