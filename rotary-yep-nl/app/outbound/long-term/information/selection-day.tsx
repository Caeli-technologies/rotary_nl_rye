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

export default function SelectionDayScreen() {
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
            <Text style={styles.headerTitle}>Selectie dag</Text>
            <Text style={styles.headerSubtitle}>
              Wat je kunt verwachten tijdens de selectiedag voor Rotary Youth Exchange
            </Text>
          </View>

          {/* What to do */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Wat moet ik doen voor de selectie dag:</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>Ik zou gewoon je best en doen en jezelf zijn.</Text>
            </View>
          </View>

          {/* What to expect */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="eye-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Dit is wat je deze dag kan verwachten:</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Je krijgt een interview, een groepsgesprek, een discussie en een test over je kennis
                van Nederland.
              </Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Dit zijn een paar voorbeeld vragen uit het interview tijdens de selectie dag. We
                gaan je niet alles vertellen, maar zo krijg je een beetje een idee.
              </Text>
            </View>
          </View>

          {/* Example Questions */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="help-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Voorbeeld vragen:</Text>
            </View>

            <View style={styles.questionCard}>
              <Text style={styles.questionText}>
                Wat betekent volgens jou het zijn van Ambassadeur voor Rotary
              </Text>
            </View>

            <View style={styles.questionCard}>
              <Text style={styles.questionText}>
                Wie is je rolmodel, voor wie heb je bewondering
              </Text>
            </View>

            <View style={styles.questionCard}>
              <Text style={styles.questionText}>
                Wat was de gelukkigste/mooiste dag in je leven
              </Text>
            </View>

            <View style={styles.questionCard}>
              <Text style={styles.questionText}>Op welke eigenschap ben je het meest trots</Text>
            </View>

            <View style={styles.questionCard}>
              <Text style={styles.questionText}>
                Wat denk je dat het moeilijkste is als je een jaar in het buitenland bent
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

  // Info Card
  infoCard: {
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
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // Activity Card Styles
  activityCard: {
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

  // Question Card Styles
  questionCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 1,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  questionText: {
    fontSize: 14,
    color: '#666',
    fontStyle: 'italic',
    lineHeight: 20,
  },

  // Footer Section
  footerSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginTop: 20,
  },
  rotaryLogo: {
    marginBottom: 8,
  },
  updateText: {
    fontSize: 14,
    color: '#777777',
  },
});
