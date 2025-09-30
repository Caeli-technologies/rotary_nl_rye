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

export default function FamilyToFamilyComplyWithScreen() {
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
              <Ionicons name="shield-checkmark-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Comply With</Text>
            <Text style={styles.headerSubtitle}>
              Rules and guidelines for Family-to-Family participants
            </Text>
          </View>

          {/* Rotary Four-Way Test */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Rotary Four-Way Test</Text>
            </View>
            
            <View style={styles.fourWayCard}>
              <Text style={styles.fourWayTitle}>Of the things we think, say or do:</Text>
              
              <View style={styles.testItem}>
                <View style={styles.testNumber}>
                  <Text style={styles.testNumberText}>1</Text>
                </View>
                <Text style={styles.testText}>Is it the TRUTH?</Text>
              </View>

              <View style={styles.testItem}>
                <View style={styles.testNumber}>
                  <Text style={styles.testNumberText}>2</Text>
                </View>
                <Text style={styles.testText}>Is it FAIR to all concerned?</Text>
              </View>

              <View style={styles.testItem}>
                <View style={styles.testNumber}>
                  <Text style={styles.testNumberText}>3</Text>
                </View>
                <Text style={styles.testText}>Will it build GOODWILL and better friendships?</Text>
              </View>

              <View style={styles.testItem}>
                <View style={styles.testNumber}>
                  <Text style={styles.testNumberText}>4</Text>
                </View>
                <Text style={styles.testText}>Will it be BENEFICIAL to all concerned?</Text>
              </View>
            </View>
          </View>

          {/* Host Family Guidelines */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="home-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Host Family Guidelines</Text>
            </View>
            
            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="heart-outline" size={20} color="#E91E63" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Be a Family Member</Text>
                <Text style={styles.ruleDescription}>
                  Participate in family activities, meals, and traditions as an active family member
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="hand-left-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Show Respect</Text>
                <Text style={styles.ruleDescription}>
                  Respect house rules, family values, and cultural differences
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="chatbubbles-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Communicate Openly</Text>
                <Text style={styles.ruleDescription}>
                  Maintain open and honest communication with your host family
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="construct-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Help with Household Tasks</Text>
                <Text style={styles.ruleDescription}>
                  Contribute to household chores and responsibilities as appropriate
                </Text>
              </View>
            </View>
          </View>

          {/* Behavioral Expectations */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="person-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Behavioral Expectations</Text>
            </View>
            
            <View style={styles.behaviorCard}>
              <View style={styles.behaviorIcon}>
                <Ionicons name="school-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.behaviorContent}>
                <Text style={styles.behaviorTitle}>Be Open to Learning</Text>
                <Text style={styles.behaviorDescription}>
                  Embrace new experiences and be willing to learn about different cultures
                </Text>
              </View>
            </View>

            <View style={styles.behaviorCard}>
              <View style={styles.behaviorIcon}>
                <Ionicons name="globe-outline" size={20} color="#607D8B" />
              </View>
              <View style={styles.behaviorContent}>
                <Text style={styles.behaviorTitle}>Cultural Ambassador</Text>
                <Text style={styles.behaviorDescription}>
                  Represent the Netherlands and Rotary positively in all interactions
                </Text>
              </View>
            </View>

            <View style={styles.behaviorCard}>
              <View style={styles.behaviorIcon}>
                <Ionicons name="time-outline" size={20} color="#795548" />
              </View>
              <View style={styles.behaviorContent}>
                <Text style={styles.behaviorTitle}>Punctuality</Text>
                <Text style={styles.behaviorDescription}>
                  Be on time for family activities, meals, and any scheduled events
                </Text>
              </View>
            </View>

            <View style={styles.behaviorCard}>
              <View style={styles.behaviorIcon}>
                <Ionicons name="people-outline" size={20} color="#3F51B5" />
              </View>
              <View style={styles.behaviorContent}>
                <Text style={styles.behaviorTitle}>Social Interaction</Text>
                <Text style={styles.behaviorDescription}>
                  Engage positively with family members, friends, and community
                </Text>
              </View>
            </View>
          </View>

          {/* Prohibited Activities */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="close-circle-outline" size={24} color="#F44336" />
              <Text style={styles.sectionTitle}>Prohibited Activities</Text>
            </View>
            
            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Alcohol & Drugs</Text>
              <Text style={styles.prohibitedDescription}>
                No alcohol consumption or illegal drug use during the program
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Inappropriate Relationships</Text>
              <Text style={styles.prohibitedDescription}>
                No intimate relationships with host family members or other participants
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Unauthorized Travel</Text>
              <Text style={styles.prohibitedDescription}>
                No traveling without host family knowledge and approval
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Disrespectful Behavior</Text>
              <Text style={styles.prohibitedDescription}>
                No behavior that could embarrass Rotary, your home country, or host family
              </Text>
            </View>
          </View>

          {/* Communication Guidelines */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="call-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Communication Guidelines</Text>
            </View>
            
            <View style={styles.commCard}>
              <Text style={styles.commTitle}>📱 Stay Connected</Text>
              <Text style={styles.commDescription}>
                Maintain regular contact with your home Rotary Club and family
              </Text>
            </View>

            <View style={styles.commCard}>
              <Text style={styles.commTitle}>🚨 Emergency Protocol</Text>
              <Text style={styles.commDescription}>
                Know emergency contact information and procedures for both countries
              </Text>
            </View>

            <View style={styles.commCard}>
              <Text style={styles.commTitle}>📧 Regular Updates</Text>
              <Text style={styles.commDescription}>
                Provide regular updates to your home club about your experiences
              </Text>
            </View>

            <View style={styles.commCard}>
              <Text style={styles.commTitle}>🤝 Rotary Contact</Text>
              <Text style={styles.commDescription}>
                Maintain contact with your host Rotary Club and assigned counselor
              </Text>
            </View>
          </View>

          {/* Cultural Sensitivity */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="earth-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Cultural Sensitivity</Text>
            </View>
            
            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>🌍 Respect Local Customs</Text>
              <Text style={styles.cultureDescription}>
                Learn about and respect local customs, traditions, and social norms
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>👥 Avoid Comparisons</Text>
              <Text style={styles.cultureDescription}>
                Don't constantly compare your host country to the Netherlands
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>🎯 Be Adaptable</Text>
              <Text style={styles.cultureDescription}>
                Be flexible and adaptable to different ways of living and thinking
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>📚 Learn Continuously</Text>
              <Text style={styles.cultureDescription}>
                Ask questions and show genuine interest in learning about the culture
              </Text>
            </View>
          </View>

          {/* Safety Requirements */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="shield-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Safety Requirements</Text>
            </View>
            
            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="location-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Share Your Location</Text>
                <Text style={styles.safetyDescription}>
                  Always inform your host family of your whereabouts and plans
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="medical-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Health & Medical</Text>
                <Text style={styles.safetyDescription}>
                  Follow all health guidelines and inform family of any medical needs
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="document-text-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Important Documents</Text>
                <Text style={styles.safetyDescription}>
                  Keep copies of passport, insurance, and emergency contacts safe
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="alert-circle-outline" size={20} color="#F44336" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Report Issues</Text>
                <Text style={styles.safetyDescription}>
                  Report any problems or concerns to your Rotary counselor immediately
                </Text>
              </View>
            </View>
          </View>

          {/* Consequences */}
          <View style={styles.warningCard}>
            <View style={styles.warningHeader}>
              <Ionicons name="warning" size={24} color="#F44336" />
              <Text style={styles.warningTitle}>Important Warning</Text>
            </View>
            <Text style={styles.warningText}>
              Violation of these guidelines may result in immediate termination of your 
              program and return home at your own expense. All participants must take 
              these rules seriously to ensure a safe and positive experience for everyone involved.
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
  
  // Four-Way Test Styles
  fourWayCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  fourWayTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
    textAlign: 'center',
  },
  testItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  testNumber: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: '#FF6B35',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  testNumberText: {
    color: '#FFFFFF',
    fontSize: 14,
    fontWeight: '600',
  },
  testText: {
    fontSize: 16,
    color: '#333',
    flex: 1,
    fontWeight: '500',
  },
  
  // Rule Card Styles
  ruleCard: {
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
  ruleIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  ruleContent: {
    flex: 1,
  },
  ruleTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  ruleDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Behavior Card Styles
  behaviorCard: {
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
  behaviorIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  behaviorContent: {
    flex: 1,
  },
  behaviorTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  behaviorDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Prohibited Card Styles
  prohibitedCard: {
    backgroundColor: '#FFEBEE',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#F44336',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#F44336',
      shadowOffset: { width: 0, height: 1 },
      shadowOpacity: 0.1,
      shadowRadius: 2,
    } : {
      elevation: 1,
    }),
  },
  prohibitedTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#D32F2F',
    marginBottom: 4,
  },
  prohibitedDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Communication Card Styles
  commCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  commTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1976D2',
    marginBottom: 4,
  },
  commDescription: {
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
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  cultureTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2E7D32',
    marginBottom: 4,
  },
  cultureDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Safety Card Styles
  safetyCard: {
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
  safetyIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  safetyContent: {
    flex: 1,
  },
  safetyTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  safetyDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Warning Card Styles
  warningCard: {
    backgroundColor: '#FFEBEE',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#F44336',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#F44336',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
    } : {
      elevation: 1,
    }),
  },
  warningHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  warningTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#D32F2F',
    marginLeft: 8,
  },
  warningText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});