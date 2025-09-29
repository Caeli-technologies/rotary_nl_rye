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
      <View style={styles.introSection}>
        <Text style={styles.introText}>
          Wat leuk dat jullie als Rotary club van plan zijn om een jaarstudent te sponsoren en daarmee dus ook een jaar lang een kind binnen jullie club te ontvangen en te begeleiden. Misschien zijn jullie benaderd door een scholier van buiten jullie of mogelijk vanuit de wens van één van jullie clubleden.
        </Text>
      </View>
      <View style={styles.divider} />
    </View>
  );

  return (
    <SafeAreaView style={styles.container} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <Pressable 
          style={({ pressed }) => [
            styles.backButton,
            pressed && styles.backButtonPressed
          ]}
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons 
            name={Platform.OS === 'ios' ? 'chevron-back' : 'arrow-back'} 
            size={Platform.OS === 'ios' ? 28 : 24} 
            color={Platform.OS === 'ios' ? '#007AFF' : '#1A237E'} 
          />
        </Pressable>
        <Text style={styles.headerTitle}>voor Rotary Clubs</Text>
        <View style={styles.placeholder} />
      </View>

      <FlatList
        data={options}
        renderItem={renderOptionItem}
        keyExtractor={(item, index) => index.toString()}
        ListHeaderComponent={ListHeaderComponent}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.listContainer}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#F5F5F5',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: Platform.OS === 'ios' ? 15 : 12,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#FFFFFF',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 1,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  backButton: {
    width: Platform.OS === 'ios' ? 32 : 40,
    height: Platform.OS === 'ios' ? 32 : 40,
    borderRadius: Platform.OS === 'ios' ? 16 : 20,
    backgroundColor: Platform.OS === 'ios' ? 'transparent' : '#F5F5F5',
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 17 : 20,
    fontWeight: Platform.OS === 'ios' ? '600' : 'bold',
    color: Platform.OS === 'ios' ? '#000' : '#1A237E',
    textAlign: 'center',
    flex: 1,
  },
  backButtonPressed: {
    opacity: Platform.OS === 'ios' ? 0.6 : 0.8,
    backgroundColor: Platform.OS === 'ios' ? 'rgba(0, 122, 255, 0.1)' : '#E0E0E0',
  },
  placeholder: {
    width: Platform.OS === 'ios' ? 32 : 40,
  },
  listContainer: {
    paddingBottom: Platform.OS === 'ios' ? 20 : 16,
  },
  content: {
    paddingTop: Platform.OS === 'ios' ? 16 : 20,
  },
  introSection: {
    paddingHorizontal: 20,
    paddingBottom: 20,
  },
  introText: {
    fontSize: Platform.OS === 'ios' ? 16 : 15,
    lineHeight: Platform.OS === 'ios' ? 22 : 20,
    color: Platform.OS === 'ios' ? '#3C3C43' : '#333',
    textAlign: 'left',
  },
  divider: {
    height: Platform.OS === 'ios' ? 0.5 : 1,
    backgroundColor: Platform.OS === 'ios' ? '#C6C6C8' : '#E0E0E0',
    marginHorizontal: 20,
    marginBottom: Platform.OS === 'ios' ? 16 : 20,
  },
  optionRow: {
    backgroundColor: '#fff',
    marginHorizontal: Platform.OS === 'ios' ? 16 : 20,
    marginBottom: Platform.OS === 'ios' ? 8 : 12,
    borderRadius: Platform.OS === 'ios' ? 10 : 12,
    overflow: 'hidden',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  optionRowPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  optionContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Platform.OS === 'ios' ? 16 : 20,
    minHeight: Platform.OS === 'ios' ? 60 : 72,
  },
  iconContainer: {
    width: Platform.OS === 'ios' ? 30 : 40,
    height: Platform.OS === 'ios' ? 30 : 40,
    borderRadius: Platform.OS === 'ios' ? 8 : 20,
    backgroundColor: Platform.OS === 'ios' ? '#E5F4FD' : '#F5F5F5',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: Platform.OS === 'ios' ? 12 : 15,
  },
  optionTitle: {
    flex: 1,
    fontSize: Platform.OS === 'ios' ? 17 : 16,
    fontWeight: Platform.OS === 'ios' ? '400' : '500',
    color: Platform.OS === 'ios' ? '#000' : '#333',
  },
});