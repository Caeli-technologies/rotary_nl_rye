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
}

export default function ShortTermScreen() {
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

  const menuItems: MenuItem[] = [
    {
      title: 'Zomerkampen',
      subtitle: 'Short-term cultural exchange programs',
      icon: 'campground' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/camps-and-tours',
    },
    {
      title: 'Family to Family',
      subtitle: 'Host family exchange experiences',
      icon: 'home' as keyof typeof FontAwesome5.glyphMap,
      route: '/outbound/short-term/family-to-family',
    },
  ];

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <View style={styles.headerSection}>
          <Text style={styles.headerTitle}>Short Term Programs</Text>
          <Text style={styles.headerSubtitle}>
            Experience different cultures through shorter exchange programs
          </Text>
        </View>
        <Text style={styles.introText}>
          Rotary short-term programs offer young people the opportunity to experience different
          cultures through shorter exchange periods. These programs are perfect for students who
          want to gain international experience but cannot commit to a full year abroad.
        </Text>
      </View>
    ),
    [],
  );

  const renderContent = useCallback(() => {
    const allItems = [{ type: 'intro' }, ...menuItems.map((item) => ({ type: 'menuItem', item }))];

    return allItems;
  }, []);

  const renderItem = useCallback(
    ({ item }: { item: any }) => {
      switch (item.type) {
        case 'intro':
          return <IntroSection />;
        case 'menuItem':
          return renderMenuItem({ item: item.item });
        default:
          return null;
      }
    },
    [IntroSection, renderMenuItem],
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
    marginBottom: 16,
  },
  introText: {
    fontSize: 15,
    lineHeight: 22,
    color: '#3C3C43',
    textAlign: 'left',
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
