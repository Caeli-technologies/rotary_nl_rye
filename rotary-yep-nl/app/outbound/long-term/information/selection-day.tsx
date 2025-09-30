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

export default function SelectionDayScreen() {
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
              <Ionicons name="people-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>Selection Day</Text>
            <Text style={styles.headerSubtitle}>
              What to expect during the selection day for Rotary Youth Exchange
            </Text>
          </View>

          {/* Overview */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="information-circle-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>What is Selection Day?</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                The Selection Day is a crucial part of the Rotary Youth Exchange application process. 
                It's an opportunity for the selection committee to meet candidates in person and 
                assess their suitability for the exchange program through various activities and interviews.
              </Text>
            </View>
          </View>

          {/* Activities */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>What Happens During Selection Day?</Text>
            </View>
            
            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="chatbubbles-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Individual Interviews</Text>
                <Text style={styles.activityDescription}>
                  One-on-one interviews with Rotarians and former exchange students to discuss 
                  your motivation, expectations, and readiness for the exchange.
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="people-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Group Activities</Text>
                <Text style={styles.activityDescription}>
                  Team-building exercises and group discussions to observe your social skills, 
                  leadership qualities, and ability to work with others.
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="document-text-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Presentations</Text>
                <Text style={styles.activityDescription}>
                  You may be asked to give a short presentation about yourself, your interests, 
                  or why you want to participate in the exchange program.
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="globe-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Cultural Scenarios</Text>
                <Text style={styles.activityDescription}>
                  Role-playing exercises to test how you might handle challenging situations 
                  during your exchange in a foreign country.
                </Text>
              </View>
            </View>
          </View>

          {/* Preparation Tips */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="bulb-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>How to Prepare</Text>
            </View>
            
            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Research Rotary</Text>
              <Text style={styles.tipDescription}>
                Learn about Rotary's mission, values, and the Youth Exchange program's objectives
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Know Your Motivation</Text>
              <Text style={styles.tipDescription}>
                Be clear about why you want to participate and what you hope to gain from the experience
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Practice Communication</Text>
              <Text style={styles.tipDescription}>
                Work on expressing yourself clearly and confidently in both Dutch and English
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Show Adaptability</Text>
              <Text style={styles.tipDescription}>
                Demonstrate your flexibility and openness to new cultures and experiences
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Be Genuine</Text>
              <Text style={styles.tipDescription}>
                Be yourself and show your authentic personality and interests
              </Text>
            </View>
          </View>

          {/* What They Look For */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="search-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>What Selectors Look For</Text>
            </View>
            
            <View style={styles.criteriaCard}>
              <Text style={styles.criteriaTitle}>Maturity & Independence</Text>
              <Text style={styles.criteriaDescription}>
                Ability to handle challenging situations and make responsible decisions
              </Text>
            </View>

            <View style={styles.criteriaCard}>
              <Text style={styles.criteriaTitle}>Cultural Sensitivity</Text>
              <Text style={styles.criteriaDescription}>
                Respect for different cultures and willingness to adapt to new environments
              </Text>
            </View>

            <View style={styles.criteriaCard}>
              <Text style={styles.criteriaTitle}>Communication Skills</Text>
              <Text style={styles.criteriaDescription}>
                Clear expression of thoughts and good listening skills
              </Text>
            </View>

            <View style={styles.criteriaCard}>
              <Text style={styles.criteriaTitle}>Ambassador Qualities</Text>
              <Text style={styles.criteriaDescription}>
                Ability to represent the Netherlands positively abroad
              </Text>
            </View>
          </View>

          {/* Final Tips */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="star" size={24} color="#4CAF50" />
              <Text style={styles.noteTitle}>Final Advice</Text>
            </View>
            <Text style={styles.noteText}>
              Remember that Selection Day is not just about being evaluated - it's also your chance 
              to learn more about the program and ask questions. Be curious, be confident, and most 
              importantly, be yourself!
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
  
  // Activity Card Styles
  activityCard: {
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
  activityIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#E8EAF6',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  activityContent: {
    flex: 1,
  },
  activityTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  activityDescription: {
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
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  tipTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2E7D32',
    marginBottom: 4,
  },
  tipDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Criteria Card Styles
  criteriaCard: {
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
  criteriaTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  criteriaDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  
  // Note Card Styles
  noteCard: {
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
  noteHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  noteTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2E7D32',
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});