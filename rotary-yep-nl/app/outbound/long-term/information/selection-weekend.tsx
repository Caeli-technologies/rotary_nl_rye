import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTheme } from '@/hooks/use-theme';
const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function SelectionWeekendScreen() {
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
              <Ionicons name="calendar-outline" size={32} color={themeColors.primary} />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>Selectie weekend</Text>
            <Text style={[styles.headerSubtitle, { color: themeColors.textSecondary }]}>
              Het selectieweekend als onderdeel van het uitwisselingsproces
            </Text>
          </View>

          {/* Weekend Goals */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag-outline" size={24} color={themeColors.primary} />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Het weekend dient een aantal doelen:
              </Text>
            </View>

            <View
              style={[
                styles.goalCard,
                { backgroundColor: themeColors.card, borderColor: themeColors.border },
              ]}>
              <View style={[styles.goalNumber, { backgroundColor: themeColors.primary }]}>
                <Text style={[styles.goalNumberText, { color: themeColors.card }]}>1</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={[styles.goalText, { color: themeColors.text }]}>
                  <Text style={[styles.underlineText, { color: themeColors.primary }]}>
                    Elkaar beter leren kennen.
                  </Text>{' '}
                  De groep leert elkaar beter kennen en wij leren jullie beter{' '}
                  <Text style={[styles.underlineText, { color: themeColors.primary }]}>
                    kennen.
                  </Text>{' '}
                  Wij kunnen zó beter inschatten waar jullie als toekomstige Outbounds naar toe
                  zouden kunnen gaan.
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.goalCard,
                { backgroundColor: themeColors.card, borderColor: themeColors.border },
              ]}>
              <View style={[styles.goalNumber, { backgroundColor: themeColors.primary }]}>
                <Text style={[styles.goalNumberText, { color: themeColors.card }]}>2</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={[styles.goalText, { color: themeColors.text }]}>
                  <Text style={[styles.underlineText, { color: themeColors.primary }]}>
                    Jezelf presenteren.
                  </Text>
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.goalCard,
                { backgroundColor: themeColors.card, borderColor: themeColors.border },
              ]}>
              <View style={[styles.goalNumber, { backgroundColor: themeColors.primary }]}>
                <Text style={[styles.goalNumberText, { color: themeColors.card }]}>3</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={[styles.goalText, { color: themeColors.text }]}>
                  <Text style={[styles.underlineText, { color: themeColors.primary }]}>
                    Je oriënteren op een top-drie van landen
                  </Text>{' '}
                  waarnaar je het liefst wilt worden uitgezonden. Zowel Internationaal als Europees.
                </Text>
              </View>
            </View>

            <View
              style={[
                styles.goalCard,
                { backgroundColor: themeColors.card, borderColor: themeColors.border },
              ]}>
              <View style={[styles.goalNumber, { backgroundColor: themeColors.primary }]}>
                <Text style={[styles.goalNumberText, { color: themeColors.card }]}>4</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={[styles.goalText, { color: themeColors.text }]}>
                  <Text style={[styles.underlineText, { color: themeColors.primary }]}>
                    Selectie:
                  </Text>{' '}
                  Je kunt laten zien dat je uit het goede &ldquo;uitwisselingshout&rdquo; bent
                  gesneden. Aanwezigheid is verplicht. Het weekend is dan ook onderdeel van de
                  uiteindelijke selectie.
                </Text>
              </View>
            </View>
          </View>

          {/* Important Info */}
          <View
            style={[
              styles.infoCard,
              { backgroundColor: themeColors.primary + '10', borderLeftColor: themeColors.primary },
            ]}>
            <View style={styles.infoHeader}>
              <Ionicons name="information-circle" size={24} color={themeColors.primary} />
              <Text style={[styles.infoTitle, { color: themeColors.primary }]}>
                Belangrijk om te weten
              </Text>
            </View>
            <Text style={[styles.infoText, { color: themeColors.text }]}>
              Je krijgt een mail van ons voor het weekend waarin staat wat je moet meenemen, en wat
              je moet voorbereiden. Het is altijd een topweekend.
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

  // Goal Card Styles
  goalCard: {
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 1,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  goalNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  goalNumberText: {
    fontSize: 16,
    fontWeight: '600',
  },
  goalContent: {
    flex: 1,
  },
  goalText: {
    fontSize: 16,
    lineHeight: 22,
  },
  underlineText: {
    textDecorationLine: 'underline',
  },

  // Info Card Styles
  infoCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 1,
        }),
  },
  infoHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  infoTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 8,
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
  },
});
