import React, { useState, useEffect } from 'react';
import {
  ScrollView,
  StyleSheet,
  Pressable,
  Alert,
  Linking,
  Platform,
  View,
  Text,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import * as Application from 'expo-application';
import * as Haptics from 'expo-haptics';
import { StatusBar } from 'expo-status-bar';
import { router } from 'expo-router';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function SettingsScreen() {
  const [appVersion, setAppVersion] = useState<string>('Loading...');
  const [buildVersion, setBuildVersion] = useState<string>('');

  useEffect(() => {
    const getAppInfo = () => {
      const version = Application.nativeApplicationVersion || 'Unknown';
      const build = Application.nativeBuildVersion || '';

      setAppVersion(version);
      setBuildVersion(build);
    };

    getAppInfo();
  }, []);

  const handlePrivacyPolicy = async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    Linking.canOpenURL(
      'https://www.rotary.nl/yep/yep-app/privacy-policy.html',
    ).then((supported) => {
      if (supported) {
        Linking.openURL(
          'https://www.rotary.nl/yep/yep-app/privacy-policy.html',
        );
      } else {
        Alert.alert('Error', 'Unable to open privacy policy link');
      }
    });
  };

  const handleTermsAndConditions = async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    Linking.canOpenURL(
      'https://www.rotary.nl/yep/yep-app/terms-and-conditions.html',
    ).then((supported) => {
      if (supported) {
        Linking.openURL(
          'https://www.rotary.nl/yep/yep-app/terms-and-conditions.html',
        );
      } else {
        Alert.alert('Error', 'Unable to open terms and conditions link');
      }
    });
  };

  const handleContributors = async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    }
    router.push('/settings/contributors');
  };

  const handleSocialMedia = async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    Linking.canOpenURL('https://www.instagram.com/rotexnederland/').then(
      (supported) => {
        if (supported) {
          Linking.openURL('https://www.instagram.com/rotexnederland/');
        } else {
          Alert.alert('Error', 'Unable to open Instagram link');
        }
      },
    );
  };

  const SettingsSection = ({
    title,
    children,
  }: {
    title: string;
    children: React.ReactNode;
  }) => (
    <View style={styles.section}>
      <Text style={styles.sectionTitle}>{title}</Text>
      <View style={styles.sectionContent}>{children}</View>
    </View>
  );

  const SettingsItem = ({
    title,
    subtitle,
    onPress,
    rightElement,
  }: {
    title: string;
    subtitle?: string;
    onPress?: () => void;
    rightElement?: React.ReactNode;
  }) => (
    <Pressable
      style={({ pressed }) => [
        styles.settingsItem,
        pressed && styles.settingsItemPressed,
      ]}
      onPress={onPress}
      disabled={!onPress}
    >
      <View style={styles.settingsItemContent}>
        <Text style={styles.settingsItemTitle}>{title}</Text>
        {subtitle && (
          <Text style={styles.settingsItemSubtitle}>{subtitle}</Text>
        )}
      </View>
      {rightElement ||
        (onPress && (
          <Ionicons
            name={
              Platform.OS === 'ios'
                ? 'chevron-forward'
                : 'chevron-forward-outline'
            }
            size={Platform.OS === 'ios' ? 20 : 24}
            color={Platform.OS === 'ios' ? '#C7C7CC' : '#9FA8DA'}
          />
        ))}
    </Pressable>
  );

  return (
    <SafeAreaView style={styles.safeContainer} edges={['bottom']}>
      

      <ScrollView
        style={styles.container}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          <SettingsSection title="General">
            <SettingsItem
              title="Follow us on Instagram"
              subtitle="@rotexnederland"
              onPress={handleSocialMedia}
            />
          </SettingsSection>

          <SettingsSection title="Development">
            <SettingsItem
              title="Contributors"
              subtitle="View app contributors"
              onPress={handleContributors}
            />
            <SettingsItem
              title="App Version"
              subtitle={
                buildVersion ? `${appVersion} (${buildVersion})` : appVersion
              }
            />
          </SettingsSection>

          <SettingsSection title="Legal">
            <SettingsItem
              title="Privacy Policy"
              onPress={handlePrivacyPolicy}
            />
            <SettingsItem
              title="Terms & Conditions"
              onPress={handleTermsAndConditions}
            />
          </SettingsSection>

          <View style={styles.footer}>
            <Text style={styles.footerText}>
              Rotary Youth Exchange Netherlands
            </Text>
            <Text style={styles.footerText}>
              Made with ❤️ for young global citizens
            </Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeContainer: {
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
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginBottom: 12,
    paddingHorizontal: 4,
    letterSpacing: Platform.OS === 'ios' ? 0.35 : 0,
  },
  sectionContent: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    overflow: 'hidden',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  settingsItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: Platform.OS === 'ios' ? 16 : 14,
    paddingHorizontal: 16,
    minHeight: Platform.OS === 'ios' ? 60 : 64,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: Platform.OS === 'ios' ? '#E5E5E5' : '#F0F0F0',
  },
  settingsItemPressed: {
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#F5F5F5',
    opacity: 0.8,
  },
  settingsItemContent: {
    flex: 1,
  },
  settingsItemTitle: {
    fontSize: 16,
    fontWeight: Platform.OS === 'ios' ? '600' : '500',
    color: '#1A237E',
    marginBottom: 2,
  },
  settingsItemSubtitle: {
    fontSize: 14,
    color: '#666',
    lineHeight: 18,
  },
  footer: {
    alignItems: 'center',
    marginTop: 40,
    marginBottom: 20,
    paddingHorizontal: 20,
  },
  footerText: {
    fontSize: 14,
    color: '#9FA8DA',
    textAlign: 'center',
    marginBottom: 6,
    lineHeight: 20,
  },
});
