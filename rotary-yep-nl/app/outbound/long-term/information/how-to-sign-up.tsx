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

export default function HowToSignUpScreen() {
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
              <Ionicons name="document-text-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>How to Sign Up</Text>
            <Text style={styles.headerSubtitle}>
              Everything you need to know about applying for a long-term exchange program
            </Text>
          </View>

          {/* Application Process */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Application Process</Text>
            </View>
            
            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>1</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Contact Your Local Rotary Club</Text>
                <Text style={styles.stepDescription}>
                  Find and contact your nearest Rotary Club. They will be your sponsor for the exchange program and provide guidance throughout the process.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>2</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Submit Application</Text>
                <Text style={styles.stepDescription}>
                  Complete the official Rotary Youth Exchange application form with your personal information, academic records, and motivation letter.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>3</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Interview Process</Text>
                <Text style={styles.stepDescription}>
                  Participate in interviews with your local club and district committees to assess your suitability for the program.
                </Text>
              </View>
            </View>

            <View style={styles.stepCard}>
              <View style={styles.stepNumber}>
                <Text style={styles.stepNumberText}>4</Text>
              </View>
              <View style={styles.stepContent}>
                <Text style={styles.stepTitle}>Selection Weekend</Text>
                <Text style={styles.stepDescription}>
                  If selected, attend the national selection weekend where final candidates are chosen for the program.
                </Text>
              </View>
            </View>
          </View>

          {/* Requirements */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Requirements</Text>
            </View>
            
            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Age Requirement</Text>
              <Text style={styles.requirementText}>
                Between 15-18 years old at the time of departure
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Academic Performance</Text>
              <Text style={styles.requirementText}>
                Good academic standing with passing grades in all subjects
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Language Skills</Text>
              <Text style={styles.requirementText}>
                Basic English proficiency and willingness to learn the host country's language
              </Text>
            </View>

            <View style={styles.requirementCard}>
              <Text style={styles.requirementTitle}>Health & Character</Text>
              <Text style={styles.requirementText}>
                Good physical and mental health, plus strong character and maturity
              </Text>
            </View>
          </View>

          {/* Timeline */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="calendar-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Application Timeline</Text>
            </View>
            
            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Applications Open: September</Text>
              <Text style={styles.timelineDescription}>
                Applications typically open in September for the following academic year
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Deadline: December/January</Text>
              <Text style={styles.timelineDescription}>
                Application deadline is usually in December or early January
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Selection: February/March</Text>
              <Text style={styles.timelineDescription}>
                Selection processes and interviews take place in early spring
              </Text>
            </View>

            <View style={styles.timelineCard}>
              <Text style={styles.timelineTitle}>Departure: July/August</Text>
              <Text style={styles.timelineDescription}>
                Students typically depart for their exchange in summer
              </Text>
            </View>
          </View>

          {/* Important Note */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="information-circle" size={24} color="#FF9800" />
              <Text style={styles.noteTitle}>Important Note</Text>
            </View>
            <Text style={styles.noteText}>
              Each Rotary District may have slightly different application procedures and deadlines. 
              Contact your local Rotary Club for specific information about your district's process.
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
    backgroundColor: '#1A237E',
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
    borderLeftColor: '#1A237E',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  timelineDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Note Card Styles
  noteCard: {
    backgroundColor: '#FFF8E1',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#FF9800',
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
    color: '#E65100',
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});