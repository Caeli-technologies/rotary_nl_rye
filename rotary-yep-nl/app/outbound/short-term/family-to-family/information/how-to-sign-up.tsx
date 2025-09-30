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

export default function FamilyToFamilyHowToSignUpScreen() {
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
              <Ionicons name="document-text-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>How to Sign Up</Text>
            <Text style={styles.headerSubtitle}>
              Complete guide to applying for Family-to-Family programs
            </Text>
          </View>

          {/* Application Steps */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Application Process</Text>
            </View>
            
            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>1</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Contact Your Local Rotary Club</Text>
                <Text style={styles.stepDescription}>
                  Reach out to your local Rotary Club to express interest in the Family-to-Family program. 
                  They will provide you with initial information and program availability.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>2</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Complete Application Form</Text>
                <Text style={styles.stepDescription}>
                  Fill out the comprehensive application form including personal information, 
                  interests, preferences, and family background.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>3</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Provide Required Documents</Text>
                <Text style={styles.stepDescription}>
                  Submit passport copy, medical insurance information, emergency contacts, 
                  and parental consent forms.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>4</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Interview Process</Text>
                <Text style={styles.stepDescription}>
                  Participate in an interview with Rotary Youth Exchange officers to 
                  assess suitability and program fit.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>5</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Host Family Matching</Text>
                <Text style={styles.stepDescription}>
                  Rotary will work to match you with a suitable host family based on 
                  your preferences and compatibility.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>6</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Pre-Departure Preparation</Text>
                <Text style={styles.stepDescription}>
                  Attend orientation sessions and prepare for your cultural exchange experience.
                </Text>
              </View>
            </View>
          </View>

          {/* Requirements */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Requirements</Text>
            </View>
            
            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="person-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Age Requirement</Text>
                <Text style={styles.requirementDescription}>Between 15-25 years old</Text>
              </View>
            </View>

            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="document-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Valid Passport</Text>
                <Text style={styles.requirementDescription}>Must be valid for at least 6 months</Text>
              </View>
            </View>

            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="shield-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Travel Insurance</Text>
                <Text style={styles.requirementDescription}>Comprehensive health and travel coverage</Text>
              </View>
            </View>

            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="people-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Parental Consent</Text>
                <Text style={styles.requirementDescription}>Required for participants under 18</Text>
              </View>
            </View>

            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="heart-outline" size={20} color="#E91E63" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Open Mindset</Text>
                <Text style={styles.requirementDescription}>Willingness to embrace new cultures</Text>
              </View>
            </View>

            <View style={styles.requirementCard}>
              <View style={styles.requirementIcon}>
                <Ionicons name="school-outline" size={20} color="#607D8B" />
              </View>
              <View style={styles.requirementContent}>
                <Text style={styles.requirementTitle}>Basic Language Skills</Text>
                <Text style={styles.requirementDescription}>Some knowledge of host country language preferred</Text>
              </View>
            </View>
          </View>

          {/* Timeline */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="time-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Application Timeline</Text>
            </View>
            
            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>📅 3-6 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Submit initial application and begin document preparation
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>📋 2-3 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Complete interviews and finalize all required documentation
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>🏠 1-2 Months Before</Text>
              <Text style={styles.timelineDescription}>
                Host family matching and initial contact establishment
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>✈️ 2-4 Weeks Before</Text>
              <Text style={styles.timelineDescription}>
                Final preparations, orientation sessions, and travel arrangements
              </Text>
            </View>
          </View>

          {/* Cost Information */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="cash-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Program Costs</Text>
            </View>
            
            <View style={styles.costCard}>
              <Text style={styles.costTitle}>💰 What's Included</Text>
              <Text style={styles.costDescription}>
                • Host family accommodation and meals\n
                • Local Rotary Club support and activities\n
                • Cultural orientation and guidance\n
                • Emergency support during stay
              </Text>
            </View>

            <View style={styles.costCard}>
              <Text style={styles.costTitle}>💳 Additional Costs</Text>
              <Text style={styles.costDescription}>
                • International travel expenses\n
                • Travel and health insurance\n
                • Personal spending money\n
                • Visa fees (if required)\n
                • Optional excursions and activities
              </Text>
            </View>
          </View>

          {/* Contact Information */}
          <View style={styles.contactCard}>
            <View style={styles.contactHeader}>
              <Ionicons name="call" size={24} color="#2196F3" />
              <Text style={styles.contactTitle}>Ready to Apply?</Text>
            </View>
            <Text style={styles.contactText}>
              Contact your local Rotary Club today to begin your Family-to-Family 
              application process. Each club has dedicated Youth Exchange officers 
              ready to guide you through every step of the journey.
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
  
  // Step Card Styles
  stepCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  stepNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#FF6B35',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  stepNumberText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
  stepContent: {
    flex: 1,
  },
  stepTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
  },
  stepDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Requirement Card Styles
  requirementCard: {
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
  requirementIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  requirementContent: {
    flex: 1,
  },
  requirementTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  requirementDescription: {
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
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2E7D32',
    marginBottom: 4,
  },
  timelineDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Cost Card Styles
  costCard: {
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
  costTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#F57C00',
    marginBottom: 8,
  },
  costDescription: {
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