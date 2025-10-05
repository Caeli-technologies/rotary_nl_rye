import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTheme } from '@/hooks/use-theme';

export default function TravelScreen() {
  const { colors: themeColors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={[styles.headerIcon, { backgroundColor: themeColors.primary + '15' }]}>
              <Ionicons name="map-outline" size={32} color={themeColors.primary} />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>Travel</Text>
            <Text style={[styles.headerSubtitle, { color: themeColors.textSecondary }]}>
              Exploring the Netherlands during your exchange year
            </Text>
          </View>

          {/* Travel Guidelines */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="document-text-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Travel Guidelines
              </Text>
            </View>

            <View
              style={[
                styles.guidelinesCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={styles.allowedSection}>
                <View style={styles.allowedHeader}>
                  <Ionicons name="checkmark-circle" size={20} color={themeColors.success} />
                  <Text style={[styles.allowedTitle, { color: themeColors.text }]}>
                    Allowed Travel
                  </Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="people-outline" size={16} color={themeColors.success} />
                  <Text style={[styles.allowedText, { color: themeColors.textSecondary }]}>
                    With your host family
                  </Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="business-outline" size={16} color={themeColors.success} />
                  <Text style={[styles.allowedText, { color: themeColors.textSecondary }]}>
                    With Rotary club members
                  </Text>
                </View>
                <View style={styles.allowedItem}>
                  <Ionicons name="school-outline" size={16} color={themeColors.success} />
                  <Text style={[styles.allowedText, { color: themeColors.textSecondary }]}>
                    On authorized school trips
                  </Text>
                </View>
              </View>

              <View style={[styles.restrictionNote, { backgroundColor: themeColors.info + '10' }]}>
                <Ionicons name="information-circle-outline" size={16} color={themeColors.info} />
                <Text style={[styles.restrictionText, { color: themeColors.textSecondary }]}>
                  Travel rules apply both inside the Netherlands and abroad
                </Text>
              </View>
            </View>
          </View>

          {/* Important Warning */}
          <View style={styles.section}>
            <View
              style={[
                styles.warningCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.error,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={styles.warningHeader}>
                <Ionicons name="close-circle-outline" size={24} color={themeColors.error} />
                <Text style={[styles.warningTitle, { color: themeColors.text }]}>
                  Strictly Prohibited
                </Text>
              </View>
              <Text style={[styles.warningText, { color: themeColors.error }]}>
                Visits to family or friends abroad are not permitted!
              </Text>
            </View>
          </View>

          {/* Host Family Holidays */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="airplane-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Host Family Holidays
              </Text>
            </View>

            <View
              style={[
                styles.holidayCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.warning,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={styles.holidayHeader}>
                <Ionicons name="document-outline" size={20} color={themeColors.warning} />
                <Text style={[styles.holidayTitle, { color: themeColors.text }]}>
                  Parental Approval Required
                </Text>
              </View>
              <Text style={[styles.holidayText, { color: themeColors.text }]}>
                One of your host families might suggest to participate in a holiday somewhere
                abroad. This is usually OK when you will have a written approval from your parents.
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
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    textAlign: 'center',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
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
    marginLeft: 12,
  },

  // Guidelines Card
  guidelinesCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.08,
          shadowRadius: 20,
        }
      : {
          elevation: 4,
          borderWidth: StyleSheet.hairlineWidth,
        }),
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
    marginLeft: 8,
  },
  restrictionNote: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    padding: 12,
    borderRadius: 8,
  },
  restrictionText: {
    fontSize: 14,
    marginLeft: 8,
    fontStyle: 'italic',
  },

  // Warning Card
  warningCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.08,
          shadowRadius: 20,
        }
      : {
          elevation: 4,
          borderWidth: StyleSheet.hairlineWidth,
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
    marginLeft: 8,
  },
  warningText: {
    fontSize: 16,
    lineHeight: 24,
    fontWeight: '600',
  },

  // Holiday Card
  holidayCard: {
    borderRadius: 16,
    padding: 20,
    marginBottom: 16,
    borderLeftWidth: 4,
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.08,
          shadowRadius: 20,
        }
      : {
          elevation: 4,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  holidayHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  holidayTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  holidayText: {
    fontSize: 16,
    lineHeight: 24,
  },
});
