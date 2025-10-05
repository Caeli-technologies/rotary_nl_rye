import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTheme } from '@/hooks/use-theme';

export default function FlightAndArrivalScreen() {
  const { colors: themeColors } = useTheme();

  const renderFlightInfo = (icon: string, title: string, items: string[]) => (
    <View style={styles.section} key={title}>
      <View style={styles.sectionHeader}>
        <Ionicons name={icon as any} size={24} color={themeColors.primary} />
        <Text style={[styles.sectionTitle, { color: themeColors.text }]}>{title}</Text>
      </View>

      <View
        style={[
          styles.infoCard,
          {
            backgroundColor: themeColors.card,
            shadowColor: themeColors.shadow,
            borderColor: themeColors.border,
          },
        ]}>
        {items.map((item, index) => (
          <View style={styles.bulletPoint} key={index}>
            <Text style={[styles.bullet, { color: themeColors.primary }]}>•</Text>
            <Text style={[styles.bulletText, { color: themeColors.textSecondary }]}>{item}</Text>
          </View>
        ))}
      </View>
    </View>
  );

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <ScrollView
        style={[styles.scrollView, { backgroundColor: themeColors.background }]}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={[styles.headerIcon, { backgroundColor: themeColors.primary + '15' }]}>
              <Ionicons name="airplane-outline" size={32} color={themeColors.primary} />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>Flight & Arrival</Text>
            <Text style={[styles.headerSubtitle, { color: themeColors.textSecondary }]}>
              Important information about your flight and arrival in the Netherlands
            </Text>
          </View>

          {/* Flight Information */}
          {renderFlightInfo('airplane-outline', 'Flight', [
            'You should obtain a changeable open return airline ticket',
            'Your arrival airport is Amsterdam (Schiphol) Airport',
          ])}

          {/* Arrival Information */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="location-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Arrival</Text>
            </View>

            <View
              style={[
                styles.infoCard,
                {
                  backgroundColor: themeColors.card,
                  shadowColor: themeColors.shadow,
                  borderColor: themeColors.border,
                },
              ]}>
              <Text style={[styles.infoText, { color: themeColors.textSecondary }]}>
                More arrival information will be provided closer to your departure date.
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

  // Info Card
  infoCard: {
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
  bulletPoint: {
    flexDirection: 'row',
    marginBottom: 12,
    alignItems: 'flex-start',
  },
  bullet: {
    fontSize: 16,
    fontWeight: '700',
    marginRight: 12,
    marginTop: 2,
  },
  bulletText: {
    flex: 1,
    fontSize: 16,
    lineHeight: 24,
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
  },
});
