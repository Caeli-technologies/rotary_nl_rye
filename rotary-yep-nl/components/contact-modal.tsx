import React, { useCallback } from 'react';
import {
  Modal,
  View,
  Text,
  ScrollView,
  Pressable,
  Platform,
  StyleSheet,
  Linking,
  Alert,
} from 'react-native';
import { Colors, RotaryColors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { NetworkImage } from './network-image';
import { makePhoneCall, sendEmail } from '../utils/communications';
import { Contact, Organization, Rotex } from '@/types/contact';
import { useContactInfo } from '@/hooks/use-contact-info';
import { Image } from 'expo-image';

interface ContactModalProps {
  contact: Contact | Organization | Rotex;
  visible: boolean;
  onClose: () => void;
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
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export function ContactModal({ contact, visible, onClose }: ContactModalProps) {
  const { colors: themeColors } = useTheme();
  const contactInfo = useContactInfo(contact);

  const handleCall = useCallback(async () => {
    if (contact.phoneNumber) {
      try {
        await import('expo-haptics').then((haptics) => {
          if (Platform.OS === 'ios') {
            haptics.impactAsync(haptics.ImpactFeedbackStyle.Light);
          }
        });
      } catch {}
      makePhoneCall(contact.phoneNumber, contact.name);
    }
  }, [contact.phoneNumber, contact.name]);

  const handleEmail = useCallback(async () => {
    if (contact.email) {
      try {
        await import('expo-haptics').then((haptics) => {
          if (Platform.OS === 'ios') {
            haptics.impactAsync(haptics.ImpactFeedbackStyle.Light);
          }
        });
      } catch {}
      sendEmail(contact.email, contact.name);
    }
  }, [contact.email, contact.name]);

  const handleSocialMedia = useCallback(async (url: string) => {
    try {
      await import('expo-haptics').then((haptics) => {
        if (Platform.OS === 'ios') {
          haptics.impactAsync(haptics.ImpactFeedbackStyle.Light);
        }
      });
    } catch {}

    Linking.canOpenURL(url)
      .then((supported) => {
        if (supported) {
          Linking.openURL(url);
        } else {
          Alert.alert('Cannot open URL', 'Unable to open the requested social media link');
        }
      })
      .catch((err) => console.error('Error opening URL:', err));
  }, []);

  const renderSocialLinks = useCallback(() => {
    // Only show social media for Rotex contacts
    if (!contactInfo.isRotex) return null;

    const rotexContact = contact as Rotex;
    if (!rotexContact.socialMedia) return null;

    const socialMedia = rotexContact.socialMedia;

    const socialPlatforms = [
      {
        key: 'instagram',
        icon: 'logo-instagram',
        color: '#E4405F',
        url: socialMedia.instagram,
      },
      {
        key: 'facebook',
        icon: 'logo-facebook',
        color: '#1877F2',
        url: socialMedia.facebook,
      },
      {
        key: 'snapchat',
        icon: 'logo-snapchat',
        color: '#FFFC00',
        url: socialMedia.snapchat,
      },
      {
        key: 'linkedin',
        icon: 'logo-linkedin',
        color: '#0A66C2',
        url: socialMedia.linkedin,
      },
      {
        key: 'website',
        icon: 'globe-outline',
        color: '#6366F1',
        url: socialMedia.website,
      },
    ] as const;

    const validPlatforms = socialPlatforms.filter(
      (platform) => platform.url && platform.url.trim() !== '',
    );

    // Don't render section if no valid social media links
    if (validPlatforms.length === 0) return null;

    return (
      <View
        style={[
          styles.detailSection,
          {
            backgroundColor: themeColors.card,
            borderColor: themeColors.border,
            shadowColor: themeColors.shadow,
          },
        ]}>
        <View style={[styles.sectionHeader, { borderBottomColor: themeColors.border }]}>
          <Ionicons name="share-social-outline" size={20} color={themeColors.primary} />
          <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Social Media</Text>
        </View>
        <View style={styles.sectionContent}>
          {validPlatforms.map((platform) => (
            <Pressable
              key={platform.key}
              style={({ pressed }) => [
                styles.socialLink,
                { backgroundColor: themeColors.backgroundElevated },
                pressed && styles.socialLinkPressed,
              ]}
              onPress={() => handleSocialMedia(platform.url!)}
              accessibilityRole="button"
              accessibilityLabel={`Open ${platform.key} profile`}
              accessibilityHint="Opens in external app">
              <View
                style={[styles.socialIconContainer, { backgroundColor: platform.color + '15' }]}>
                <Ionicons name={platform.icon} size={20} color={platform.color} />
              </View>
              <View style={styles.socialTextContainer}>
                <Text style={[styles.socialLabel, { color: themeColors.textSecondary }]}>
                  Follow on
                </Text>
                <Text style={[styles.socialLinkText, { color: themeColors.text }]}>
                  {platform.key.charAt(0).toUpperCase() + platform.key.slice(1)}
                </Text>
              </View>
              <Ionicons name="open-outline" size={16} color={themeColors.textTertiary} />
            </Pressable>
          ))}
        </View>
      </View>
    );
  }, [contactInfo.isRotex, contact, handleSocialMedia, themeColors]);

  return (
    <Modal
      visible={visible}
      animationType="slide"
      presentationStyle={Platform.OS === 'ios' ? 'pageSheet' : 'fullScreen'}
      onRequestClose={onClose}>
      <View style={[styles.modalContainer, { backgroundColor: themeColors.background }]}>
        {/* Modal Handle Bar (iOS style) */}
        {Platform.OS === 'ios' && (
          <View style={styles.modalHandle}>
            <View style={[styles.modalHandleBar, { backgroundColor: themeColors.textTertiary }]} />
          </View>
        )}

        {/* Header with Contact Details */}
        <View style={[styles.modalHeader, { borderBottomColor: themeColors.border }]}>
          <View style={styles.modalTitleContainer}>
            <Text style={[styles.modalTitle, { color: themeColors.text }]}>Contact Details</Text>
          </View>
          <Pressable
            style={({ pressed }) => [styles.closeButton, pressed && styles.closeButtonPressed]}
            onPress={onClose}
            accessibilityRole="button"
            accessibilityLabel="Close contact details"
            hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
            <Ionicons name="close" size={24} color={themeColors.text} />
          </Pressable>
        </View>

        <ScrollView
          style={styles.modalBody}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic">
          <View
            style={[
              styles.profileSection,
              {
                backgroundColor: themeColors.card,
                borderColor: themeColors.border,
                shadowColor: themeColors.shadow,
              },
            ]}>
            <View style={styles.profileImageContainer}>
              <NetworkImage
                imageUrl={contact.imageUrl}
                name={contact.name}
                size={100}
                expandable={true}
                showInitials={true}
              />
              {contactInfo.isRotex && (
                <View
                  style={[
                    styles.logoContainer,
                    { backgroundColor: themeColors.card, shadowColor: themeColors.shadow },
                  ]}>
                  <Image
                    source={require('@/assets/logo/rotex_logo_light.svg')}
                    style={styles.organizationLogo}
                    contentFit="contain"
                  />
                </View>
              )}
              {contactInfo.isOrg && (
                <View
                  style={[
                    styles.logoContainer,
                    { backgroundColor: themeColors.card, shadowColor: themeColors.shadow },
                  ]}>
                  <Image
                    source={require('@/assets/logo/rotary-logo-icon.svg')}
                    style={styles.organizationLogo}
                    contentFit="contain"
                    tintColor={RotaryColors.gold}
                  />
                </View>
              )}
            </View>
            <Text style={[styles.detailName, { color: themeColors.primary }]}>{contact.name}</Text>

            {contact.functions && contact.functions.length > 0 && (
              <View style={styles.functionsContainer}>
                {contact.functions
                  .filter((func) => func && func.trim() !== '')
                  .map((func, idx) => (
                    <View
                      key={idx}
                      style={[styles.functionChip, { backgroundColor: themeColors.primary }]}>
                      <Text style={[styles.functionText, { color: themeColors.card }]}>{func}</Text>
                    </View>
                  ))}
              </View>
            )}
          </View>

          {contactInfo.hasOrgInfo && (
            <View
              style={[
                styles.detailSection,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.sectionHeader, { borderBottomColor: themeColors.border }]}>
                <Ionicons name="business-outline" size={20} color={themeColors.primary} />
                <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Organization</Text>
              </View>
              <View style={styles.sectionContent}>
                {getOrgClub(contact) && (
                  <View
                    style={[styles.orgRow, { backgroundColor: themeColors.backgroundElevated }]}>
                    <View
                      style={[
                        styles.orgIconContainer,
                        { backgroundColor: themeColors.secondary + '15' },
                      ]}>
                      <Image
                        source={require('@/assets/logo/rotary-logo-icon.svg')}
                        style={styles.orgIcon}
                        contentFit="contain"
                        tintColor={themeColors.secondary}
                      />
                    </View>
                    <View style={styles.orgTextContainer}>
                      <Text style={[styles.orgLabel, { color: themeColors.textSecondary }]}>
                        Rotary Club
                      </Text>
                      <Text style={[styles.orgText, { color: themeColors.text }]}>
                        {getOrgClub(contact)}
                      </Text>
                    </View>
                  </View>
                )}
                {getOrgDistrict(contact) && (
                  <View
                    style={[styles.orgRow, { backgroundColor: themeColors.backgroundElevated }]}>
                    <View
                      style={[
                        styles.orgIconContainer,
                        { backgroundColor: themeColors.accent + '15' },
                      ]}>
                      <Ionicons name="globe-outline" size={20} color={themeColors.accent} />
                    </View>
                    <View style={styles.orgTextContainer}>
                      <Text style={[styles.orgLabel, { color: themeColors.textSecondary }]}>
                        District
                      </Text>
                      <Text style={[styles.orgText, { color: themeColors.text }]}>
                        {getOrgDistrict(contact)}
                      </Text>
                    </View>
                  </View>
                )}
              </View>
            </View>
          )}

          {contactInfo.hasContact && (
            <View
              style={[
                styles.detailSection,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.sectionHeader, { borderBottomColor: themeColors.border }]}>
                <Ionicons name="call-outline" size={20} color={themeColors.primary} />
                <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                  Contact Information
                </Text>
              </View>
              <View style={styles.sectionContent}>
                {contact.email && contact.email.trim() !== '' && (
                  <Pressable
                    style={({ pressed }) => [
                      styles.contactRow,
                      { backgroundColor: themeColors.backgroundElevated },
                      pressed && styles.contactRowPressed,
                    ]}
                    onPress={handleEmail}
                    accessibilityRole="button"
                    accessibilityLabel={`Send email to ${contact.email}`}
                    accessibilityHint="Opens email app">
                    <View
                      style={[
                        styles.contactIconContainer,
                        { backgroundColor: themeColors.primary + '15' },
                      ]}>
                      <Ionicons name="mail" size={20} color={themeColors.primary} />
                    </View>
                    <View style={styles.contactTextContainer}>
                      <Text style={[styles.contactLabel, { color: themeColors.textSecondary }]}>
                        Email
                      </Text>
                      <Text style={[styles.contactText, { color: themeColors.text }]}>
                        {contact.email}
                      </Text>
                    </View>
                    <Ionicons name="chevron-forward" size={16} color={themeColors.textTertiary} />
                  </Pressable>
                )}
                {contact.phoneNumber && contact.phoneNumber.trim() !== '' && (
                  <Pressable
                    style={({ pressed }) => [
                      styles.contactRow,
                      { backgroundColor: themeColors.backgroundElevated },
                      pressed && styles.contactRowPressed,
                    ]}
                    onPress={handleCall}
                    accessibilityRole="button"
                    accessibilityLabel={`Call ${contact.phoneNumber}`}
                    accessibilityHint="Opens phone app">
                    <View
                      style={[
                        styles.contactIconContainer,
                        { backgroundColor: themeColors.primary + '15' },
                      ]}>
                      <Ionicons name="call" size={20} color={themeColors.primary} />
                    </View>
                    <View style={styles.contactTextContainer}>
                      <Text style={[styles.contactLabel, { color: themeColors.textSecondary }]}>
                        Phone
                      </Text>
                      <Text style={[styles.contactText, { color: themeColors.text }]}>
                        {contact.phoneNumber}
                      </Text>
                    </View>
                    <Ionicons name="chevron-forward" size={16} color={themeColors.textTertiary} />
                  </Pressable>
                )}
              </View>
            </View>
          )}

          {contactInfo.hasBio && (
            <View
              style={[
                styles.detailSection,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                  shadowColor: themeColors.shadow,
                },
              ]}>
              <View style={[styles.sectionHeader, { borderBottomColor: themeColors.border }]}>
                <Ionicons name="person-outline" size={20} color={themeColors.primary} />
                <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Biography</Text>
              </View>
              <View style={styles.sectionContent}>
                <Text style={[styles.bioText, { color: themeColors.text }]}>{contact.bio}</Text>
              </View>
            </View>
          )}

          {renderSocialLinks()}
        </ScrollView>
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  modalContainer: {
    flex: 1,
  },
  modalHandle: {
    alignItems: 'center',
    paddingVertical: 12,
  },
  modalHandleBar: {
    width: 36,
    height: 4,
    borderRadius: 2,
    opacity: 0.4,
  },
  modalTitleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'ios' ? 8 : 20,
    paddingBottom: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: '600',
    flex: 1,
    marginRight: 16,
  },
  closeButton: {
    padding: 4,
  },
  closeButtonPressed: {
    opacity: 0.6,
    transform: Platform.OS === 'ios' ? [{ scale: 0.95 }] : [],
  },
  modalBody: {
    padding: 20,
  },
  profileSection: {
    alignItems: 'center',
    marginBottom: 24,
    padding: 24,
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 3,
          borderWidth: StyleSheet.hairlineWidth,
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
    borderRadius: 20,
    padding: 6,
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.15,
          shadowRadius: 4,
        }
      : {
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
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
  },
  functionText: {
    fontSize: 12,
    fontWeight: '500',
  },
  detailSection: {
    borderRadius: 12,
    marginBottom: 16,
    overflow: 'hidden',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  sectionContent: {
    padding: 16,
  },
  detailText: {
    fontSize: 16,
    marginBottom: 8,
    lineHeight: 22,
  },
  contactRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderRadius: 12,
    marginBottom: 8,
  },
  contactRowPressed: {
    opacity: 0.7,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  contactIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  contactTextContainer: {
    flex: 1,
  },
  contactLabel: {
    fontSize: 12,
    fontWeight: '500',
    marginBottom: 2,
  },
  contactText: {
    fontSize: 16,
    fontWeight: '500',
  },
  bioText: {
    fontSize: 16,
    lineHeight: 24,
  },

  socialLink: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderRadius: 12,
    marginBottom: 8,
  },
  socialLinkPressed: {
    opacity: 0.7,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  socialIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  socialTextContainer: {
    flex: 1,
  },
  socialLabel: {
    fontSize: 12,
    fontWeight: '500',
    marginBottom: 2,
  },
  socialLinkText: {
    fontSize: 16,
    fontWeight: '500',
  },
  orgRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderRadius: 12,
    marginBottom: 8,
  },
  orgIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  orgIcon: {
    width: 20,
    height: 20,
  },
  orgTextContainer: {
    flex: 1,
  },
  orgLabel: {
    fontSize: 12,
    fontWeight: '500',
    marginBottom: 2,
  },
  orgText: {
    fontSize: 16,
    fontWeight: '500',
  },
});
