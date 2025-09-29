import React, { useState, useCallback } from 'react';
import { View, StyleSheet, TouchableOpacity, Pressable, Modal, ScrollView, Dimensions, Platform, Linking } from 'react-native';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';
import { NetworkImage } from './network-image';
import { makePhoneCall, sendEmail } from '../utils/communications';
import { Contact, Organization, Rotex } from '@/types/contact';
import { useContactInfo } from '@/hooks/use-contact-info';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';

interface ContactCardProps {
  contact: Contact | Organization | Rotex;
  index: number;
}

const { width: screenWidth } = Dimensions.get('window');

// Helper functions for safe data access
const getOrgClub = (contact: Contact | Organization | Rotex): string | undefined => {
  const orgContact = contact as Organization;
  return orgContact.club && orgContact.club.trim() !== '' ? orgContact.club : undefined;
};

const getOrgDistrict = (contact: Contact | Organization | Rotex): string | undefined => {
  const orgContact = contact as Organization;
  return orgContact.district && orgContact.district.trim() !== '' ? orgContact.district : undefined;
};

export function ContactCard({ contact, index }: ContactCardProps) {
  const [showDetails, setShowDetails] = useState(false);
  const contactInfo = useContactInfo(contact);

  const handleCall = useCallback(() => {
    if (contact.phoneNumber) {
      makePhoneCall(contact.phoneNumber, contact.name);
    }
  }, [contact.phoneNumber, contact.name]);

  const handleEmail = useCallback(() => {
    if (contact.email) {
      sendEmail(contact.email, contact.name);
    }
  }, [contact.email, contact.name]);

  const handleSocialMedia = useCallback((url: string) => {
    Linking.openURL(url).catch(err => console.error('Error opening URL:', err));
  }, []);

  const renderSocialLinks = useCallback(() => {
    if (!contactInfo.hasSocial) return null;
    
    const rotexContact = contact as Rotex;
    const socialMedia = rotexContact.socialMedia!;
    
    const socialPlatforms = [
      { key: 'instagram', icon: 'logo-instagram', color: '#E4405F', url: socialMedia.instagram },
      { key: 'facebook', icon: 'logo-facebook', color: '#1877F2', url: socialMedia.facebook },
      { key: 'linkedin', icon: 'logo-linkedin', color: '#0A66C2', url: socialMedia.linkedin },
    ] as const;

    const validPlatforms = socialPlatforms.filter(platform => platform.url && platform.url.trim() !== '');
    
    // Don't render section if no valid social media links
    if (validPlatforms.length === 0) return null;

    return (
      <ThemedView style={styles.detailSection}>
        <ThemedText style={styles.sectionTitle}>Social Media</ThemedText>
        <ThemedView style={styles.socialLinksContainer}>
          {validPlatforms.map(platform => (
            <TouchableOpacity 
              key={platform.key}
              style={styles.socialLink}
              onPress={() => handleSocialMedia(platform.url!)}
            >
              <Ionicons name={platform.icon} size={24} color={platform.color} />
              <ThemedText style={styles.socialLinkText}>
                {platform.key.charAt(0).toUpperCase() + platform.key.slice(1)}
              </ThemedText>
            </TouchableOpacity>
          ))}
        </ThemedView>
      </ThemedView>
    );
  }, [contactInfo.hasSocial, contact, handleSocialMedia]);

  return (
    <>
      <TouchableOpacity 
        style={styles.card} 
        onPress={() => setShowDetails(true)}
        activeOpacity={0.7}
      >
        <ThemedView style={styles.content}>
          <NetworkImage imageUrl={contact.imageUrl} name={contact.name} size={60} />
          
          <ThemedView style={styles.middleSection}>
            <ThemedText style={styles.name} numberOfLines={1}>
              {contact.name}
            </ThemedText>
            {contactInfo.primaryFunction && (
              <ThemedText style={styles.function} numberOfLines={1}>
                {contactInfo.primaryFunction}
              </ThemedText>
            )}
            {contactInfo.isOrg && getOrgClub(contact) && (
              <ThemedText style={styles.organization} numberOfLines={1}>
                {getOrgClub(contact)}
              </ThemedText>
            )}
          </ThemedView>
          
          <Ionicons name="chevron-forward" size={20} color="#999" />
        </ThemedView>
      </TouchableOpacity>

      <Modal
        visible={showDetails}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={() => setShowDetails(false)}
      >
        <ThemedView style={styles.modalContainer}>
          <ThemedView style={styles.modalHeader}>
            <ThemedText style={styles.modalTitle}>Contact Details</ThemedText>
            <TouchableOpacity 
              style={styles.closeButton}
              onPress={() => setShowDetails(false)}
              hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
            >
              <Ionicons name="close" size={28} color="#FFFFFF" />
            </TouchableOpacity>
          </ThemedView>
          
          <ScrollView style={styles.modalContent} showsVerticalScrollIndicator={false}>
            <ThemedView style={styles.profileSection}>
              <ThemedView style={styles.profileImageContainer}>
                <NetworkImage imageUrl={contact.imageUrl} name={contact.name} size={80} />
                {contactInfo.isRotex && (
                  <View style={styles.logoContainer}>
                    <Image 
                      source={require('@/assets/logo/rotex_logo_light.svg')}
                      style={styles.organizationLogo}
                      contentFit="contain"
                    />
                  </View>
                )}
                {contactInfo.isOrg && (
                  <View style={styles.logoContainer}>
                    <Image 
                      source={require('@/assets/logo/rotary-logo-icon.svg')}
                      style={styles.organizationLogo}
                      contentFit="contain"
                      tintColor="#f7a81b"
                    />
                  </View>
                )}
              </ThemedView>
              <ThemedText style={styles.detailName}>{contact.name}</ThemedText>
              
              {contact.functions && contact.functions.length > 0 && (
                <ThemedView style={styles.functionsContainer}>
                  {contact.functions.filter(func => func && func.trim() !== '').map((func, idx) => (
                    <ThemedView key={idx} style={styles.functionChip}>
                      <ThemedText style={styles.functionText}>{func}</ThemedText>
                    </ThemedView>
                  ))}
                </ThemedView>
              )}
            </ThemedView>

            {contactInfo.hasOrgInfo && (
              <ThemedView style={styles.detailSection}>
                <ThemedText style={styles.sectionTitle}>Organization</ThemedText>
                {getOrgClub(contact) && (
                  <ThemedText style={styles.detailText}>Club: {getOrgClub(contact)}</ThemedText>
                )}
                {getOrgDistrict(contact) && (
                  <ThemedText style={styles.detailText}>District: {getOrgDistrict(contact)}</ThemedText>
                )}
              </ThemedView>
            )}

            {contactInfo.hasContact && (
              <ThemedView style={styles.detailSection}>
                <ThemedText style={styles.sectionTitle}>Contact Information</ThemedText>
                {contact.email && contact.email.trim() !== '' && (
                  <TouchableOpacity style={styles.contactRow} onPress={handleEmail}>
                    <Ionicons name="mail" size={20} color="#1f4e79" />
                    <ThemedText style={styles.contactText}>{contact.email}</ThemedText>
                  </TouchableOpacity>
                )}
                {contact.phoneNumber && contact.phoneNumber.trim() !== '' && (
                  <TouchableOpacity style={styles.contactRow} onPress={handleCall}>
                    <Ionicons name="call" size={20} color="#1f4e79" />
                    <ThemedText style={styles.contactText}>{contact.phoneNumber}</ThemedText>
                  </TouchableOpacity>
                )}
              </ThemedView>
            )}

            {contactInfo.hasBio && (
              <ThemedView style={styles.detailSection}>
                <ThemedText style={styles.sectionTitle}>Biography</ThemedText>
                <ThemedText style={styles.bioText}>{contact.bio}</ThemedText>
              </ThemedView>
            )}

            {renderSocialLinks()}
          </ScrollView>
        </ThemedView>
      </Modal>
    </>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: '#fff',
    borderRadius: 12,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  content: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    gap: 12,
  },
  middleSection: {
    flex: 1,
  },
  name: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
    color: '#333',
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
  modalContainer: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    paddingTop: Platform.OS === 'ios' ? 60 : 20,
    backgroundColor: '#1f4e79',
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#FFFFFF',
  },
  closeButton: {
    padding: 8,
  },
  modalContent: {
    flex: 1,
    padding: 20,
  },
  profileSection: {
    alignItems: 'center',
    marginBottom: 24,
    padding: 20,
    backgroundColor: '#fff',
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  profileImageContainer: {
    position: 'relative',
    alignItems: 'center',
    justifyContent: 'center',
  },
  logoContainer: {
    position: 'absolute',
    bottom: -8,
    right: -8,
    backgroundColor: '#fff',
    borderRadius: 20,
    padding: 6,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 3,
    elevation: 3,
  },
  organizationLogo: {
    width: 24,
    height: 24,
  },
  detailName: {
    fontSize: 24,
    fontWeight: '700',
    color: '#333',
    marginTop: 16,
    textAlign: 'center',
  },
  functionsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    marginTop: 12,
    gap: 8,
  },
  functionChip: {
    backgroundColor: '#1f4e79',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
  },
  functionText: {
    fontSize: 12,
    fontWeight: '500',
    color: '#fff',
  },
  detailSection: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 12,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 2,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  detailText: {
    fontSize: 14,
    color: '#666',
    marginBottom: 4,
  },
  contactRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
    gap: 12,
  },
  contactText: {
    fontSize: 16,
    color: '#1f4e79',
    flex: 1,
  },
  bioText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#444',
  },
  socialLinksContainer: {
    gap: 12,
  },
  socialLink: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    backgroundColor: '#f8f9fa',
    borderRadius: 8,
    gap: 12,
  },
  socialLinkText: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333',
  },
});