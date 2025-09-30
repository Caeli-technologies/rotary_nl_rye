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

export default function HowDoIPrepareScreen() {
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
              <Ionicons name="school-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>How Do I Prepare?</Text>
            <Text style={styles.headerSubtitle}>
              Essential preparation steps for your Rotary Youth Exchange
            </Text>
          </View>

          {/* Academic Preparation */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="book-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Academic Preparation</Text>
            </View>
            
            <View style={styles.prepCard}>
              <Text style={styles.prepTitle}>Maintain Good Grades</Text>
              <Text style={styles.prepDescription}>
                Keep your academic performance strong throughout the application process
              </Text>
            </View>

            <View style={styles.prepCard}>
              <Text style={styles.prepTitle}>Language Skills</Text>
              <Text style={styles.prepDescription}>
                Improve your English and consider learning basics of your host country's language
              </Text>
            </View>

            <View style={styles.prepCard}>
              <Text style={styles.prepTitle}>Study Skills</Text>
              <Text style={styles.prepDescription}>
                Develop independent learning skills as education systems may differ abroad
              </Text>
            </View>
          </View>

          {/* Personal Development */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="person-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Personal Development</Text>
            </View>
            
            <View style={styles.developmentCard}>
              <View style={styles.developmentIcon}>
                <Ionicons name="heart-outline" size={20} color="#E91E63" />
              </View>
              <View style={styles.developmentContent}>
                <Text style={styles.developmentTitle}>Emotional Maturity</Text>
                <Text style={styles.developmentDescription}>
                  Work on managing homesickness, adapting to change, and handling stress
                </Text>
              </View>
            </View>

            <View style={styles.developmentCard}>
              <View style={styles.developmentIcon}>
                <Ionicons name="people-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.developmentContent}>
                <Text style={styles.developmentTitle}>Social Skills</Text>
                <Text style={styles.developmentDescription}>
                  Practice making new friends and adapting to different social situations
                </Text>
              </View>
            </View>

            <View style={styles.developmentCard}>
              <View style={styles.developmentIcon}>
                <Ionicons name="star-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.developmentContent}>
                <Text style={styles.developmentTitle}>Independence</Text>
                <Text style={styles.developmentDescription}>
                  Learn to make decisions independently and take responsibility for your actions
                </Text>
              </View>
            </View>
          </View>

          {/* Cultural Preparation */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="globe-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Cultural Preparation</Text>
            </View>
            
            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>Learn About Netherlands</Text>
              <Text style={styles.cultureDescription}>
                Be able to explain Dutch culture, history, and traditions to others
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>Research Host Countries</Text>
              <Text style={styles.cultureDescription}>
                Study the cultures, customs, and current events of countries you're interested in
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>Open Mindedness</Text>
              <Text style={styles.cultureDescription}>
                Develop curiosity and acceptance of different ways of life and thinking
              </Text>
            </View>
          </View>

          {/* Practical Preparation */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Practical Preparation</Text>
            </View>
            
            <View style={styles.practicalCard}>
              <View style={styles.practicalNumber}>
                <Text style={styles.practicalNumberText}>1</Text>
              </View>
              <View style={styles.practicalContent}>
                <Text style={styles.practicalTitle}>Health & Medical</Text>
                <Text style={styles.practicalDescription}>
                  Ensure all vaccinations are up to date and obtain necessary medical documentation
                </Text>
              </View>
            </View>

            <View style={styles.practicalCard}>
              <View style={styles.practicalNumber}>
                <Text style={styles.practicalNumberText}>2</Text>
              </View>
              <View style={styles.practicalContent}>
                <Text style={styles.practicalTitle}>Documentation</Text>
                <Text style={styles.practicalDescription}>
                  Gather important documents like birth certificates, passport, and academic records
                </Text>
              </View>
            </View>

            <View style={styles.practicalCard}>
              <View style={styles.practicalNumber}>
                <Text style={styles.practicalNumberText}>3</Text>
              </View>
              <View style={styles.practicalContent}>
                <Text style={styles.practicalTitle}>Financial Planning</Text>
                <Text style={styles.practicalDescription}>
                  Understand program costs and plan for personal expenses during the exchange
                </Text>
              </View>
            </View>

            <View style={styles.practicalCard}>
              <View style={styles.practicalNumber}>
                <Text style={styles.practicalNumberText}>4</Text>
              </View>
              <View style={styles.practicalContent}>
                <Text style={styles.practicalTitle}>Communication</Text>
                <Text style={styles.practicalDescription}>
                  Set up international communication methods and social media accounts
                </Text>
              </View>
            </View>
          </View>

          {/* Timeline */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="time-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Preparation Timeline</Text>
            </View>
            
            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>6-12 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Start learning about different cultures • Improve language skills • Focus on academic performance
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>3-6 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Gather documentation • Medical check-ups • Research specific host country in detail
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>1-3 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Final preparations • Connect with host family • Prepare presentations about Netherlands
              </Text>
            </View>
          </View>

          {/* Important Note */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="bulb" size={24} color="#2196F3" />
              <Text style={styles.noteTitle}>Key Tip</Text>
            </View>
            <Text style={styles.noteText}>
              Preparation is not just about checking boxes - it's about developing the mindset and skills 
              needed for a successful exchange. Start early and be consistent in your efforts!
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
  
  // Preparation Card Styles
  prepCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  prepTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  prepDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Development Card Styles
  developmentCard: {
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
  developmentIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  developmentContent: {
    flex: 1,
  },
  developmentTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  developmentDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Culture Card Styles
  cultureCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#9C27B0',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  cultureTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#7B1FA2',
    marginBottom: 4,
  },
  cultureDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Practical Card Styles
  practicalCard: {
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
  practicalNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#FF5722',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  practicalNumberText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
  practicalContent: {
    flex: 1,
  },
  practicalTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  practicalDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Timeline Card Styles
  timelineCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#607D8B',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#455A64',
    marginBottom: 4,
  },
  timelineDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Note Card Styles
  noteCard: {
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
  noteHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  noteTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1976D2',
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});