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

export default function ComplyWithScreen() {
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
              <Ionicons name="shield-checkmark-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>Comply With</Text>
            <Text style={styles.headerSubtitle}>
              Rules, requirements, and expectations for Rotary Youth Exchange participants
            </Text>
          </View>

          {/* Rotary Four-Way Test */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#1A237E" />
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
              <Ionicons name="document-text-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Program Rules & Guidelines</Text>
            </View>
            
            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="home-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Host Family Rules</Text>
                <Text style={styles.ruleDescription}>
                  Respect and follow all host family rules, curfews, and household expectations
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="school-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>School Attendance</Text>
                <Text style={styles.ruleDescription}>
                  Maintain regular school attendance and participate actively in school activities
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="people-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Community Involvement</Text>
                <Text style={styles.ruleDescription}>
                  Participate in Rotary Club activities and community service projects
                </Text>
              </View>
            </View>

            <View style={styles.ruleCard}>
              <View style={styles.ruleIcon}>
                <Ionicons name="earth-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.ruleContent}>
                <Text style={styles.ruleTitle}>Cultural Ambassador</Text>
                <Text style={styles.ruleDescription}>
                  Represent the Netherlands positively and share your culture with others
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
                No alcohol consumption or drug use, regardless of local laws or customs
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Unauthorized Travel</Text>
              <Text style={styles.prohibitedDescription}>
                No travel outside the host district without proper authorization
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Driving Motorized Vehicles</Text>
              <Text style={styles.prohibitedDescription}>
                Driving cars, motorcycles, or motorized vehicles is strictly prohibited
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Hitchhiking</Text>
              <Text style={styles.prohibitedDescription}>
                Hitchhiking or accepting rides from strangers is not allowed
              </Text>
            </View>

            <View style={styles.prohibitedCard}>
              <Text style={styles.prohibitedTitle}>❌ Romantic Relationships</Text>
              <Text style={styles.prohibitedDescription}>
                No intimate relationships with host family members or other exchange students
              </Text>
            </View>
          </View>

          {/* Communication Requirements */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="chatbubbles-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Communication Requirements</Text>
            </View>
            
            <View style={styles.commCard}>
              <Text style={styles.commTitle}>Regular Reports</Text>
              <Text style={styles.commDescription}>
                Submit monthly reports to your sponsoring Rotary Club about your exchange experience
              </Text>
            </View>

            <View style={styles.commCard}>
              <Text style={styles.commTitle}>Contact with Family</Text>
              <Text style={styles.commDescription}>
                Maintain regular but not excessive contact with family and friends in the Netherlands
              </Text>
            </View>

            <View style={styles.commCard}>
              <Text style={styles.commTitle}>Emergency Communication</Text>
              <Text style={styles.commDescription}>
                Always inform your host family and counselor of your whereabouts and any changes in plans
              </Text>
            </View>
          </View>

          {/* Health & Safety */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="medical-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Health & Safety Requirements</Text>
            </View>
            
            <View style={styles.healthCard}>
              <View style={styles.healthIcon}>
                <Ionicons name="fitness-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.healthContent}>
                <Text style={styles.healthTitle}>Health Insurance</Text>
                <Text style={styles.healthDescription}>
                  Maintain valid health insurance coverage throughout your exchange
                </Text>
              </View>
            </View>

            <View style={styles.healthCard}>
              <View style={styles.healthIcon}>
                <Ionicons name="shield-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.healthContent}>
                <Text style={styles.healthTitle}>Safety First</Text>
                <Text style={styles.healthDescription}>
                  Always prioritize personal safety and avoid risky situations
                </Text>
              </View>
            </View>

            <View style={styles.healthCard}>
              <View style={styles.healthIcon}>
                <Ionicons name="call-outline" size={20} color="#F44336" />
              </View>
              <View style={styles.healthContent}>
                <Text style={styles.healthTitle}>Emergency Contacts</Text>
                <Text style={styles.healthDescription}>
                  Keep emergency contact information readily available at all times
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
              Violation of these rules may result in immediate termination of your exchange program 
              and return to the Netherlands at your own expense. All rules must be taken seriously 
              for the safety and success of all participants.
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
    backgroundColor: '#1A237E',
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
  
  // Health Card Styles
  healthCard: {
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
  healthIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  healthContent: {
    flex: 1,
  },
  healthTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  healthDescription: {
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