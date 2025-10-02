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
  type: 'info';
}

export default function FamilyToFamilyScreen() {
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
        accessibilityHint="Tik om details te bekijken"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
        <View style={styles.menuContent}>
          <View style={styles.iconContainer}>
            <FontAwesome5 name={item.icon} size={22} color="#007AFF" />
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

  const informationItems: MenuItem[] = [
    {
      title: 'Hoe aanmelden',
      subtitle: 'Stap-voor-stap aanmeldingsproces',
      icon: 'edit' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/family-to-family/information/how-to-sign-up',
      type: 'info',
    },
    {
      title: 'Landen & Voorkeur',
      subtitle: 'Beschikbare bestemmingen en hoe te kiezen',
      icon: 'globe-americas' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/family-to-family/information/countries-preference',
      type: 'info',
    },
    {
      title: 'Vereisten',
      subtitle: 'Regels en richtlijnen om te volgen',
      icon: 'shield-alt' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/family-to-family/information/comply-with',
      type: 'info',
    },
  ];

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <View style={styles.programCard}>
          <Text style={styles.programTitle}>Wat is Family-to-Family?</Text>
          <Text style={styles.programDescription}>
            Het Family-to-Family programma biedt jongeren de mogelijkheid om het leven in een andere
            cultuur te ervaren door 2-6 weken bij een gastgezin te verblijven. Deze authentieke
            culturele uitwisseling stelt deelnemers in staat zich volledig onder te dompelen in het
            dagelijkse leven, lokale gewoonten en familietradities.
          </Text>
        </View>

        <View style={styles.highlightsContainer}>
          <View style={styles.highlight}>
            <View style={styles.highlightIcon}>
              <Ionicons name="calendar-outline" size={20} color="#4CAF50" />
            </View>
            <View style={styles.highlightContent}>
              <Text style={styles.highlightTitle}>Duur</Text>
              <Text style={styles.highlightText}>2-6 weken</Text>
            </View>
          </View>

          <View style={styles.highlight}>
            <View style={styles.highlightIcon}>
              <Ionicons name="people-outline" size={20} color="#2196F3" />
            </View>
            <View style={styles.highlightContent}>
              <Text style={styles.highlightTitle}>Leeftijd</Text>
              <Text style={styles.highlightText}>15-25 jaar</Text>
            </View>
          </View>

          <View style={styles.highlight}>
            <View style={styles.highlightIcon}>
              <Ionicons name="home-outline" size={20} color="#FF9800" />
            </View>
            <View style={styles.highlightContent}>
              <Text style={styles.highlightTitle}>Onderdak</Text>
              <Text style={styles.highlightText}>Gastgezinnen</Text>
            </View>
          </View>
        </View>
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
      { type: 'sectionHeader', title: 'Informatie & Richtlijnen' },
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
  headerSection: {
    alignItems: 'center',
    marginBottom: 24,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#FFF3F0',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '700',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    paddingHorizontal: 20,
  },
  programCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  programTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 12,
  },
  programDescription: {
    fontSize: 15,
    lineHeight: 22,
    color: '#333',
  },
  highlightsContainer: {
    gap: 16,
  },
  highlight: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 4,
    elevation: 1,
  },
  highlightIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  highlightContent: {
    flex: 1,
  },
  highlightTitle: {
    fontSize: 14,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 2,
  },
  highlightText: {
    fontSize: 13,
    color: '#666',
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
});
