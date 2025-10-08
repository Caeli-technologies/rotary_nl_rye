import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { RotaryColors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export default function CampsToursComplyWithScreen() {
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
              <Ionicons name="people-outline" size={32} color={themeColors.primary} />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>Voor wie?</Text>
            <Text style={[styles.headerSubtitle, { color: themeColors.textSecondary }]}>
              Leeftijd en deelname informatie voor Zomerkampen
            </Text>
          </View>

          {/* Age Requirements */}
          <View style={styles.section}>
            <View style={(styles.sectionHeader, { borderLeftColor: themeColors.primary })}>
              <Ionicons name="calendar-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Leeftijdsvereisten
              </Text>
            </View>

            <View
              style={[
                styles.ageCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View
                style={[styles.ageIconContainer, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="person-outline" size={32} color={themeColors.primary} />
              </View>
              <View style={styles.ageContent}>
                <Text style={[styles.ageTitle, { color: themeColors.primary }]}>15 - 21 jaar</Text>
                <Text style={[styles.ageDescription, { color: themeColors.textSecondary }]}>
                  Perfecte leeftijd voor internationale ervaringen en persoonlijke groei
                </Text>
              </View>
            </View>
          </View>

          {/* Eligibility */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Wie kan deelnemen?
              </Text>
            </View>

            <View
              style={[
                styles.eligibilityCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={styles.eligibilityItem}>
                <View
                  style={[styles.eligibilityIcon, { backgroundColor: themeColors.primary + '15' }]}>
                  <Ionicons name="people-outline" size={20} color={themeColors.primary} />
                </View>
                <View style={styles.eligibilityContent}>
                  <Text style={[styles.eligibilityTitle, { color: themeColors.text }]}>
                    Rotarian Families
                  </Text>
                  <Text
                    style={[styles.eligibilityDescription, { color: themeColors.textSecondary }]}>
                    Kinderen en kleinkinderen van Rotary leden
                  </Text>
                </View>
              </View>

              <View style={[styles.eligibilityDivider, { backgroundColor: themeColors.border }]} />

              <View style={styles.eligibilityItem}>
                <View
                  style={[
                    styles.eligibilityIcon,
                    { backgroundColor: RotaryColors.cardinal + '15' },
                  ]}>
                  <Ionicons name="heart-outline" size={20} color={RotaryColors.cardinal} />
                </View>
                <View style={styles.eligibilityContent}>
                  <Text style={[styles.eligibilityTitle, { color: themeColors.text }]}>
                    Non-Rotarian Youth
                  </Text>
                  <Text
                    style={[styles.eligibilityDescription, { color: themeColors.textSecondary }]}>
                    Alle gemotiveerde jongeren uit de gemeenschap
                  </Text>
                </View>
              </View>
            </View>
          </View>

          {/* What to Expect */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Wat kun je verwachten?
              </Text>
            </View>

            <View
              style={[
                styles.expectationCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View
                style={[styles.expectationIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="globe-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.expectationContent}>
                <Text style={[styles.expectationTitle, { color: themeColors.text }]}>
                  Internationale Ervaring
                </Text>
                <Text style={[styles.expectationDescription, { color: themeColors.textSecondary }]}>
                  Ontdek nieuwe culturen en maak vrienden over de hele wereld
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.expectationCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View
                style={[styles.expectationIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="school-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.expectationContent}>
                <Text style={[styles.expectationTitle, { color: themeColors.text }]}>
                  Persoonlijke Ontwikkeling
                </Text>
                <Text style={[styles.expectationDescription, { color: themeColors.textSecondary }]}>
                  Ontwikkel zelfvertrouwen en leiderschapsvaardigheden
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.expectationCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View
                style={[styles.expectationIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="camera-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.expectationContent}>
                <Text style={[styles.expectationTitle, { color: themeColors.text }]}>
                  Onvergetelijke Herinneringen
                </Text>
                <Text style={[styles.expectationDescription, { color: themeColors.textSecondary }]}>
                  Creëer levenslange herinneringen en verhalen om te delen
                </Text>
              </View>
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
    marginLeft: 12,
  },

  // Age Card Styles
  ageCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'center',
    borderLeftWidth: 4,
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  ageIconContainer: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  ageContent: {
    flex: 1,
  },
  ageTitle: {
    fontSize: 24,
    fontWeight: '700',
    marginBottom: 4,
  },
  ageDescription: {
    fontSize: 14,
    lineHeight: 20,
  },

  // Eligibility Card Styles
  eligibilityCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  eligibilityItem: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    paddingVertical: 8,
  },
  eligibilityIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  eligibilityContent: {
    flex: 1,
  },
  eligibilityTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  eligibilityDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  eligibilityDivider: {
    height: 1,
    marginVertical: 16,
    marginLeft: 56,
  },

  // Expectation Card Styles
  expectationCard: {
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  expectationIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  expectationContent: {
    flex: 1,
  },
  expectationTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  expectationDescription: {
    fontSize: 14,
    lineHeight: 20,
  },

  // CTA Card Styles
  ctaCard: {
    backgroundColor: '#FFF3F0',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderWidth: 2,
    borderColor: '#FF6B35',
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF6B35',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 2,
        }),
  },
  ctaHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
    justifyContent: 'center',
  },
  ctaTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#FF6B35',
    marginLeft: 8,
  },
  ctaText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    textAlign: 'center',
  },
});
