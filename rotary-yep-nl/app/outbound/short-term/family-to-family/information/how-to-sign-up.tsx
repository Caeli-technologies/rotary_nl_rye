import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
  TouchableOpacity,
  Linking,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function FamilyToFamilyHowToSignUpScreen() {
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
              <Ionicons name="document-text-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Hoe schrijf ik mezelf in</Text>
            <Text style={styles.headerSubtitle}>
              Stappen om je aan te melden voor het Family-to-Family programma
            </Text>
          </View>

          {/* Email instructies */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="mail-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Aanmelding</Text>
            </View>

            <View style={styles.instructionCard}>
              <Text style={styles.instructionText}>Je stuurt een gezellig email bericht naar:</Text>
              <Text style={styles.emailText}>interesse@rotaryyep.nl</Text>
              <Text style={styles.instructionText}>
                Dan krijg je van ons een bevestiging dat we je mail hebben ontvangen.
              </Text>
            </View>
          </View>

          {/* Email Button */}
          <View style={styles.buttonSection}>
            <TouchableOpacity
              style={styles.emailButton}
              onPress={() =>
                Linking.openURL(
                  'mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20Family-to-Family%20programma',
                )
              }>
              <Ionicons name="mail" size={24} color="#FFFFFF" style={styles.buttonIcon} />
              <Text style={styles.emailButtonText}>Verstuur Email</Text>
            </TouchableOpacity>
            <Text style={styles.buttonDescription}>
              Klik om direct een email te sturen naar interesse@rotaryyep.nl
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

  // Instruction Card Styles
  instructionCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  instructionText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    marginBottom: 12,
  },
  emailText: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2196F3',
    textAlign: 'center',
    paddingVertical: 12,
    marginBottom: 12,
  },

  // Button Section Styles
  buttonSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 20,
  },
  emailButton: {
    backgroundColor: '#FF6B35',
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 25,
    marginBottom: 12,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF6B35',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.3,
          shadowRadius: 4,
        }
      : {
          elevation: 4,
        }),
  },
  buttonIcon: {
    marginRight: 8,
  },
  emailButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
  buttonDescription: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    lineHeight: 20,
    paddingHorizontal: 20,
  },

  // Update Section
  updateSection: {
    alignItems: 'center',
    paddingVertical: 30,
    marginTop: 20,
  },
  updateText: {
    fontSize: 14,
    color: '#777777',
  },
});
