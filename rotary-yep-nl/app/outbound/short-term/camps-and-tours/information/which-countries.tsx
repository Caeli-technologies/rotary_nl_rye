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

const popularDestinations = [
  { name: 'Germany', flag: '🇩🇪', description: 'Cultural camps, language immersion, and historical tours' },
  { name: 'France', flag: '🇫🇷', description: 'Art and culture camps, language programs, wine region tours' },
  { name: 'Italy', flag: '🇮🇹', description: 'Art history tours, cooking camps, Mediterranean experiences' },
  { name: 'Spain', flag: '🇪🇸', description: 'Cultural immersion, flamenco workshops, historical tours' },
  { name: 'United States', flag: '🇺🇸', description: 'Summer camps, leadership programs, adventure tours' },
  { name: 'Canada', flag: '🇨🇦', description: 'Outdoor adventure camps, nature programs, cultural exchanges' },
  { name: 'Australia', flag: '🇦🇺', description: 'Outback adventures, wildlife programs, surf camps' },
  { name: 'Japan', flag: '🇯🇵', description: 'Cultural immersion, technology camps, traditional arts' },
  { name: 'South Korea', flag: '🇰🇷', description: 'K-culture experiences, technology programs, temple stays' },
  { name: 'Brazil', flag: '🇧🇷', description: 'Environmental camps, cultural festivals, adventure tours' },
];

export default function WhichCountriesScreen() {
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
              <Ionicons name="globe-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Which Countries</Text>
            <Text style={styles.headerSubtitle}>
              Explore the destinations available for Rotary Camps & Tours
            </Text>
          </View>

          {/* Overview */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="information-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Program Destinations</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Rotary Camps & Tours are available in many countries around the world. 
                Each program offers unique cultural experiences, activities, and learning 
                opportunities specific to the destination. Programs vary by season and 
                availability.
              </Text>
            </View>
          </View>

          {/* Popular Destinations */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Popular Destinations</Text>
            </View>
            
            {popularDestinations.map((country, index) => (
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

          {/* Program Types */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Types of Programs</Text>
            </View>
            
            <View style={styles.typeCard}>
              <View style={styles.typeIcon}>
                <Ionicons name="school-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.typeContent}>
                <Text style={styles.typeTitle}>Educational Tours</Text>
                <Text style={styles.typeDescription}>
                  Focus on learning about history, culture, language, and academics
                </Text>
              </View>
            </View>

            <View style={styles.typeCard}>
              <View style={styles.typeIcon}>
                <Ionicons name="trail-sign-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.typeContent}>
                <Text style={styles.typeTitle}>Adventure Camps</Text>
                <Text style={styles.typeDescription}>
                  Outdoor activities, sports, nature exploration, and adventure challenges
                </Text>
              </View>
            </View>

            <View style={styles.typeCard}>
              <View style={styles.typeIcon}>
                <Ionicons name="people-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.typeContent}>
                <Text style={styles.typeTitle}>Cultural Immersion</Text>
                <Text style={styles.typeDescription}>
                  Deep dive into local customs, traditions, and ways of life
                </Text>
              </View>
            </View>

            <View style={styles.typeCard}>
              <View style={styles.typeIcon}>
                <Ionicons name="construct-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.typeContent}>
                <Text style={styles.typeTitle}>Service Projects</Text>
                <Text style={styles.typeDescription}>
                  Community service and humanitarian projects combined with cultural experience
                </Text>
              </View>
            </View>

            <View style={styles.typeCard}>
              <View style={styles.typeIcon}>
                <Ionicons name="bulb-outline" size={20} color="#FF5722" />
              </View>
              <View style={styles.typeContent}>
                <Text style={styles.typeTitle}>Skill Development</Text>
                <Text style={styles.typeDescription}>
                  Programs focused on specific skills like arts, crafts, cooking, or technology
                </Text>
              </View>
            </View>
          </View>

          {/* Important Notes */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="alert-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Important Notes</Text>
            </View>
            
            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🗓️ Seasonal Availability</Text>
              <Text style={styles.noteDescription}>
                Most programs run during school holidays (summer, winter, spring breaks)
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>📋 Prerequisites</Text>
              <Text style={styles.noteDescription}>
                Some programs may have language, age, or skill requirements
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🎯 Limited Spaces</Text>
              <Text style={styles.noteDescription}>
                Popular programs fill up quickly - early application is recommended
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>💰 Varying Costs</Text>
              <Text style={styles.noteDescription}>
                Program costs vary significantly by destination and duration
              </Text>
            </View>
          </View>

          {/* Contact Card */}
          <View style={styles.contactCard}>
            <View style={styles.contactHeader}>
              <Ionicons name="call" size={24} color="#2196F3" />
              <Text style={styles.contactTitle}>Get More Information</Text>
            </View>
            <Text style={styles.contactText}>
              For specific program availability, dates, and costs, contact your local 
              Rotary Club or visit the official Rotary Youth Programs website. New 
              programs are added regularly throughout the year.
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
    backgroundColor: '#FFF3F0',
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
  
  // Type Card Styles
  typeCard: {
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
  typeIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  typeContent: {
    flex: 1,
  },
  typeTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  typeDescription: {
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
  
  // Contact Card Styles
  contactCard: {
    backgroundColor: '#E3F2FD',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#2196F3',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
    } : {
      elevation: 1,
    }),
  },
  contactHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  contactTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1976D2',
    marginLeft: 8,
  },
  contactText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});