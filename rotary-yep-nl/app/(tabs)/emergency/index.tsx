import React from 'react';
import { ScrollView, StyleSheet, View, Text, Platform, Pressable } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Image } from 'expo-image';
import { Ionicons } from '@expo/vector-icons';
import { makePhoneCall, sendEmail } from '@/utils/communications';

import * as Haptics from 'expo-haptics';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface EmergencyContact {
  name: string;
  function: string;
  phone: string;
  email?: string;
}

export default function EmergencyScreen() {
  const rotaryYouthExchange: EmergencyContact[] = [
    {
      name: 'Barbara Tusveld',
      function: 'Voorzitter Rotary Youth Exchange',
      phone: '+31655128529',
    },
    {
      name: 'Marga Oosterveld',
      function: 'Voorzitter Longterm',
      phone: '+31629586813',
    },
    {
      name: 'Clasine Scheepers',
      function: 'Secretaris',
      phone: '+31652710977',
    },
    {
      name: 'Hilleke van der Veer',
      function: 'Landelijke Counselor',
      phone: '+31638300427',
    },
  ];

  const confidants: EmergencyContact[] = [
    {
      name: 'Pauline Memelink',
      function: 'Lawyer',
      phone: '+31624235624',
      email: 'p.memelink@t-mobilethuis.nl',
    },
    {
      name: 'Reinout Vriesendorp',
      function: "Doctor's office",
      phone: '+31182612676',
      email: 'info@medischcentrumwest.org',
    },
  ];

  const handleCall = async (phone: string, name: string) => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    }
    makePhoneCall(phone, name);
  };

  const handleEmail = async (email: string, name: string) => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    }
    sendEmail(email, name);
  };

  const EmergencyContactCard = ({ contact }: { contact: EmergencyContact }) => (
    <View style={styles.contactCard}>
      <View style={styles.contactInfo}>
        <Text style={styles.contactName}>{contact.name}</Text>
        <Text style={styles.contactFunction}>{contact.function}</Text>
        <Text style={styles.contactPhone}>{contact.phone}</Text>
      </View>
      <View style={styles.contactActions}>
        <Pressable
          style={({ pressed }) => [styles.actionButton, pressed && styles.actionButtonPressed]}
          onPress={() => handleCall(contact.phone, contact.name)}>
          <Ionicons name="call" size={20} color="#1A237E" />
        </Pressable>
        {contact.email && (
          <Pressable
            style={({ pressed }) => [styles.actionButton, pressed && styles.actionButtonPressed]}
            onPress={() => handleEmail(contact.email!, contact.name)}>
            <Ionicons name="mail" size={20} color="#1A237E" />
          </Pressable>
        )}
      </View>
    </View>
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <ScrollView
        style={styles.container}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Emergency 112 Section */}
          <View style={styles.emergencySection}>
            <View style={styles.emergencyHeader}>
              <Ionicons name="warning" size={24} color="#FF3B30" />
              <Text style={styles.emergencyTitle}>Emergency Services</Text>
            </View>
            <Text style={styles.emergencySubtitle}>112 for ambulance, fire brigade or police</Text>
            <Image
              source={require('@/assets/emergency/112_logo.png')}
              style={styles.emergencyImage}
              contentFit="contain"
            />
          </View>

          {/* Rotary Youth Exchange */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="shield-checkmark" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Rotary Youth Exchange</Text>
            </View>
            {rotaryYouthExchange.map((contact, index) => (
              <EmergencyContactCard key={index} contact={contact} />
            ))}
          </View>

          {/* Confidants */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="heart" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Independent Confidants</Text>
            </View>
            <Text style={styles.sectionDescription}>
              Not connected to Rotary - In case of f.e. sexual harassment
            </Text>
            {confidants.map((contact, index) => (
              <EmergencyContactCard key={index} contact={contact} />
            ))}
          </View>

          {/* Important Note */}
          <View style={styles.noteCard}>
            <View style={styles.noteHeader}>
              <Ionicons name="information-circle" size={24} color="#FF9800" />
              <Text style={styles.noteTitle}>Important Reminder</Text>
            </View>
            <Text style={styles.noteText}>
              Always keep your host family&apos;s contact information and home address accessible.
            </Text>
            <Text style={styles.noteText}>
              Your host parents can assist you with medical appointments, hospital visits, or dental
              care.
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: Platform.OS === 'android' ? 80 : 30,
  },

  // Emergency Section
  emergencySection: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 24,
    marginBottom: 20,
    alignItems: 'center',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 3,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  emergencyHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  emergencyTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  emergencySubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginBottom: 16,
  },
  emergencyImage: {
    width: '100%',
    height: 100,
    maxWidth: 200,
  },

  // Section Styles
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  sectionDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 16,
    lineHeight: 20,
  },

  // Contact Card Styles
  contactCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'center',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  contactInfo: {
    flex: 1,
  },
  contactName: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  contactFunction: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  contactPhone: {
    fontSize: 14,
    color: '#9FA8DA',
    fontWeight: '500',
  },
  contactActions: {
    flexDirection: 'row',
    gap: 8,
  },
  actionButton: {
    width: Platform.OS === 'ios' ? 44 : 48,
    height: Platform.OS === 'ios' ? 44 : 48,
    borderRadius: Platform.OS === 'ios' ? 22 : 24,
    backgroundColor: '#E8EAF6',
    justifyContent: 'center',
    alignItems: 'center',
  },
  actionButtonPressed: {
    backgroundColor: '#C5CAE9',
    opacity: 0.8,
  },

  // Note Card Styles
  noteCard: {
    backgroundColor: '#FFF8E1',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginTop: 8,
    borderLeftWidth: 4,
    borderLeftColor: '#FF9800',
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF9800',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 1,
        }),
  },
  noteHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  noteTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#E65100',
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    marginBottom: 8,
    color: '#333',
  },
});
