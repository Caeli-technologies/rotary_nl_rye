import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function HowToSignUpScreen() {
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
              Stappen om jezelf in te schrijven voor de lange termijn uitwisseling
            </Text>
          </View>

          {/* Email Instructions */}
          <View style={styles.section}>
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Je stuurt een gezellig email bericht naar:{' '}
                <Text style={styles.emailText}>interesse@rotaryyep.nl.</Text> Dan krijg je van ons
                een bevestiging dat we je mail hebben ontvangen.
              </Text>
            </View>
          </View>

          {/* Email Button */}
          <View style={styles.buttonSection}>
            <TouchableOpacity
              style={styles.emailButton}
              onPress={() => {
                // This would open the email client
                console.log('Opening email client');
              }}>
              <Ionicons name="mail-outline" size={24} color="#FFFFFF" />
              <Text style={styles.emailButtonText}>Verstuur een Email</Text>
            </TouchableOpacity>
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
    backgroundColor: '#E8EAF6',
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

  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 24,
    ...shadowStyle,
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  emailText: {
    color: '#2196F3',
    textDecorationLine: 'underline',
  },

  // Button Section
  buttonSection: {
    alignItems: 'center',
    marginBottom: 32,
  },
  emailButton: {
    backgroundColor: '#FF6B35',
    borderRadius: Platform.OS === 'ios' ? 25 : 8,
    paddingVertical: Platform.OS === 'ios' ? 16 : 14,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    minWidth: 200,
    justifyContent: 'center',
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF6B35',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.2,
          shadowRadius: 4,
        }
      : {
          elevation: 3,
        }),
  },
  emailButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
});
