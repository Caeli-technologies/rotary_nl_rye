import React, { useState, useCallback } from 'react';
import { View, StyleSheet, Pressable, Modal, ScrollView, Dimensions, Platform, Linking, Text, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { NetworkImage } from './network-image';
import { makePhoneCall, sendEmail } from '../utils/communications';
import { Contact, Organization, Rotex } from '@/types/contact';
import { useContactInfo } from '@/hooks/use-contact-info';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { StatusBar } from 'expo-status-bar';
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

const getOrgDistrict = (contact: Contact | Organization | Rotex): string | undefined => {
  const orgContact = contact as Organization;
  return orgContact.district && orgContact.district.trim() !== '' ? orgContact.district : undefined;
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

  const handleCall = useCallback(async () => {
    if (contact.phoneNumber) {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      makePhoneCall(contact.phoneNumber, contact.name);
    }
  }, [contact.phoneNumber, contact.name]);

  const handleEmail = useCallback(async () => {
    if (contact.email) {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      sendEmail(contact.email, contact.name);
    }
  }, [contact.email, contact.name]);

  const handleSocialMedia = useCallback(async (url: string) => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    Linking.canOpenURL(url).then(supported => {
      if (supported) {
        Linking.openURL(url);
      } else {
        Alert.alert('Cannot open URL', 'Unable to open the requested social media link');
      }
    }).catch(err => console.error('Error opening URL:', err));
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
      <View style={styles.detailSection}>
        <Text style={styles.sectionTitle}>Social Media</Text>
        <View style={styles.socialLinksContainer}>
          {validPlatforms.map(platform => (
            <Pressable 
              key={platform.key}
              style={({ pressed }) => [
                styles.socialLink,
                pressed && styles.socialLinkPressed
              ]}
              onPress={() => handleSocialMedia(platform.url!)}
            >
              <Ionicons name={platform.icon} size={24} color={platform.color} />
              <Text style={styles.socialLinkText}>
                {platform.key.charAt(0).toUpperCase() + platform.key.slice(1)}
              </Text>
            </Pressable>
          ))}
        </View>
      </View>
    );
  }, [contactInfo.hasSocial, contact, handleSocialMedia]);

  return (
    <>
      <Pressable 
        style={({ pressed }) => [
          styles.card,
          pressed && styles.cardPressed
        ]}
        onPress={handleCardPress}
      >
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

      <Modal
        visible={showDetails}
        animationType="slide"
        presentationStyle={Platform.OS === 'ios' ? 'pageSheet' : 'fullScreen'}
        onRequestClose={() => setShowDetails(false)}
      >
        <SafeAreaView style={styles.modalContainer} edges={['top', 'left', 'right', 'bottom']}>
          <StatusBar style="light" />
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>Contact Details</Text>
            <Pressable 
              style={({ pressed }) => [
                styles.closeButton,
                pressed && styles.closeButtonPressed
              ]}
              onPress={() => setShowDetails(false)}
              hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
            >
              <Ionicons name="close" size={28} color="#FFFFFF" />
            </Pressable>
          </View>
          
          <ScrollView 
            style={styles.modalContent} 
            showsVerticalScrollIndicator={false}
            contentInsetAdjustmentBehavior="automatic"
          >
            <View style={styles.profileSection}>
              <View style={styles.profileImageContainer}>
                <NetworkImage 
                  imageUrl={contact.imageUrl} 
                  name={contact.name} 
                  size={100} 
                  expandable={true}
                  showInitials={true}
                />
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
              </View>
              <Text style={styles.detailName}>{contact.name}</Text>
              
              {contact.functions && contact.functions.length > 0 && (
                <View style={styles.functionsContainer}>
                  {contact.functions.filter(func => func && func.trim() !== '').map((func, idx) => (
                    <View key={idx} style={styles.functionChip}>
                      <Text style={styles.functionText}>{func}</Text>
                    </View>
                  ))}
                </View>
              )}
            </View>

            {contactInfo.hasOrgInfo && (
              <View style={styles.detailSection}>
                <Text style={styles.sectionTitle}>Organization</Text>
                {getOrgClub(contact) && (
                  <Text style={styles.detailText}>Club: {getOrgClub(contact)}</Text>
                )}
                {getOrgDistrict(contact) && (
                  <Text style={styles.detailText}>District: {getOrgDistrict(contact)}</Text>
                )}
              </View>
            )}

            {contactInfo.hasContact && (
              <View style={styles.detailSection}>
                <Text style={styles.sectionTitle}>Contact Information</Text>
                {contact.email && contact.email.trim() !== '' && (
                  <Pressable 
                    style={({ pressed }) => [
                      styles.contactRow,
                      pressed && styles.contactRowPressed
                    ]} 
                    onPress={handleEmail}
                  >
                    <Ionicons name="mail" size={20} color="#1A237E" />
                    <Text style={styles.contactText}>{contact.email}</Text>
                  </Pressable>
                )}
                {contact.phoneNumber && contact.phoneNumber.trim() !== '' && (
                  <Pressable 
                    style={({ pressed }) => [
                      styles.contactRow,
                      pressed && styles.contactRowPressed
                    ]}
                    onPress={handleCall}
                  >
                    <Ionicons name="call" size={20} color="#1A237E" />
                    <Text style={styles.contactText}>{contact.phoneNumber}</Text>
                  </Pressable>
                )}
              </View>
            )}

            {contactInfo.hasBio && (
              <View style={styles.detailSection}>
                <Text style={styles.sectionTitle}>Biography</Text>
                <Text style={styles.bioText}>{contact.bio}</Text>
              </View>
            )}

            {renderSocialLinks()}
          </ScrollView>
        </SafeAreaView>
      </Modal>
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
    ...(Platform.OS === 'ios' ? shadowStyle : {
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
  modalContainer: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    paddingTop: Platform.OS === 'ios' ? 20 : 20,
    backgroundColor: '#1f4e79',
    minHeight: 60,
  },
  modalTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 20,
    fontWeight: '600',
    color: '#FFFFFF',
  },
  closeButton: {
    padding: 10,
    borderRadius: 20,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
  },
  closeButtonPressed: {
    backgroundColor: 'rgba(255, 255, 255, 0.3)',
  },
  modalContent: {
    flex: 1,
    padding: 20,
  },
  profileSection: {
    alignItems: 'center',
    marginBottom: 24,
    padding: 24,
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    ...(Platform.OS === 'ios' ? {
      ...shadowStyle,
      shadowOpacity: 0.12,
    } : {
      elevation: 3,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  profileImageContainer: {
    position: 'relative',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
  },
  logoContainer: {
    position: 'absolute',
    bottom: -8,
    right: -8,
    backgroundColor: '#FFFFFF',
    borderRadius: 20,
    padding: 6,
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.15,
      shadowRadius: 4,
    } : {
      elevation: 4,
    }),
  },
  organizationLogo: {
    width: 24,
    height: 24,
  },
  detailName: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
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
    color: '#FFFFFF',
  },
  detailSection: {
    backgroundColor: '#FFFFFF',
    padding: 20,
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    marginBottom: 16,
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
  },
  detailText: {
    fontSize: 16,
    color: '#333',
    marginBottom: 8,
    lineHeight: 22,
  },
  contactRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    backgroundColor: '#F8F9FA',
    borderRadius: 8,
    marginBottom: 12,
  },
  contactRowPressed: {
    backgroundColor: '#E8EAF6',
  },
  contactText: {
    fontSize: 16,
    color: '#1A237E',
    flex: 1,
    marginLeft: 12,
    fontWeight: '500',
  },
  bioText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  socialLinksContainer: {
    gap: 12,
  },
  socialLink: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 16,
    backgroundColor: '#F8F9FA',
    borderRadius: 12,
  },
  socialLinkPressed: {
    backgroundColor: '#E8EAF6',
  },
  socialLinkText: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333',
    marginLeft: 12,
    flex: 1,
  },
});