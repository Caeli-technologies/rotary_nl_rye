import React, { useCallback, useMemo } from 'react';
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';
import { useTheme } from '@/hooks/use-theme';
interface ProgramItem {
  title: string;
  subtitle?: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
}

export default function ProgramsScreen() {
  const { colors: themeColors } = useTheme();

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
        style={({ pressed }) => [
          styles.programItem,
          {
            backgroundColor: themeColors.card,
            borderColor: themeColors.border,
            shadowColor: themeColors.shadow,
          },
          pressed && styles.programItemPressed,
        ]}
        onPress={() => handleProgramPress(item.route)}
        accessibilityRole="button"
        accessibilityLabel={item.title}
        accessibilityHint="Tap to view details"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
        <View style={styles.programContent}>
          <View style={[styles.iconContainer, { backgroundColor: themeColors.primary + '15' }]}>
            <FontAwesome5 name={item.icon} size={22} color={themeColors.primary} />
          </View>
          <View style={styles.textContainer}>
            <Text style={[styles.programTitle, { color: themeColors.text }]}>{item.title}</Text>
            {item.subtitle && (
              <Text style={[styles.programSubtitle, { color: themeColors.textSecondary }]}>
                {item.subtitle}
              </Text>
            )}
          </View>
          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'}
            size={20}
            color={themeColors.textTertiary}
          />
        </View>
      </Pressable>
    ),
    [
      handleProgramPress,
      themeColors.card,
      themeColors.border,
      themeColors.shadow,
      themeColors.primary,
      themeColors.text,
      themeColors.textSecondary,
      themeColors.textTertiary,
    ],
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
        <Text style={[styles.introTitle, { color: themeColors.primary }]}>Programma&apos;s</Text>
        <Text style={[styles.introText, { color: themeColors.textSecondary }]}>
          Ontdek alle uitwisselingsprogramma&apos;s die Rotary YEP Nederland aanbiedt. Van lange
          termijn jaaruitwisselingen tot korte zomerprogramma&apos;s en promotioneel materiaal.
        </Text>
      </View>
    ),
    [themeColors.primary, themeColors.textSecondary],
  );

  const SectionHeader = useCallback(
    ({ title }: { title: string }) => (
      <View style={styles.sectionHeaderContainer}>
        <Text style={[styles.sectionHeaderTitle, { color: themeColors.primary }]}>{title}</Text>
        <View style={[styles.sectionHeaderDivider, { backgroundColor: themeColors.border }]} />
      </View>
    ),
    [themeColors.primary, themeColors.border],
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
    <SafeAreaView style={[styles.safeArea, { backgroundColor: themeColors.background }]} edges={[]}>
      <View style={[styles.container, { backgroundColor: themeColors.background }]}>
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
  safeArea: {
    flex: 1,
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
    marginBottom: 16,
  },
  introText: {
    fontSize: 15,
    lineHeight: 22,
    textAlign: 'left',
  },
  sectionHeaderContainer: {
    marginBottom: 16,
    marginTop: 8,
  },
  sectionHeaderTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
  },
  sectionHeaderDivider: {
    height: 2,
    borderRadius: 1,
  },
  programItem: {
    borderRadius: 12,
    marginBottom: 12,
    overflow: 'hidden',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
    ...(Platform.OS === 'android' && {
      borderWidth: StyleSheet.hairlineWidth,
    }),
  },
  programItemPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
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
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 16,
  },
  textContainer: {
    flex: 1,
    marginRight: 8,
  },
  programTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
    lineHeight: 22,
  },
  programSubtitle: {
    fontSize: 14,
    fontWeight: '400',
    lineHeight: 20,
  },
  spacer: {
    height: 10,
  },
});
