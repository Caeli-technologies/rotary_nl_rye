import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function CampsToursComplyWithScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="people-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Voor wie?</Text>
            <Text style={styles.headerSubtitle}>
              Leeftijd en deelname informatie voor Camps & Tours
            </Text>
          </View>

          {/* Age Requirements */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="calendar-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Leeftijdsvereisten</Text>
            </View>

            <View style={styles.ageCard}>
              <View style={styles.ageIconContainer}>
                <Ionicons name="person-outline" size={32} color="#4CAF50" />
              </View>
              <View style={styles.ageContent}>
                <Text style={styles.ageTitle}>15 - 21 jaar</Text>
                <Text style={styles.ageDescription}>
                  Perfecte leeftijd voor internationale ervaringen en persoonlijke groei
                </Text>
              </View>
            </View>
          </View>

          {/* Eligibility */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Wie kan deelnemen?</Text>
            </View>

            <View style={styles.eligibilityCard}>
              <View style={styles.eligibilityItem}>
                <View style={styles.eligibilityIcon}>
                  <Ionicons name="people-outline" size={20} color="#2196F3" />
                </View>
                <View style={styles.eligibilityContent}>
                  <Text style={styles.eligibilityTitle}>Rotarian Families</Text>
                  <Text style={styles.eligibilityDescription}>
                    Kinderen en kleinkinderen van Rotary leden
                  </Text>
                </View>
              </View>

              <View style={styles.eligibilityDivider} />

              <View style={styles.eligibilityItem}>
                <View style={styles.eligibilityIcon}>
                  <Ionicons name="heart-outline" size={20} color="#E91E63" />
                </View>
                <View style={styles.eligibilityContent}>
                  <Text style={styles.eligibilityTitle}>Non-Rotarian Youth</Text>
                  <Text style={styles.eligibilityDescription}>
                    Alle gemotiveerde jongeren uit de gemeenschap
                  </Text>
                </View>
              </View>
            </View>
          </View>

          {/* What to Expect */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Wat kun je verwachten?</Text>
            </View>

            <View style={styles.expectationCard}>
              <View style={styles.expectationIcon}>
                <Ionicons name="globe-outline" size={20} color="#FF6B35" />
              </View>
              <View style={styles.expectationContent}>
                <Text style={styles.expectationTitle}>Internationale Ervaring</Text>
                <Text style={styles.expectationDescription}>
                  Ontdek nieuwe culturen en maak vrienden over de hele wereld
                </Text>
              </View>
            </View>

            <View style={styles.expectationCard}>
              <View style={styles.expectationIcon}>
                <Ionicons name="school-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.expectationContent}>
                <Text style={styles.expectationTitle}>Persoonlijke Ontwikkeling</Text>
                <Text style={styles.expectationDescription}>
                  Ontwikkel zelfvertrouwen en leiderschapsvaardigheden
                </Text>
              </View>
            </View>

            <View style={styles.expectationCard}>
              <View style={styles.expectationIcon}>
                <Ionicons name="camera-outline" size={20} color="#9C27B0" />
              </View>
              <View style={styles.expectationContent}>
                <Text style={styles.expectationTitle}>Onvergetelijke Herinneringen</Text>
                <Text style={styles.expectationDescription}>
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

  // Age Card Styles
  ageCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  ageIconContainer: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: '#E8F5E8',
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
    color: '#4CAF50',
    marginBottom: 4,
  },
  ageDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },

  // Eligibility Card Styles
  eligibilityCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
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
    backgroundColor: '#F5F5F5',
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
    color: '#1A237E',
    marginBottom: 4,
  },
  eligibilityDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  eligibilityDivider: {
    height: 1,
    backgroundColor: '#E0E0E0',
    marginVertical: 16,
    marginLeft: 56,
  },

  // Expectation Card Styles
  expectationCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 1,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  expectationIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
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
    color: '#1A237E',
    marginBottom: 4,
  },
  expectationDescription: {
    fontSize: 14,
    color: '#666',
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
