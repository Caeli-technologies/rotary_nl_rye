import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

const countries = [
  { name: 'United States', flag: '🇺🇸', description: 'Experience American high school life and diverse cultures across different states' },
  { name: 'Canada', flag: '🇨🇦', description: 'Bilingual environment with excellent education system and multicultural society' },
  { name: 'Australia', flag: '🇦🇺', description: 'Unique wildlife, outdoor lifestyle, and friendly communities down under' },
  { name: 'New Zealand', flag: '🇳🇿', description: 'Stunning landscapes, adventure sports, and warm Kiwi hospitality' },
  { name: 'Japan', flag: '🇯🇵', description: 'Rich traditional culture combined with modern technology and innovation' },
  { name: 'South Korea', flag: '🇰🇷', description: 'Dynamic culture, advanced technology, and strong educational values' },
  { name: 'Taiwan', flag: '🇹🇼', description: 'Blend of Chinese culture with modern development and friendly people' },
  { name: 'Thailand', flag: '🇹🇭', description: 'Buddhist culture, tropical climate, and renowned Thai hospitality' },
  { name: 'Brazil', flag: '🇧🇷', description: 'Vibrant culture, carnival spirit, and diverse natural landscapes' },
  { name: 'Argentina', flag: '🇦🇷', description: 'Passionate culture, tango, excellent food, and beautiful countryside' },
  { name: 'Chile', flag: '🇨🇱', description: 'Diverse geography from desert to glaciers with strong family values' },
  { name: 'Mexico', flag: '🇲🇽', description: 'Rich history, colorful traditions, and warm family-oriented culture' },
  { name: 'South Africa', flag: '🇿🇦', description: 'Rainbow nation with diverse cultures and stunning natural beauty' },
  { name: 'Turkey', flag: '🇹🇷', description: 'Bridge between Europe and Asia with rich history and hospitality' },
  { name: 'India', flag: '🇮🇳', description: 'Ancient civilization, spiritual traditions, and incredible diversity' },
];

export default function Top3CountriesScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="earth-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>Top 3 Countries</Text>
            <Text style={styles.headerSubtitle}>
              Choose your preferred destinations for your Rotary Youth Exchange
            </Text>
          </View>

          {/* Information */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="information-circle-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>How It Works</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                During your application, you'll be asked to choose your top 3 preferred countries 
                for your exchange. While we cannot guarantee placement in your first choice, 
                we'll do our best to match you with one of your preferred destinations based on 
                availability and suitability.
              </Text>
            </View>
          </View>

          {/* Selection Tips */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="bulb-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Selection Tips</Text>
            </View>
            
            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="heart-outline" size={20} color="#E91E63" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Consider Your Interests</Text>
                <Text style={styles.tipDescription}>
                  Think about what cultures, languages, and experiences excite you most
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="school-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Academic Considerations</Text>
                <Text style={styles.tipDescription}>
                  Research education systems and how they might affect your studies
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="chatbubbles-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Language Learning</Text>
                <Text style={styles.tipDescription}>
                  Consider which languages you'd like to learn or improve
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="sunny-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Climate & Lifestyle</Text>
                <Text style={styles.tipDescription}>
                  Think about climate preferences and lifestyle differences
                </Text>
              </View>
            </View>
          </View>

          {/* Available Countries */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Available Destinations</Text>
            </View>
            
            {countries.map((country, index) => (
              <View key={index} style={styles.countryCard}>
                <View style={styles.countryFlag}>
                  <Text style={styles.flagEmoji}>{country.flag}</Text>
                </View>
                <View style={styles.countryContent}>
                  <Text style={styles.countryName}>{country.name}</Text>
                  <Text style={styles.countryDescription}>{country.description}</Text>
                </View>
              </View>
            ))}
          </View>

          {/* Important Notes */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="alert-circle-outline" size={24} color="#FF9800" />
              <Text style={styles.sectionTitle}>Important Notes</Text>
            </View>
            
            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🎯 No Guarantees</Text>
              <Text style={styles.noteDescription}>
                Country placement depends on availability and mutual suitability
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🔄 Changes Possible</Text>
              <Text style={styles.noteDescription}>
                Available countries may change based on partnerships and global situations
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>📋 Requirements Vary</Text>
              <Text style={styles.noteDescription}>
                Each country may have specific requirements (language, grades, etc.)
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🕒 Timing Matters</Text>
              <Text style={styles.noteDescription}>
                Some countries have different academic calendars and departure dates
              </Text>
            </View>
          </View>

          {/* Advice Card */}
          <View style={styles.adviceCard}>
            <View style={styles.adviceHeader}>
              <Ionicons name="star" size={24} color="#4CAF50" />
              <Text style={styles.adviceTitle}>Our Advice</Text>
            </View>
            <Text style={styles.adviceText}>
              Be open-minded in your choices! Sometimes the most unexpected destinations 
              provide the most amazing experiences. Focus on what you want to learn and 
              experience rather than just geographical preferences. Every country offers 
              unique opportunities for growth and discovery.
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: 30,
  },
  
  // Header Section
  headerSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 24,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#E8EAF6',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
    paddingHorizontal: 20,
  },
  
  // Section Styles
  section: {
    marginBottom: 32,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 12,
  },
  
  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Tip Card Styles
  tipCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  tipIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  tipContent: {
    flex: 1,
  },
  tipTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  tipDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Country Card Styles
  countryCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  countryFlag: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  flagEmoji: {
    fontSize: 24,
  },
  countryContent: {
    flex: 1,
  },
  countryName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  countryDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Note Card Styles
  noteCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  noteTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#F57C00',
    marginBottom: 4,
  },
  noteDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Advice Card Styles
  adviceCard: {
    backgroundColor: '#E8F5E8',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#4CAF50',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
    } : {
      elevation: 1,
    }),
  },
  adviceHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  adviceTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2E7D32',
    marginLeft: 8,
  },
  adviceText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});