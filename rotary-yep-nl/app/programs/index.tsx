import React, { useCallback, useMemo } from 'react';
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';

interface ProgramItem {
  title: string;
  subtitle?: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
}

export default function ProgramsScreen() {
  const handleProgramPress = useCallback(async (route: string) => {
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
        style={({ pressed }) => [styles.programItem, pressed && styles.programItemPressed]}
        onPress={() => handleProgramPress(item.route)}
        accessibilityRole="button"
        accessibilityLabel={item.title}
        accessibilityHint="Tap to view details"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
        <View style={styles.programContent}>
          <View style={styles.iconContainer}>
            <FontAwesome5 name={item.icon} size={22} color="#007AFF" />
          </View>
          <View style={styles.textContainer}>
            <Text style={styles.programTitle}>{item.title}</Text>
            {item.subtitle && <Text style={styles.programSubtitle}>{item.subtitle}</Text>}
          </View>
          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'}
            size={20}
            color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'}
          />
        </View>
      </Pressable>
    ),
    [handleProgramPress],
  );

  const exchangePrograms: ProgramItem[] = useMemo(
    () => [
      {
        title: 'Long Term Exchange',
        subtitle: 'Year exchange & info',
        icon: 'calendar-alt' as any,
        route: '/programs/information/long-term-exchange',
      },
      {
        title: 'Family to Family',
        subtitle: 'Short-term family exchanges',
        icon: 'home' as any,
        route: '/programs/information/family-to-family',
      },
      {
        title: 'Zomerkampen',
        subtitle: 'Zomerkampen informatie',
        icon: 'campground' as any,
        route: '/programs/information/camps-tours',
      },
    ],
    [],
  );

  const infoPromoPrograms: ProgramItem[] = useMemo(
    () => [
      {
        title: 'Promo',
        subtitle: 'Podcast & Video',
        icon: 'podcast' as any,
        route: '/programs/promo',
      },
    ],
    [],
  );

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <Text style={styles.introTitle}>Programma&apos;s</Text>
        <Text style={styles.introText}>
          Ontdek alle uitwisselingsprogramma&apos;s die Rotary YEP Nederland aanbiedt. Van lange
          termijn jaaruitwisselingen tot korte zomerprogramma&apos;s en promotioneel materiaal.
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
      { type: 'sectionHeader', title: 'Informatie & Promo' },
      ...infoPromoPrograms.map((item) => ({ type: 'program', item })),
      { type: 'spacer' },
      { type: 'sectionHeader', title: 'Uitwisselingsprogramma&apos;s' },
      ...exchangePrograms.map((item) => ({ type: 'program', item })),
    ];
  }, [exchangePrograms, infoPromoPrograms]);

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
    <SafeAreaView style={styles.safeArea} edges={[]}>
      <View style={styles.container}>
        <FlatList
          data={renderContent()}
          renderItem={renderItem}
          keyExtractor={useCallback((item: any, index: number) => `${item.type}-${index}`, [])}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
          contentContainerStyle={styles.listContainer}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: { flex: 1, backgroundColor: '#F2F2F7' },
  container: { flex: 1 },
  listContainer: { padding: 16, paddingBottom: 34 },
  introContainer: { marginBottom: 32 },
  introTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
  },
  introText: { fontSize: 15, lineHeight: 22, color: '#3C3C43', textAlign: 'left' },
  sectionHeaderContainer: { marginBottom: 16, marginTop: 8 },
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
  textContainer: { flex: 1, marginRight: 8 },
  programTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 4,
    lineHeight: 22,
  },
  programSubtitle: { fontSize: 13, fontWeight: '400', color: '#8E8E93' },
  spacer: { height: 10 },
});
