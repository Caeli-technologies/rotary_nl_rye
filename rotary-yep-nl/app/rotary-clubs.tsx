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

interface OptionItem {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
}

const renderOptionItem = ({ item }: { item: OptionItem }) => (
  <Pressable 
    style={({ pressed }) => [
      styles.optionRow,
      pressed && styles.optionRowPressed
    ]}
    onPress={() => router.push(item.route as any)}
    android_ripple={{
      color: 'rgba(0, 122, 255, 0.2)',
      borderless: false
    }}
  >
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
);

export default function RotaryClubsScreen() {
  const options: OptionItem[] = [
    {
      title: 'Algemene Informatie',
      icon: 'info-circle' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/algemene-informatie'
    },
    {
      title: 'Info voor de Jeugdcommissaris',
      icon: 'user-tie' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/jeugdcommissaris'
    },
    {
      title: 'Info Gastgezin',
      icon: 'home' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/gastgezin'
    },
    {
      title: 'Info Counselor',
      icon: 'hands-helping' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/counselor'
    },
    {
      title: 'Belangrijke Documenten',
      icon: 'exclamation-triangle' as keyof typeof FontAwesome5.glyphMap,
      route: '/rotary-clubs/documenten'
    }
  ];

  const ListHeaderComponent = () => (
    <View style={styles.content}>
      <Text style={styles.introText}>
        Wat leuk dat jullie als Rotary club van plan zijn om een jaarstudent te sponsoren en daarmee dus ook een jaar lang een kind binnen jullie club te ontvangen en te begeleiden. Misschien zijn jullie benaderd door een scholier van buiten jullie of mogelijk vanuit de wens van één van jullie clubleden.
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
          <Text style={styles.headerTitle}>voor Rotary Clubs</Text>
        </View>
        <View style={styles.placeholder} />
      </View>

      <View style={styles.container}>
        <FlatList
          data={options}
          renderItem={renderOptionItem}
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