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

export default function CampsToursComplyWithScreen() {
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
              Rules and guidelines for Camps & Tours participants
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

          {/* Program Rules */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="document-text-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Program Rules & Guidelines</Text>
            </View>
            
            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="people-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Group Participation</Text>
                <Text style={styles.ruleDescription}>
                  Participate actively in all scheduled activities and group events
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="time-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Punctuality</Text>
                <Text style={styles.ruleDescription}>
                  Be on time for all meetings, activities, and transportation
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="ear-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Follow Instructions</Text>
                <Text style={styles.ruleDescription}>
                  Listen to and follow all instructions from program leaders and coordinators
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="hand-left-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Respect Others</Text>
                <Text style={styles.ruleDescription}>
                  Show respect for fellow participants, host families, and local customs
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
                No alcohol consumption or drug use during the program
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Leaving the Group</Text>
              <Text style={styles.prohibitedDescription}>
                No wandering off alone or leaving the group without permission
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Inappropriate Behavior</Text>
              <Text style={styles.prohibitedDescription}>
                No disruptive, disrespectful, or inappropriate conduct
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Unauthorized Activities</Text>
              <Text style={styles.prohibitedDescription}>
                No participating in activities not approved by program leaders
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
                <Ionicons name="medical-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Health & Medical</Text>
                <Text style={styles.safetyDescription}>
                  Inform leaders of any medical conditions or medications
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="call-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Emergency Contact</Text>
                <Text style={styles.safetyDescription}>
                  Keep emergency contact information and stay reachable at all times
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="location-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Stay with Group</Text>
                <Text style={styles.safetyDescription}>
                  Always stay with the group and inform leaders of your whereabouts
                </Text>
              </View>
            </View>

            <View style={styles.safetyCard}>
              <View style={styles.safetyIcon}>
                <Ionicons name="document-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.safetyContent}>
                <Text style={styles.safetyTitle}>Important Documents</Text>
                <Text style={styles.safetyDescription}>
                  Keep passport, insurance, and other important documents secure
                </Text>
              </View>
            </View>
          </View>

          {/* Cultural Guidelines */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="globe-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Cultural Guidelines</Text>
            </View>
            
            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>🌍 Be a Cultural Ambassador</Text>
              <Text style={styles.cultureDescription}>
                Represent the Netherlands and Rotary positively in all interactions
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>🤝 Embrace Differences</Text>
              <Text style={styles.cultureDescription}>
                Be open to new experiences and different ways of doing things
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>📚 Learn and Share</Text>
              <Text style={styles.cultureDescription}>
                Learn about local culture while sharing your own background
              </Text>
            </View>

            <View style={styles.cultureCard}>
              <Text style={styles.cultureTitle}>📸 Respectful Documentation</Text>
              <Text style={styles.cultureDescription}>
                Ask permission before photographing people or sacred places
              </Text>
            </View>
          </View>

          {/* Consequences */}
          <View style={styles.warningCard}>
            <View style={styles.warningHeader}>
              <Ionicons name="warning" size={24} color="#F44336" />
              <Text style={styles.warningTitle}>Important Warning</Text>
            </View>
            <Text style={styles.warningText}>
              Violation of these rules may result in immediate removal from the program 
              and return home at your own expense. All participants must take these 
              guidelines seriously for everyone's safety and enjoyment.
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