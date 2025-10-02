import React, { useCallback } from 'react';
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';

import * as Haptics from 'expo-haptics';

interface MenuItem {
  title: string;
  subtitle?: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
  type: 'class' | 'info';
}

export default function LongTermExchangeScreen() {
  const handleItemPress = useCallback(async (route: string) => {
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

  const renderMenuItem = useCallback(
    ({ item }: { item: MenuItem }) => (
      <Pressable
        style={({ pressed }) => [styles.menuItem, pressed && styles.menuItemPressed]}
        onPress={() => handleItemPress(item.route)}
        accessibilityRole="button"
        accessibilityLabel={item.title}
        accessibilityHint="Tap to view details"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
        <View style={styles.menuContent}>
          <View
            style={[
              styles.iconContainer,
              item.type === 'class' ? styles.classIconContainer : styles.infoIconContainer,
            ]}>
            <FontAwesome5
              name={item.icon}
              size={22}
              color={item.type === 'class' ? '#9FA8DA' : '#007AFF'}
            />
          </View>
          <View style={styles.textContainer}>
            <Text style={styles.menuTitle}>{item.title}</Text>
            {item.subtitle && <Text style={styles.menuSubtitle}>{item.subtitle}</Text>}
          </View>
          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'}
            size={20}
            color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'}
          />
        </View>
      </Pressable>
    ),
    [handleItemPress],
  );

  const classOfItems: MenuItem[] = [
    {
      title: 'Huidige Studenten',
      subtitle: 'Onze studenten in het buitenland dit jaar',
      icon: 'users' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/class-of',
      type: 'class',
    },
  ];

  const informationItems: MenuItem[] = [
    {
      title: 'Hoe meld ik me aan?',
      subtitle: 'Volledige aanmeldprocedure en vereisten',
      icon: 'edit' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/information/how-to-sign-up',
      type: 'info',
    },
    {
      title: 'Selectie dag',
      subtitle: 'Wat je kunt verwachten tijdens het selectieproces',
      icon: 'calendar-day' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/information/selection-day',
      type: 'info',
    },
    {
      title: 'Selectie weekend',
      subtitle: 'Finale selectieweekend activiteiten en verwachtingen',
      icon: 'calendar-week' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/information/selection-weekend',
      type: 'info',
    },
    {
      title: 'Goede top 3 van landen',
      subtitle: 'Hoe kies je jouw voorkeursbestemmingen',
      icon: 'globe-americas' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/information/top-3-countries',
      type: 'info',
    },
    {
      title: 'Waar moet ik aan voldoen?',
      subtitle: 'Regels en richtlijnen voor uitwisselingsstudenten',
      icon: 'shield-alt' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/long-term/information/comply-with',
      type: 'info',
    },
  ];

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <Text style={styles.introText}>
          Dit programma van Rotary International is bestemd voor alle hierin geïnteresseerde
          scholieren uit het Voortgezet Onderwijs. Het is de bedoeling dat je in het buitenland een
          jaar High School volgt. Omgekeerd komen buitenlandse scholieren hier om gedurende een jaar
          samen met leeftijdgenoten naar school te gaan.
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
    const allItems = [
      { type: 'intro' },
      { type: 'sectionHeader', title: 'Klas van 25-26' },
      ...classOfItems.map((item) => ({ type: 'menuItem', item })),
      { type: 'spacer' },
      { type: 'sectionHeader', title: 'Informatie' },
      ...informationItems.map((item) => ({ type: 'menuItem', item })),
    ];

    return allItems;
  }, []);

  const renderItem = useCallback(
    ({ item }: { item: any }) => {
      switch (item.type) {
        case 'intro':
          return <IntroSection />;
        case 'sectionHeader':
          return <SectionHeader title={item.title} />;
        case 'menuItem':
          return renderMenuItem({ item: item.item });
        case 'spacer':
          return <View style={styles.spacer} />;
        default:
          return null;
      }
    },
    [IntroSection, SectionHeader, renderMenuItem],
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
  menuItem: {
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
  menuItemPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  menuContent: {
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
  classIconContainer: {
    backgroundColor: '#F2F2F7',
  },
  infoIconContainer: {
    backgroundColor: '#F2F2F7',
  },
  textContainer: {
    flex: 1,
    marginRight: 8,
  },
  menuTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 4,
    lineHeight: 22,
  },
  menuSubtitle: {
    fontSize: 13,
    fontWeight: '400',
    color: '#8E8E93',
  },
  spacer: {
    height: 10,
  },
});
