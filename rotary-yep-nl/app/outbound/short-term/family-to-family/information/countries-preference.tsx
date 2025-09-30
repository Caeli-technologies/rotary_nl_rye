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

const availableCountries = [
  { name: 'United States', flag: '🇺🇸', description: 'Experience American family life and culture' },
  { name: 'Canada', flag: '🇨🇦', description: 'Discover Canadian hospitality and traditions' },
  { name: 'Australia', flag: '🇦🇺', description: 'Live with an Aussie family down under' },
  { name: 'New Zealand', flag: '🇳🇿', description: 'Experience Kiwi lifestyle and nature' },
  { name: 'Germany', flag: '🇩🇪', description: 'Immerse in German culture and traditions' },
  { name: 'France', flag: '🇫🇷', description: 'Live the French way of life' },
  { name: 'Italy', flag: '🇮🇹', description: 'Experience Italian family warmth' },
  { name: 'Spain', flag: '🇪🇸', description: 'Discover Spanish culture and lifestyle' },
  { name: 'United Kingdom', flag: '🇬🇧', description: 'Experience British family traditions' },
  { name: 'Ireland', flag: '🇮🇪', description: 'Enjoy Irish hospitality and culture' },
  { name: 'Japan', flag: '🇯🇵', description: 'Experience traditional and modern Japan' },
  { name: 'South Korea', flag: '🇰🇷', description: 'Discover Korean family life and culture' },
  { name: 'Thailand', flag: '🇹🇭', description: 'Experience Thai hospitality and traditions' },
  { name: 'Brazil', flag: '🇧🇷', description: 'Live with a Brazilian family' },
  { name: 'Argentina', flag: '🇦🇷', description: 'Experience Argentinian culture and warmth' },
  { name: 'Mexico', flag: '🇲🇽', description: 'Discover Mexican family traditions' },
];

export default function CountriesPreferenceScreen() {
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
            <Text style={styles.headerTitle}>Countries & Preference</Text>
            <Text style={styles.headerSubtitle}>
              Choose your preferred destination for the Family-to-Family experience
            </Text>
          </View>

          {/* How to Choose */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="help-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>How to Choose Your Preference</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                When applying for a Family-to-Family program, you'll be asked to list your 
                top 3 preferred countries. Consider factors like language, culture, climate, 
                and your personal interests when making your selection. Remember that 
                availability varies by season and demand.
              </Text>
            </View>
          </View>

          {/* Available Countries */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Available Countries</Text>
            </View>
            
            {availableCountries.map((country, index) => (
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

          {/* Selection Tips */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="bulb-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Selection Tips</Text>
            </View>
            
            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="language-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Language Skills</Text>
                <Text style={styles.tipDescription}>
                  Consider your language abilities. Some basic knowledge of the host 
                  country's language can enhance your experience.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="heart-outline" size={20} color="#E91E63" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Cultural Interest</Text>
                <Text style={styles.tipDescription}>
                  Choose countries whose culture, history, and traditions genuinely 
                  interest you for a more meaningful experience.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="sunny-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Climate Preference</Text>
                <Text style={styles.tipDescription}>
                  Consider the climate and weather conditions during your intended 
                  travel period.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="time-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Time Zone</Text>
                <Text style={styles.tipDescription}>
                  Think about time zone differences and how they might affect 
                  communication with family back home.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="airplane-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Travel Distance</Text>
                <Text style={styles.tipDescription}>
                  Consider travel costs and distance, especially for shorter programs 
                  where travel time might be proportionally significant.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="school-outline" size={20} color="#607D8B" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Educational Opportunities</Text>
                <Text style={styles.tipDescription}>
                  Think about what you want to learn and experience during your stay.
                </Text>
              </View>
            </View>
          </View>

          {/* Application Process */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="document-text-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Application Process</Text>
            </View>
            
            <View style={styles.processCard}>
              <Text style={styles.processTitle}>📝 Step 1: Research</Text>
              <Text style={styles.processDescription}>
                Research each country thoroughly, including culture, customs, and current events
              </Text>
            </View>

            <View style={styles.processCard}>
              <Text style={styles.processTitle}>📋 Step 2: List Preferences</Text>
              <Text style={styles.processDescription}>
                List your top 3 country preferences in order of preference on your application
              </Text>
            </View>

            <View style={styles.processCard}>
              <Text style={styles.processTitle}>🏠 Step 3: Host Family Matching</Text>
              <Text style={styles.processDescription}>
                Rotary will work to match you with a suitable host family in one of your preferred countries
              </Text>
            </View>

            <View style={styles.processCard}>
              <Text style={styles.processTitle}>✈️ Step 4: Final Arrangements</Text>
              <Text style={styles.processDescription}>
                Once matched, you'll work with both Rotary clubs to finalize travel and program details
              </Text>
            </View>
          </View>

          {/* Important Notes */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="alert-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Important Notes</Text>
            </View>
            
            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>⚠️ Availability Varies</Text>
              <Text style={styles.noteDescription}>
                Not all countries are available at all times. Program availability depends 
                on host family availability and local Rotary Club capacity.
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>🔄 Flexibility is Key</Text>
              <Text style={styles.noteDescription}>
                Being flexible with your preferences increases your chances of placement. 
                Consider multiple countries that interest you.
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>📅 Seasonal Considerations</Text>
              <Text style={styles.noteDescription}>
                Some programs are seasonal. Summer programs are most popular, 
                so apply early for the best selection.
              </Text>
            </View>

            <View style={styles.noteCard}>
              <Text style={styles.noteTitle}>💰 Cost Variations</Text>
              <Text style={styles.noteDescription}>
                Program costs vary by destination. Factor in travel expenses 
                and living costs when making your selection.
              </Text>
            </View>
          </View>

          {/* Contact Card */}
          <View style={styles.contactCard}>
            <View style={styles.contactHeader}>
              <Ionicons name="call" size={24} color="#2196F3" />
              <Text style={styles.contactTitle}>Need Help Choosing?</Text>
            </View>
            <Text style={styles.contactText}>
              Contact your local Rotary Club's Youth Exchange officers for guidance 
              on country selection. They have experience with different programs and 
              can help you make the best choice for your interests and goals.
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
  
  // Process Card Styles
  processCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  processTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2E7D32',
    marginBottom: 4,
  },
  processDescription: {
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