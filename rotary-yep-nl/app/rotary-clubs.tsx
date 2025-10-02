import React, { useCallback } from 'react';
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';

interface OptionItem {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
}

export default function RotaryClubsScreen() {
  const handleOptionPress = useCallback(async (route: string) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push(route as any);
    } catch (error) {
      console.error('Error navigating to route:', error);
      // Still navigate even if haptics fail
      router.push(route as any);
    }
  }, []);

  const renderOptionItem = useCallback(
    ({ item }: { item: OptionItem }) => (
      <Pressable
        style={({ pressed }) => [styles.optionRow, pressed && styles.optionRowPressed]}
        onPress={() => handleOptionPress(item.route)}
        android_ripple={{
          color: 'rgba(0, 122, 255, 0.2)',
          borderless: false,
        }}
        accessibilityRole="button"
        accessibilityLabel={item.title}
        accessibilityHint="Tap to view more information"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
        <View style={styles.optionContent}>
          <View style={styles.iconContainer}>
            <FontAwesome5 name={item.icon} size={22} color="#007AFF" />
          </View>
          <Text style={styles.optionTitle}>{item.title}</Text>
          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'}
            size={20}
            color={Platform.OS === 'ios' ? '#C7C7CC' : '#666'}
          />
        </View>
      </Pressable>
    ),
    [handleOptionPress],
  );

  const options: OptionItem[] = [
    {
      title: 'Algemene Informatie',
      icon: 'info-circle' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/algemene-informatie',
    },
    {
      title: 'Info voor de Jeugdcommissaris',
      icon: 'user-tie' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/jeugdcommissaris',
    },
    {
      title: 'Info Gastgezin',
      icon: 'home' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/gastgezin',
    },
    {
      title: 'Info Counselor',
      icon: 'hands-helping' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/counselor',
    },
    {
      title: 'Belangrijke Documenten',
      icon: 'exclamation-triangle' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/documenten',
    },
  ];

  const ListHeaderComponent = useCallback(
    () => (
      <View style={styles.content}>
        <Text style={styles.introText}>
          Wat leuk dat jullie als Rotary club van plan zijn om een jaarstudent te sponsoren en
          daarmee dus ook een jaar lang een kind binnen jullie club te ontvangen en te begeleiden.
          Misschien zijn jullie benaderd door een scholier van buiten jullie of mogelijk vanuit de
          wens van één van jullie clubleden.
        </Text>
      </View>
    ),
    [],
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <View style={styles.container}>
        <FlatList
          data={options}
          renderItem={renderOptionItem}
          keyExtractor={useCallback((item: OptionItem) => item.route, [])}
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
  introText: {
    fontSize: 15,
    lineHeight: 22,
    color: '#3C3C43',
    textAlign: 'left',
    paddingHorizontal: 16,
  },
  optionRow: {
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
  optionRowPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  optionContent: {
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
  optionTitle: {
    flex: 1,
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginRight: 8,
  },
});
