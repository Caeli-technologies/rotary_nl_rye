import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform, Pressable, Linking } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import * as Haptics from 'expo-haptics';
import { useTheme } from '@/hooks/use-theme';
const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function WhichCountriesScreen() {
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
            <View style={[styles.headerIcon, { backgroundColor: themeColors.primary + '20' }]}>
              <Ionicons name="globe-outline" size={32} color={themeColors.primary} />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>Met welke landen?</Text>
            <Text style={[styles.headerSubtitle, { color: themeColors.textSecondary }]}>
              Ontdek de bestemmingen beschikbaar voor Zomerkampen
            </Text>
          </View>

          {/* Main Content */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="globe-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Internationale Bestemmingen
              </Text>
            </View>

            <View
              style={[
                styles.regionCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.primary,
                },
              ]}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇪🇺</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={[styles.regionTitle, { color: themeColors.text }]}>Europa</Text>
                <Text style={[styles.regionDescription, { color: themeColors.textSecondary }]}>
                  Verschillende Europese landen met rijke cultuur en geschiedenis
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.regionCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.primary,
                },
              ]}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇨🇦</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={[styles.regionTitle, { color: themeColors.text }]}>Canada</Text>
                <Text style={[styles.regionDescription, { color: themeColors.textSecondary }]}>
                  Prachtige natuur en vriendelijke cultuur in Noord-Amerika
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.regionCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.primary,
                },
              ]}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇺🇸</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={[styles.regionTitle, { color: themeColors.text }]}>
                  Verenigde Staten
                </Text>
                <Text style={[styles.regionDescription, { color: themeColors.textSecondary }]}>
                  Diverse staten met verschillende ervaringen en culturen
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.regionCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                  borderLeftColor: themeColors.primary,
                },
              ]}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇹🇼</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={[styles.regionTitle, { color: themeColors.text }]}>Taiwan</Text>
                <Text style={[styles.regionDescription, { color: themeColors.textSecondary }]}>
                  Fascinierende Aziatische cultuur en moderne technologie
                </Text>
              </View>
            </View>
          </View>

          {/* Program Types */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Soorten Programma&apos;s
              </Text>
            </View>

            <View
              style={[
                styles.programCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.programIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="school-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.programContent}>
                <Text style={[styles.programTitle, { color: themeColors.text }]}>
                  Educatieve Tours
                </Text>
                <Text style={[styles.programDescription, { color: themeColors.textSecondary }]}>
                  Leren over geschiedenis, cultuur en taal
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.programCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.programIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="trail-sign-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.programContent}>
                <Text style={[styles.programTitle, { color: themeColors.text }]}>
                  Avontuur Kampen
                </Text>
                <Text style={[styles.programDescription, { color: themeColors.textSecondary }]}>
                  Buitenactiviteiten en natuurverkenning
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.programCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.programIcon, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="people-outline" size={20} color={themeColors.primary} />
              </View>
              <View style={styles.programContent}>
                <Text style={[styles.programTitle, { color: themeColors.text }]}>
                  Culturele Uitwisseling
                </Text>
                <Text style={[styles.programDescription, { color: themeColors.textSecondary }]}>
                  Onderdompeling in lokale gewoonten en tradities
                </Text>
              </View>
            </View>
          </View>

          {/* Contact Information */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="mail-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Aanmelden</Text>
            </View>

            <View
              style={[
                styles.emailCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <Text style={[styles.emailDescription, { color: themeColors.text }]}>
                Aanmelden via het emailadres{' '}
                <Text style={[styles.emailLink, { color: themeColors.primary }]}>
                  interesse@rotaryyep.nl
                </Text>
              </Text>
            </View>

            <View style={styles.buttonContainer}>
              <Pressable
                style={({ pressed }) => [
                  styles.emailButton,
                  { backgroundColor: themeColors.primary, shadowColor: themeColors.shadow },
                  pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
                ]}
                onPress={async () => {
                  try {
                    await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
                    const emailUrl =
                      'mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20Zomerkampen';
                    await Linking.openURL(emailUrl);
                  } catch (error) {
                    console.error('Error opening email:', error);
                  }
                }}
                accessibilityRole="button"
                accessibilityLabel="Contact Opnemen"
                accessibilityHint="Opent je email app voor het versturen van een email"
                android_ripple={{ color: 'rgba(255,255,255,0.2)', borderless: false }}>
                <Ionicons
                  name="mail"
                  size={20}
                  color={themeColors.card}
                  style={{ marginRight: 8 }}
                />
                <Text style={[styles.emailButtonText, { color: themeColors.card }]}>
                  Contact Opnemen
                </Text>
              </Pressable>
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

  // Destination Header
  destinationHeader: {
    alignItems: 'center',
    marginBottom: 24,
    paddingHorizontal: 16,
  },
  destinationTitle: {
    fontSize: 20,
    fontWeight: '700',
    marginBottom: 8,
  },
  destinationSubtitle: {
    fontSize: 14,
    textAlign: 'center',
    fontStyle: 'italic',
  },
  regionCard: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.08,
    shadowRadius: 20,
    elevation: 4,
  },
  regionIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 1 },
          shadowOpacity: 0.1,
          shadowRadius: 2,
        }
      : {
          elevation: 2,
        }),
  },
  regionEmoji: {
    fontSize: 24,
  },
  regionContent: {
    flex: 1,
  },
  regionTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  regionDescription: {
    fontSize: 14,
    lineHeight: 20,
  },

  // Program Card Styles
  programCard: {
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
        }),
  },
  programIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  programContent: {
    flex: 1,
  },
  programTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  programDescription: {
    fontSize: 14,
    lineHeight: 20,
  },

  // Email Card Styles
  emailCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 24,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  emailDescription: {
    fontSize: 16,
    lineHeight: 24,
    textAlign: 'center',
  },
  emailLink: {
    fontWeight: '600',
  },

  // Button Styles
  buttonContainer: {
    alignItems: 'center',
    marginTop: 8,
  },
  emailButton: {
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    paddingHorizontal: 24,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    minWidth: 200,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 3,
  },
  emailButtonText: {
    fontSize: 16,
    fontWeight: '600',
  },
});
