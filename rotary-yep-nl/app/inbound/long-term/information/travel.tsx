import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
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

export default function TravelScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      

      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="map-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Travel</Text>
            <Text style={styles.headerSubtitle}>
              Exploring the Netherlands during your exchange year
            </Text>
          </View>

          {/* Travel Guidelines */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons
                name="document-text-outline"
                size={24}
                color="#FF6B35"
              />
              <Text style={styles.sectionTitle}>Travel Guidelines</Text>
            </View>

            <View style={styles.guidelinesCard}>
              <View style={styles.allowedSection}>
                <View style={styles.allowedHeader}>
                  <Ionicons name="checkmark-circle" size={20} color="#4CAF50" />
                  <Text style={styles.allowedTitle}>Allowed Travel</Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="people-outline" size={16} color="#4CAF50" />
                  <Text style={styles.allowedText}>With your host family</Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="business-outline" size={16} color="#4CAF50" />
                  <Text style={styles.allowedText}>
                    With Rotary club members
                  </Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="school-outline" size={16} color="#4CAF50" />
                  <Text style={styles.allowedText}>
                    On authorized school trips
                  </Text>
                </View>
              </View>

              <View style={styles.restrictionNote}>
                <Ionicons
                  name="information-circle-outline"
                  size={16}
                  color="#2196F3"
                />
                <Text style={styles.restrictionText}>
                  Travel rules apply both inside the Netherlands and abroad
                </Text>
              </View>
            </View>
          </View>

          {/* Important Warning */}
          <View style={styles.section}>
            <View style={styles.warningCard}>
              <View style={styles.warningHeader}>
                <Ionicons
                  name="close-circle-outline"
                  size={24}
                  color="#F44336"
                />
                <Text style={styles.warningTitle}>Strictly Prohibited</Text>
              </View>
              <Text style={styles.warningText}>
                Visits to family or friends abroad are not permitted!
              </Text>
            </View>
          </View>

          {/* Host Family Holidays */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="airplane-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Host Family Holidays</Text>
            </View>

            <View style={styles.holidayCard}>
              <View style={styles.holidayHeader}>
                <Ionicons name="document-outline" size={20} color="#FF9800" />
                <Text style={styles.holidayTitle}>
                  Parental Approval Required
                </Text>
              </View>
              <Text style={styles.holidayText}>
                One of your host families might suggest to participate in a
                holiday somewhere abroad. This is usually OK when you will have
                a written approval from your parents.
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
    backgroundColor: '#FFF8E1',
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

  // Main Card
  mainCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 24,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...shadowStyle,
  },
  mainText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // Rules Card
  rulesCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
    ...shadowStyle,
  },
  rulesHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  rulesTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },

  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },

  // Warning Card
  warningCard: {
    backgroundColor: '#FFEBEE',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#F44336',
    ...shadowStyle,
  },

  // Guidelines Card
  guidelinesCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...shadowStyle,
  },
  allowedSection: {
    marginBottom: 16,
  },
  allowedHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  allowedTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  allowedItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    paddingLeft: 12,
  },
  allowedText: {
    fontSize: 14,
    color: '#333',
    marginLeft: 8,
  },
  restrictionNote: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    padding: 12,
    backgroundColor: '#E3F2FD',
    borderRadius: 8,
  },
  restrictionText: {
    fontSize: 14,
    color: '#1976D2',
    marginLeft: 8,
    fontStyle: 'italic',
  },

  // Holiday Card
  holidayCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
    ...shadowStyle,
  },
  holidayHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  holidayTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  holidayText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
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
    fontWeight: '600',
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
