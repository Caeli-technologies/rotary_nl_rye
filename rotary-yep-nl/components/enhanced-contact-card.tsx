import React, { useState, useCallback } from 'react';
import { View, StyleSheet, Pressable, Platform, Text } from 'react-native';
import { NetworkImage } from './network-image';
import { Contact, Organization, Rotex } from '@/types/contact';
import { useContactInfo } from '@/hooks/use-contact-info';
import { Ionicons } from '@expo/vector-icons';
import { ContactModal } from './contact-modal';

import * as Haptics from 'expo-haptics';

interface ContactCardProps {
  contact: Contact | Organization | Rotex;
  index: number;
}

// Helper functions for safe data access
const getOrgClub = (contact: Contact | Organization | Rotex): string | undefined => {
  const orgContact = contact as Organization;
  return orgContact.club && orgContact.club.trim() !== '' ? orgContact.club : undefined;
};

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export function ContactCard({ contact, index }: ContactCardProps) {
  const [showDetails, setShowDetails] = useState(false);
  const contactInfo = useContactInfo(contact);

  const handleCardPress = useCallback(async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    setShowDetails(true);
  }, []);

  return (
    <>
      <Pressable
        style={({ pressed }) => [styles.card, pressed && styles.cardPressed]}
        onPress={handleCardPress}>
        <View style={styles.content}>
          <NetworkImage
            imageUrl={contact.imageUrl}
            name={contact.name}
            size={60}
            expandable={false}
            style={styles.contactImage}
          />

          <View style={styles.middleSection}>
            <Text style={styles.name} numberOfLines={1}>
              {contact.name}
            </Text>
            {contactInfo.primaryFunction && (
              <Text style={styles.function} numberOfLines={1}>
                {contactInfo.primaryFunction}
              </Text>
            )}
            {contactInfo.isOrg && getOrgClub(contact) && (
              <Text style={styles.organization} numberOfLines={1}>
                {getOrgClub(contact)}
              </Text>
            )}
          </View>

          <Ionicons
            name={Platform.OS === 'ios' ? 'chevron-forward' : 'chevron-forward-outline'}
            size={Platform.OS === 'ios' ? 20 : 24}
            color={Platform.OS === 'ios' ? '#C7C7CC' : '#9FA8DA'}
          />
        </View>
      </Pressable>

      <ContactModal contact={contact} visible={showDetails} onClose={() => setShowDetails(false)} />
    </>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    marginHorizontal: Platform.OS === 'ios' ? 0 : 16,
    marginBottom: Platform.OS === 'ios' ? 0 : 12,
    borderBottomWidth: Platform.OS === 'ios' ? 0 : StyleSheet.hairlineWidth,
    borderBottomColor: '#E0E0E0',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
        }),
  },
  cardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#F5F5F5',
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: Platform.OS === 'ios' ? 80 : 88,
  },
  contactImage: {
    marginRight: 16,
  },
  middleSection: {
    flex: 1,
  },
  name: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 4,
    color: '#1A237E',
  },
  function: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  organization: {
    fontSize: 12,
    color: '#999',
  },
});
