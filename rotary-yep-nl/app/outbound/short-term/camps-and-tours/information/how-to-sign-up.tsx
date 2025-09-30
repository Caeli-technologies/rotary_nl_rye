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

export default function CampsToursSignUpScreen() {
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
              <Ionicons name="airplane-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>How to Sign Up</Text>
            <Text style={styles.headerSubtitle}>
              Everything you need to know about applying for Camps & Tours
            </Text>
          </View>

          {/* Application Process */}
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
                <Text style={styles.stepTitle}>Choose Your Program</Text>
                <Text style={styles.stepDescription}>
                  Browse available camps and tours to find one that matches your interests and schedule.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>2</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Contact Your Local Rotary Club</Text>
                <Text style={styles.stepDescription}>
                  Get in touch with your nearest Rotary Club to express your interest and get guidance.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>3</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Complete Application Form</Text>
                <Text style={styles.stepDescription}>
                  Fill out the camp/tour application form with your personal information and preferences.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>4</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Submit Required Documents</Text>
                <Text style={styles.stepDescription}>
                  Provide necessary documentation including passport, medical forms, and references.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>5</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Pay Program Fees</Text>
                <Text style={styles.stepDescription}>
                  Complete payment of program fees and any required deposits.
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
              <Text style={styles.requirementTitle}>Age Requirement</Text>
              <Text style={styles.requirementText}>
                Most programs are for ages 15-21, but specific age ranges vary by program
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Valid Passport</Text>
              <Text style={styles.requirementText}>
                Must have a valid passport with at least 6 months remaining validity
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Medical Clearance</Text>
              <Text style={styles.requirementText}>
                Health certificate and any required vaccinations for the destination country
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Parental Consent</Text>
              <Text style={styles.requirementText}>
                Written consent from parents/guardians for participants under 18
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Travel Insurance</Text>
              <Text style={styles.requirementText}>
                Comprehensive travel and medical insurance coverage
              </Text>
            </View>
          </View>

          {/* Timeline */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="calendar-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Application Timeline</Text>
            </View>
            
            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Early Applications (3-6 months ahead)</Text>
              <Text style={styles.timelineDescription}>
                Best chance for program acceptance and better pricing
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Standard Applications (2-3 months ahead)</Text>
              <Text style={styles.timelineDescription}>
                Good availability for most programs, standard pricing
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Late Applications (1-2 months ahead)</Text>
              <Text style={styles.timelineDescription}>
                Limited availability, may have additional fees
              </Text>
            </View>
          </View>

          {/* Costs */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="card-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Program Costs</Text>
            </View>
            
            <View style={styles.costCard}>
              <Text style={styles.costTitle}>What's Usually Included:</Text>
              <Text style={styles.costDescription}>
                • Accommodation during the program
                • Most meals and planned activities
                • Local transportation
                • Program coordination and support
              </Text>
            </View>

            <View style={styles.costCard}>
              <Text style={styles.costTitle}>Additional Costs:</Text>
              <Text style={styles.costDescription}>
                • International airfare
                • Visa fees (if required)
                • Travel insurance
                • Personal spending money
                • Souvenirs and optional activities
              </Text>
            </View>
          </View>

          {/* Important Note */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="information-circle" size={24} color="#2196F3" />
              <Text style={styles.noteTitle}>Important Information</Text>
            </View>
            <Text style={styles.noteText}>
              Program availability, costs, and requirements can vary significantly between different 
              camps and tours. Contact your local Rotary Club for specific details about the 
              programs you're interested in.
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
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
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
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
  },
  stepDescription: {
    fontSize: 16,
    color: '#333',
    lineHeight: 22,
  },
  
  // Requirement Card Styles
  requirementCard: {
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
  requirementTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  requirementText: {
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
    borderLeftColor: '#FF6B35',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#E65100',
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
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  costTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
  },
  costDescription: {
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