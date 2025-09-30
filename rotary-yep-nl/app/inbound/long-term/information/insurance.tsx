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

export default function InsuranceScreen() {

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
            <Text style={styles.headerTitle}>Insurance</Text>
            <Text style={styles.headerSubtitle}>
              Comprehensive insurance coverage for your exchange year
            </Text>
          </View>

          {/* Compulsory Coverage */}
          <View style={styles.section}>
            <View style={styles.compulsoryCard}>
              <View style={styles.compulsoryHeader}>
                <Ionicons name="alert-circle-outline" size={24} color="#FF6B35" />
                <Text style={styles.compulsoryTitle}>Compulsory Coverage</Text>
              </View>
              <Text style={styles.compulsoryText}>
                The insurance policy from the Netherlands is compulsory. We will pre-insure you, so you will be fully insured as soon as you will land at Amsterdam Schiphol airport up until you are leaving at the airport again.
              </Text>
            </View>
          </View>

          {/* Coverage Timeline */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="time-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Coverage Timeline</Text>
            </View>
            
            <View style={styles.timelineCard}>
              <View style={styles.timelineItem}>
                <View style={styles.timelineIcon}>
                  <Ionicons name="airplane-outline" size={20} color="#2196F3" />
                </View>
                <View style={styles.timelineContent}>
                  <Text style={styles.timelineTitle}>Arrival at Schiphol</Text>
                  <Text style={styles.timelineText}>Coverage begins immediately upon landing</Text>
                </View>
              </View>
              
              <View style={styles.timelineLine} />
              
              <View style={styles.timelineItem}>
                <View style={styles.timelineIcon}>
                  <Ionicons name="calendar-outline" size={20} color="#4CAF50" />
                </View>
                <View style={styles.timelineContent}>
                  <Text style={styles.timelineTitle}>During Exchange</Text>
                  <Text style={styles.timelineText}>Full coverage throughout your stay</Text>
                </View>
              </View>
              
              <View style={styles.timelineLine} />
              
              <View style={styles.timelineItem}>
                <View style={styles.timelineIcon}>
                  <Ionicons name="home-outline" size={20} color="#FF9800" />
                </View>
                <View style={styles.timelineContent}>
                  <Text style={styles.timelineTitle}>Departure</Text>
                  <Text style={styles.timelineText}>Coverage ends when you leave the airport</Text>
                </View>
              </View>
            </View>
          </View>

          {/* Policy Documents */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="document-text-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Policy Documents</Text>
            </View>
            
            <View style={styles.documentCard}>
              <View style={styles.documentHeader}>
                <Ionicons name="mail-outline" size={20} color="#4CAF50" />
                <Text style={styles.documentTitle}>Document Delivery</Text>
              </View>
              <Text style={styles.documentText}>
                A copy of the Insurance Policy will be sent to you a few days before you leave your home country.
              </Text>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 16,
    paddingBottom: 34,
  },
  
  // Header Section
  headerSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 32,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#E8F5E8',
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
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 12,
  },
  
  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },
  
  // Compulsory Card
  compulsoryCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
    ...shadowStyle,
  },
  compulsoryHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  compulsoryTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  compulsoryText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Timeline Card
  timelineCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },
  timelineItem: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  timelineIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#E8EAF6',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  timelineContent: {
    flex: 1,
    paddingBottom: 16,
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  timelineText: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  timelineLine: {
    width: 2,
    height: 20,
    backgroundColor: '#E0E0E0',
    marginLeft: 19,
    marginVertical: 4,
  },
  
  // Document Card
  documentCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...shadowStyle,
  },
  documentHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  documentTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  documentText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Requirement Card
  requirementCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
    ...shadowStyle,
  },
  requirementHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  requirementTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  requirementText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  bulletPoint: {
    flexDirection: 'row',
    marginBottom: 12,
    alignItems: 'flex-start',
  },
  bullet: {
    fontSize: 16,
    fontWeight: '700',
    color: '#FF6B35',
    marginRight: 12,
    marginTop: 2,
  },
  bulletText: {
    flex: 1,
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});
