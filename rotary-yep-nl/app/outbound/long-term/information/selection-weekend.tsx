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

export default function SelectionWeekendScreen() {
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
              <Ionicons name="calendar-outline" size={32} color="#1A237E" />
            </View>
            <Text style={styles.headerTitle}>Selection Weekend</Text>
            <Text style={styles.headerSubtitle}>
              The final step in the Rotary Youth Exchange selection process
            </Text>
          </View>

          {/* Overview */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="information-circle-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>What is Selection Weekend?</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                The Selection Weekend is the final and most important step in the Rotary Youth Exchange selection process. 
                It brings together the best candidates from across the Netherlands for intensive evaluation through activities, 
                interviews, and group dynamics. This weekend determines who will represent the Netherlands as exchange students.
              </Text>
            </View>
          </View>

          {/* Schedule Overview */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="time-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Weekend Schedule</Text>
            </View>
            
            <View style={styles.dayCard}>
              <View style={styles.dayHeader}>
                <Ionicons name="sunny-outline" size={20} color="#1A237E" />
                <Text style={styles.dayTitle}>Friday Evening</Text>
              </View>
              <Text style={styles.dayDescription}>
                Arrival and welcome dinner • Initial introductions and ice-breaking activities • 
                Program overview and expectations briefing
              </Text>
            </View>

            <View style={styles.dayCard}>
              <View style={styles.dayHeader}>
                <Ionicons name="partly-sunny-outline" size={20} color="#1A237E" />
                <Text style={styles.dayTitle}>Saturday</Text>
              </View>
              <Text style={styles.dayDescription}>
                Intensive interviews • Group problem-solving challenges • Cultural scenario exercises • 
                Leadership and teamwork activities • Evening social activities
              </Text>
            </View>

            <View style={styles.dayCard}>
              <View style={styles.dayHeader}>
                <Ionicons name="moon-outline" size={20} color="#1A237E" />
                <Text style={styles.dayTitle}>Sunday</Text>
              </View>
              <Text style={styles.dayDescription}>
                Final interviews • Group presentations • Reflection sessions • 
                Results announcement and next steps briefing
              </Text>
            </View>
          </View>

          {/* Key Activities */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="list-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>Key Activities</Text>
            </View>
            
            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="chatbubbles-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Panel Interviews</Text>
                <Text style={styles.activityDescription}>
                  In-depth interviews with experienced Rotarians, former exchange students, and youth coordinators
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="people-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Group Challenges</Text>
                <Text style={styles.activityDescription}>
                  Team-based problem-solving scenarios to assess leadership and collaboration skills
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="globe-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Cultural Simulations</Text>
                <Text style={styles.activityDescription}>
                  Role-playing exercises simulating real exchange situations and cultural challenges
                </Text>
              </View>
            </View>

            <View style={styles.activityCard}>
              <View style={styles.activityIcon}>
                <Ionicons name="school-outline" size={20} color="#1A237E" />
              </View>
              <View style={styles.activityContent}>
                <Text style={styles.activityTitle}>Educational Sessions</Text>
                <Text style={styles.activityDescription}>
                  Information sessions about different countries, cultures, and exchange expectations
                </Text>
              </View>
            </View>
          </View>

          {/* What to Expect */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="eye-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>What to Expect</Text>
            </View>
            
            <View style={styles.expectationCard}>
              <Text style={styles.expectationTitle}>Intense but Fun</Text>
              <Text style={styles.expectationDescription}>
                The weekend is challenging but designed to be enjoyable and educational
              </Text>
            </View>

            <View style={styles.expectationCard}>
              <Text style={styles.expectationTitle}>Continuous Evaluation</Text>
              <Text style={styles.expectationDescription}>
                You'll be assessed throughout all activities, not just during formal interviews
              </Text>
            </View>

            <View style={styles.expectationCard}>
              <Text style={styles.expectationTitle}>Meet Like-minded Peers</Text>
              <Text style={styles.expectationDescription}>
                Connect with other motivated young people who share your passion for cultural exchange
              </Text>
            </View>

            <View style={styles.expectationCard}>
              <Text style={styles.expectationTitle}>Learn About Countries</Text>
              <Text style={styles.expectationDescription}>
                Discover detailed information about potential exchange destinations
              </Text>
            </View>
          </View>

          {/* Preparation Tips */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="bulb-outline" size={24} color="#1A237E" />
              <Text style={styles.sectionTitle}>How to Prepare</Text>
            </View>
            
            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Stay Informed</Text>
              <Text style={styles.tipDescription}>
                Read up on current events and different cultures around the world
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Practice Speaking</Text>
              <Text style={styles.tipDescription}>
                Be ready to articulate your thoughts clearly in both Dutch and English
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Be Yourself</Text>
              <Text style={styles.tipDescription}>
                Authenticity is valued more than trying to be who you think they want
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Stay Positive</Text>
              <Text style={styles.tipDescription}>
                Maintain a positive attitude even if activities become challenging
              </Text>
            </View>

            <View style={styles.tipCard}>
              <Text style={styles.tipTitle}>Ask Questions</Text>
              <Text style={styles.tipDescription}>
                Show genuine curiosity about the program and different countries
              </Text>
            </View>
          </View>

          {/* Important Note */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="heart" size={24} color="#E91E63" />
              <Text style={styles.noteTitle}>Remember</Text>
            </View>
            <Text style={styles.noteText}>
              The Selection Weekend is as much about finding the right fit as it is about evaluation. 
              Even if you're not selected this time, the experience itself is valuable and you can always 
              try again next year. Focus on learning, growing, and making connections!
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
  
  // Day Card Styles
  dayCard: {
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
  dayHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  dayTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  dayDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
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
  
  // Expectation Card Styles
  expectationCard: {
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
  expectationTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1976D2',
    marginBottom: 4,
  },
  expectationDescription: {
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
  
  // Note Card Styles
  noteCard: {
    backgroundColor: '#FCE4EC',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#E91E63',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#E91E63',
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
    color: '#C2185B',
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});