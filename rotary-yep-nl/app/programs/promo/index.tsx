import React, { useCallback } from 'react';
import { StyleSheet, View, Text, ScrollView, TouchableOpacity, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';

const items = [
  { 
    key: 'podcast', 
    title: 'Podcast', 
    subtitle: 'Interviews met gastouders', 
    description: 'Luister naar de ervaringen van gastouders die exchange studenten hebben opgevangen',
    icon: 'headset-outline', 
    route: '/programs/promo/podcast' 
  },
  { 
    key: 'video', 
    title: 'Video\'s', 
    subtitle: "Promotievideo's", 
    description: 'Bekijk inspirerende video\'s over het Youth Exchange programma',
    icon: 'videocam-outline', 
    route: '/programs/promo/video' 
  },
];

export default function PromoIndex() {
  const onPress = useCallback(async (route: string) => {
    try {
      if (Platform.OS === 'ios') await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      router.push(route as any);
    } catch (e) {
      router.push(route as any);
    }
  }, []);

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <StatusBar style="auto" />
      <ScrollView contentContainerStyle={styles.container}>
        {/* Header Section */}
        <View style={styles.headerSection}>
          <View style={styles.headerIcon}>
            <Ionicons name="megaphone-outline" size={32} color="#FF6B35" />
          </View>
          <Text style={styles.headerTitle}>Promo Materiaal</Text>
          <Text style={styles.headerSubtitle}>
            Ontdek inspirerende verhalen en materialen over het Youth Exchange programma
          </Text>
        </View>

        {/* Items Grid */}
        {items.map((item) => (
          <TouchableOpacity 
            key={item.key}
            style={styles.card} 
            onPress={() => onPress(item.route)}
          >
            <View style={styles.cardContent}>
              <View style={styles.iconContainer}>
                <Ionicons name={item.icon as any} size={28} color="#FF6B35" />
              </View>
              <View style={styles.cardText}>
                <Text style={styles.cardTitle}>{item.title}</Text>
                <Text style={styles.cardSubtitle}>{item.subtitle}</Text>
                <Text style={styles.cardDescription}>{item.description}</Text>
              </View>
              <View style={styles.chevronContainer}>
                <Ionicons 
                  name={Platform.OS === 'ios' ? 'chevron-forward' : 'arrow-forward'} 
                  size={20} 
                  color="#C7C7CC" 
                />
              </View>
            </View>
          </TouchableOpacity>
        ))}

        <View style={{ height: 40 }} />
      </ScrollView>
    </SafeAreaView>
  );
}

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  container: {
    padding: 16,
    paddingBottom: 40,
  },
  
  // Header Styles
  headerSection: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    alignItems: 'center',
    ...shadowStyle,
  },
  headerIcon: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: '#FFF4F1',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: '#1A237E',
    marginBottom: 8,
    textAlign: 'center',
  },
  headerSubtitle: {
    fontSize: 15,
    lineHeight: 22,
    color: '#666',
    textAlign: 'center',
    paddingHorizontal: 10,
  },

  // Card Styles
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    marginBottom: 16,
    ...shadowStyle,
  },
  cardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#FFF4F1',
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 16,
  },
  cardText: {
    flex: 1,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  cardSubtitle: {
    fontSize: 14,
    color: '#FF6B35',
    fontWeight: '500',
    marginBottom: 6,
  },
  cardDescription: {
    fontSize: 14,
    lineHeight: 18,
    color: '#666',
  },
  chevronContainer: {
    marginLeft: 8,
  },
});
