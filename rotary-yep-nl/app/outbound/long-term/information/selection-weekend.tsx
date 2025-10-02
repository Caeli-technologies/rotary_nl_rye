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

export default function SelectionWeekendScreen() {
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
              <Ionicons name="calendar-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Selectie weekend</Text>
            <Text style={styles.headerSubtitle}>
              Het selectieweekend als onderdeel van het uitwisselingsproces
            </Text>
          </View>

          {/* Weekend Goals */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Het weekend dient een aantal doelen:</Text>
            </View>

            <View style={styles.goalCard}>
              <View style={styles.goalNumber}>
                <Text style={styles.goalNumberText}>1</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={styles.goalText}>
                  <Text style={styles.underlineText}>Elkaar beter leren kennen.</Text> De groep
                  leert elkaar beter kennen en wij leren jullie beter{' '}
                  <Text style={styles.underlineText}>kennen.</Text> Wij kunnen zó beter inschatten
                  waar jullie als toekomstige Outbounds naar toe zouden kunnen gaan.
                </Text>
              </View>
            </View>

            <View style={styles.goalCard}>
              <View style={styles.goalNumber}>
                <Text style={styles.goalNumberText}>2</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={styles.goalText}>
                  <Text style={styles.underlineText}>Jezelf presenteren.</Text>
                </Text>
              </View>
            </View>

            <View style={styles.goalCard}>
              <View style={styles.goalNumber}>
                <Text style={styles.goalNumberText}>3</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={styles.goalText}>
                  <Text style={styles.underlineText}>Je oriënteren op een top-drie van landen</Text>{' '}
                  waarnaar je het liefst wilt worden uitgezonden. Zowel Internationaal als Europees.
                </Text>
              </View>
            </View>

            <View style={styles.goalCard}>
              <View style={styles.goalNumber}>
                <Text style={styles.goalNumberText}>4</Text>
              </View>
              <View style={styles.goalContent}>
                <Text style={styles.goalText}>
                  <Text style={styles.underlineText}>Selectie:</Text> Je kunt laten zien dat je uit
                  het goede &ldquo;uitwisselingshout&rdquo; bent gesneden. Aanwezigheid is
                  verplicht. Het weekend is dan ook onderdeel van de uiteindelijke selectie.
                </Text>
              </View>
            </View>
          </View>

          {/* Important Info */}
          <View style={styles.infoCard}>
            <View style={styles.infoHeader}>
              <Ionicons name="information-circle" size={24} color="#2196F3" />
              <Text style={styles.infoTitle}>Belangrijk om te weten</Text>
            </View>
            <Text style={styles.infoText}>
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
    marginBottom: 32,
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

  // Goal Card Styles
  goalCard: {
    backgroundColor: '#FFFFFF',
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
          borderColor: '#E0E0E0',
        }),
  },
  goalNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#FF6B35',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  goalNumberText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
  goalContent: {
    flex: 1,
  },
  goalText: {
    fontSize: 16,
    lineHeight: 22,
    color: '#333',
  },
  underlineText: {
    textDecorationLine: 'underline',
  },

  // Info Card Styles
  infoCard: {
    backgroundColor: '#E3F2FD',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#2196F3',
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
    color: '#1976D2',
    marginLeft: 8,
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
});
