import React, { useLayoutEffect, useState } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Pressable,
  Platform,
  Animated,
  Linking,
} from 'react-native';
import { Colors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { SafeAreaView } from 'react-native-safe-area-context';
import * as Haptics from 'expo-haptics';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useNavigation } from 'expo-router';
import { NetworkImage } from '@/components/network-image';
import { Student, StudentType } from '@/types/student';
import { getFlagAsset } from '@/utils/flags';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface ActionButtonProps {
  icon: keyof typeof Ionicons.glyphMap;
  title: string;
  subtitle?: string;
  onPress: () => void;
  disabled?: boolean;
  styles: any;
  themeColors: typeof Colors.light;
}

function ActionButton({
  icon,
  title,
  subtitle,
  onPress,
  disabled = false,
  styles,
  themeColors,
}: ActionButtonProps) {
  const [scaleAnim] = useState(new Animated.Value(1));

  const handlePressIn = () => {
    if (!disabled && Platform.OS === 'ios') {
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    Animated.spring(scaleAnim, {
      toValue: 0.98,
      useNativeDriver: true,
    }).start();
  };

  const handlePressOut = () => {
    Animated.spring(scaleAnim, {
      toValue: 1,
      useNativeDriver: true,
    }).start();
  };

  return (
    <Animated.View style={{ transform: [{ scale: scaleAnim }] }}>
      <Pressable
        style={({ pressed }) => [
          styles.actionButton,
          {
            backgroundColor: themeColors.card,
            borderColor: themeColors.border,
            shadowColor: themeColors.shadow,
          },
          disabled && styles.actionButtonDisabled,
          !disabled && pressed && styles.actionButtonPressed,
        ]}
        onPress={disabled ? undefined : onPress}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        disabled={disabled}
        android_ripple={{
          color: themeColors.primary + '20',
          borderless: false,
        }}
        accessibilityRole="button"
        accessibilityLabel={title}
        accessibilityHint={subtitle}>
        <View style={styles.actionButtonContent}>
          <View
            style={[
              styles.actionIconContainer,
              { backgroundColor: themeColors.primary + '15' },
              disabled && styles.actionIconDisabled,
            ]}>
            <Ionicons
              name={icon}
              size={24}
              color={disabled ? themeColors.textTertiary : themeColors.primary}
            />
          </View>
          <View style={styles.actionTextContainer}>
            <Text
              style={[
                styles.actionTitle,
                { color: disabled ? themeColors.textTertiary : themeColors.text },
                disabled && styles.actionTitleDisabled,
              ]}
              numberOfLines={1}>
              {title}
            </Text>
            {subtitle && (
              <Text
                style={[
                  styles.actionSubtitle,
                  { color: disabled ? themeColors.textTertiary : themeColors.textSecondary },
                  disabled && styles.actionSubtitleDisabled,
                ]}
                numberOfLines={2}>
                {subtitle}
              </Text>
            )}
          </View>
          {!disabled && (
            <Ionicons
              name={Platform.OS === 'ios' ? 'chevron-forward' : 'chevron-forward-outline'}
              size={Platform.OS === 'ios' ? 20 : 24}
              color={themeColors.textTertiary}
            />
          )}
        </View>
      </Pressable>
    </Animated.View>
  );
}

interface StudentDetailProps {
  student: Student;
  studentType: StudentType;
}

export function StudentDetail({ student, studentType }: StudentDetailProps) {
  const { colors: themeColors } = useTheme();
  const navigation = useNavigation();

  const fromFlagAsset = student ? getFlagAsset(student.fromFlag) : null;
  const toFlagAsset = student ? getFlagAsset(student.toFlag) : null;

  const handleContactPress = async (
    type: 'email' | 'phone' | 'instagram' | 'snapchat' | 'facebook' | 'website' | 'linkedin',
  ) => {
    if (!student) return;

    let url = '';
    switch (type) {
      case 'email':
        if (student.email) url = `mailto:${student.email}`;
        break;
      case 'phone':
        if (student.phoneNumber) url = `tel:${student.phoneNumber}`;
        break;
      case 'instagram':
        if (student.instagramUrl) url = student.instagramUrl;
        break;
      case 'snapchat':
        if (student.snapchatUrl) url = student.snapchatUrl;
        break;
      case 'facebook':
        if (student.facebookUrl) url = student.facebookUrl;
        break;
      case 'website':
        if (student.websiteUrl) url = student.websiteUrl;
        break;
      case 'linkedin':
        if (student.linkedinUrl) url = student.linkedinUrl;
        break;
    }

    if (url) {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      Linking.openURL(url);
    }
  };

  // Configure navigation header with student name
  useLayoutEffect(() => {
    if (student) {
      navigation.setOptions({
        title: student.name,
        headerTitle: () => (
          <View
            style={{
              alignItems: Platform.OS === 'ios' ? 'center' : 'flex-start',
            }}>
            <Text
              style={{
                fontSize: Platform.OS === 'ios' ? 18 : 20,
                fontWeight: '600',
                color: themeColors.text,
              }}
              numberOfLines={1}>
              {student.name}
            </Text>
            <Text
              style={{
                fontSize: 13,
                fontWeight: '400',
                marginTop: 2,
                color: themeColors.textSecondary,
              }}>
              {studentType === 'outbound' ? 'Outbound' : 'Inbound'} Student
            </Text>
          </View>
        ),
      });
    }
  }, [navigation, student, studentType, themeColors]);

  if (!student) {
    return (
      <SafeAreaView
        style={[styles.container, { backgroundColor: themeColors.background }]}
        edges={['bottom']}>
        <View style={styles.errorContainer}>
          <Ionicons name="person-outline" size={64} color={themeColors.accent} />
          <Text style={[styles.errorTitle, { color: themeColors.text }]}>Student Not Found</Text>
          <Text style={[styles.errorMessage, { color: themeColors.textSecondary }]}>
            The student information could not be loaded. Please try again.
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <ScrollView
        style={[styles.scrollView, { backgroundColor: themeColors.background }]}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        {/* Hero Section */}
        <View style={styles.heroSection}>
          <View style={styles.imageContainer}>
            <NetworkImage
              imageUrl={student.imageUrl}
              name={student.name}
              size={120}
              expandable={true}
              showInitials={true}
            />
          </View>

          <Text style={[styles.studentName, { color: themeColors.text }]}>{student.name}</Text>
        </View>

        {/* Exchange Info Card */}
        <View
          style={[
            styles.exchangeCard,
            { backgroundColor: themeColors.card, borderColor: themeColors.border },
          ]}>
          <View style={styles.exchangeHeader}>
            <Ionicons name="airplane-outline" size={24} color={themeColors.accent} />
            <Text style={[styles.exchangeTitle, { color: themeColors.text }]}>
              Exchange Details
            </Text>
          </View>

          <View style={styles.exchangeRoute}>
            <View style={styles.exchangeCountry}>
              <View style={styles.exchangeCountryHeader}>
                {fromFlagAsset ? (
                  <Image source={fromFlagAsset} style={styles.exchangeFlag} contentFit="contain" />
                ) : (
                  <View
                    style={[
                      styles.exchangeFlag,
                      styles.flagPlaceholder,
                      { backgroundColor: themeColors.accent + '20' },
                    ]}>
                    <Text style={[styles.flagText, { color: themeColors.accent }]}>
                      {student.fromFlag.toUpperCase()}
                    </Text>
                  </View>
                )}
                <Text style={[styles.exchangeLabel, { color: themeColors.textSecondary }]}>
                  From
                </Text>
              </View>
              <Text style={[styles.exchangeCountryName, { color: themeColors.text }]}>
                {student.from}
              </Text>
            </View>

            <View style={styles.exchangeArrow}>
              <Ionicons name="arrow-forward" size={24} color={themeColors.accent} />
            </View>

            <View style={styles.exchangeCountry}>
              <View style={styles.exchangeCountryHeader}>
                {toFlagAsset ? (
                  <Image source={toFlagAsset} style={styles.exchangeFlag} contentFit="contain" />
                ) : (
                  <View
                    style={[
                      styles.exchangeFlag,
                      styles.flagPlaceholder,
                      { backgroundColor: themeColors.accent + '20' },
                    ]}>
                    <Text style={[styles.flagText, { color: themeColors.accent }]}>
                      {student.toFlag.toUpperCase()}
                    </Text>
                  </View>
                )}
                <Text style={[styles.exchangeLabel, { color: themeColors.textSecondary }]}>To</Text>
              </View>
              <Text style={[styles.exchangeCountryName, { color: themeColors.text }]}>
                {student.to}
              </Text>
            </View>
          </View>

          <View style={[styles.yearBadge, { backgroundColor: themeColors.primary + '20' }]}>
            <Text style={[styles.yearText, { color: themeColors.primary }]}>
              Current {studentType === 'outbound' ? 'Outbound' : 'Inbound'}
            </Text>
          </View>
        </View>

        {/* Bio Section */}
        {student.bio && student.bio.trim() !== '' && (
          <View
            style={[
              styles.bioCard,
              { backgroundColor: themeColors.card, borderColor: themeColors.border },
            ]}>
            <View style={styles.bioHeader}>
              <Ionicons name="document-text-outline" size={24} color={themeColors.accent} />
              <Text style={[styles.bioTitle, { color: themeColors.text }]}>
                About {student.name.split(' ')[0]}
              </Text>
            </View>
            <Text style={[styles.bioText, { color: themeColors.textSecondary }]}>
              {student.bio}
            </Text>
          </View>
        )}

        {/* Contact Actions - Only show if at least one contact method is available */}
        {(student.email ||
          student.phoneNumber ||
          student.instagramUrl ||
          student.snapchatUrl ||
          student.facebookUrl ||
          student.linkedinUrl ||
          student.websiteUrl) && (
          <View style={styles.actionsSection}>
            <Text style={[styles.sectionTitle, { color: themeColors.text }]}>Contact</Text>

            {student.email && (
              <ActionButton
                icon="mail-outline"
                title="Send Email"
                subtitle={student.email}
                onPress={() => handleContactPress('email')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.phoneNumber && (
              <ActionButton
                icon="call-outline"
                title="Call Phone"
                subtitle={student.phoneNumber}
                onPress={() => handleContactPress('phone')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.instagramUrl && (
              <ActionButton
                icon="logo-instagram"
                title="Instagram"
                subtitle="Follow on Instagram"
                onPress={() => handleContactPress('instagram')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.snapchatUrl && (
              <ActionButton
                icon="logo-snapchat"
                title="Snapchat"
                subtitle="Connect on Snapchat"
                onPress={() => handleContactPress('snapchat')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.facebookUrl && (
              <ActionButton
                icon="logo-facebook"
                title="Facebook"
                subtitle="View Facebook profile"
                onPress={() => handleContactPress('facebook')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.linkedinUrl && (
              <ActionButton
                icon="logo-linkedin"
                title="LinkedIn"
                subtitle="Connect on LinkedIn"
                onPress={() => handleContactPress('linkedin')}
                styles={styles}
                themeColors={themeColors}
              />
            )}

            {student.websiteUrl && (
              <ActionButton
                icon="globe-outline"
                title="Website"
                subtitle="Visit personal website"
                onPress={() => handleContactPress('website')}
                styles={styles}
                themeColors={themeColors}
              />
            )}
          </View>
        )}
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
  heroSection: {
    alignItems: 'center',
    paddingHorizontal: 24,
    paddingTop: Platform.OS === 'ios' ? 32 : 24,
    paddingBottom: 32,
    overflow: 'visible',
  },
  imageContainer: {
    width: 140,
    height: 140,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
    overflow: 'visible',
  },
  studentName: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '500',
    textAlign: 'center',
    marginBottom: 8,
    marginTop: 16,
  },
  exchangeCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    margin: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.12,
          shadowRadius: 24,
        }
      : {
          elevation: 3,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  exchangeHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  exchangeTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 12,
  },
  exchangeRoute: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  exchangeCountry: {
    flex: 1,
    alignItems: 'center',
  },
  exchangeCountryHeader: {
    alignItems: 'center',
    marginBottom: 8,
  },
  exchangeFlag: {
    width: 40,
    height: 27,
    marginBottom: 8,
  },
  exchangeLabel: {
    fontSize: 12,
    fontWeight: '500',
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
  exchangeCountryName: {
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
  },
  exchangeArrow: {
    marginHorizontal: 20,
  },
  yearBadge: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    alignSelf: 'center',
  },
  yearText: {
    fontSize: 14,
    fontWeight: '600',
  },
  bioCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 8,
    margin: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  bioHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  bioTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginLeft: 12,
  },
  bioText: {
    fontSize: 16,
    lineHeight: 24,
  },
  actionsSection: {
    paddingHorizontal: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: 32,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 18,
    fontWeight: Platform.OS === 'ios' ? '600' : '500',
    marginBottom: 16,
  },
  actionButton: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    marginBottom: 16,
    overflow: 'hidden',
    ...(Platform.OS === 'ios'
      ? {
          ...shadowStyle,
          shadowOpacity: 0.08,
          shadowRadius: 16,
        }
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  actionButtonDisabled: {
    opacity: 0.6,
  },
  actionButtonPressed: {},
  actionButtonContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: Platform.OS === 'ios' ? 60 : 64,
  },
  actionIconContainer: {
    width: Platform.OS === 'ios' ? 48 : 52,
    height: Platform.OS === 'ios' ? 48 : 52,
    borderRadius: Platform.OS === 'ios' ? 24 : 26,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
    ...(Platform.OS === 'ios' && shadowStyle),
  },
  actionIconDisabled: {},
  actionTextContainer: {
    flex: 1,
  },
  actionTitle: {
    fontSize: Platform.OS === 'ios' ? 16 : 16,
    fontWeight: Platform.OS === 'ios' ? '600' : '500',
    marginBottom: 2,
  },
  actionTitleDisabled: {},
  actionSubtitle: {
    fontSize: 14,
    fontWeight: '400',
  },
  actionSubtitleDisabled: {},
  flagPlaceholder: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  flagText: {
    fontSize: 10,
    fontWeight: '600',
  },

  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 32,
  },
  errorTitle: {
    fontSize: 24,
    fontWeight: '600',
    marginTop: 16,
    marginBottom: 8,
  },
  errorMessage: {
    fontSize: 16,
    textAlign: 'center',
    lineHeight: 22,
  },
});
