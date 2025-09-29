import { ScrollView, StyleSheet, TouchableOpacity, Alert, Linking, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { useState, useEffect } from 'react';
import { Ionicons } from '@expo/vector-icons';
import * as Application from 'expo-application';
import { StatusBar } from 'expo-status-bar';

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

  const handlePrivacyPolicy = () => {
    Linking.openURL('https://www.rotary.nl/yep/yep-app/privacy-policy.html');
  };

  const handleTermsAndConditions = () => {
    Linking.openURL('https://www.rotary.nl/yep/yep-app/terms-and-conditions.html');
  };

  const handleContributors = () => {
    Alert.alert('Contributors', 'Thanks to all who made this app possible!');
  };

  const SettingsSection = ({ title, children }: { title: string, children: React.ReactNode }) => (
    <ThemedView style={styles.section}>
      <ThemedText style={styles.sectionTitle}>{title}</ThemedText>
      <ThemedView style={styles.sectionContent}>
        {children}
      </ThemedView>
    </ThemedView>
  );

  const SettingsItem = ({ 
    title, 
    subtitle, 
    onPress, 
    rightElement 
  }: { 
    title: string, 
    subtitle?: string, 
    onPress?: () => void,
    rightElement?: React.ReactNode 
  }) => (
    <TouchableOpacity 
      style={styles.settingsItem} 
      onPress={onPress}
      disabled={!onPress}
    >
      <ThemedView style={styles.settingsItemContent}>
        <ThemedText style={styles.settingsItemTitle}>{title}</ThemedText>
        {subtitle && (
          <ThemedText style={styles.settingsItemSubtitle}>{subtitle}</ThemedText>
        )}
      </ThemedView>
      {rightElement || (onPress && (
        <Ionicons 
          name={Platform.OS === 'ios' ? 'chevron-forward' : 'chevron-forward-outline'} 
          size={16} 
          color="#999" 
        />
      ))}
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.safeContainer} edges={[]}>
      <StatusBar style="auto" />
      
      <ThemedView style={styles.container}>
        <ScrollView style={styles.scrollView} contentContainerStyle={styles.scrollContent}>
          <ThemedView style={styles.content}>
            <SettingsSection title="General">
              <SettingsItem
                title="Social Media"
                subtitle="Connect your social accounts"
                onPress={() => Alert.alert('Social', 'Social media integration coming soon!')}
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
                subtitle={buildVersion ? `${appVersion} (${buildVersion})` : appVersion}
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

            <ThemedView style={styles.footer}>
              <ThemedText style={styles.footerText}>
                Rotary Youth Exchange Netherlands
              </ThemedText>
              <ThemedText style={styles.footerText}>
                Made with ❤️ for young global citizens
              </ThemedText>
            </ThemedView>
          </ThemedView>
        </ScrollView>
      </ThemedView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeContainer: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: 30,
  },
  content: {
    padding: 16,
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
    paddingHorizontal: 4,
  },
  sectionContent: {
    backgroundColor: '#fff',
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 3,
  },
  settingsItem: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  settingsItemContent: {
    flex: 1,
  },
  settingsItemTitle: {
    fontSize: 16,
    fontWeight: '500',
    color: '#333',
    marginBottom: 2,
  },
  settingsItemSubtitle: {
    fontSize: 14,
    color: '#666',
  },
  footer: {
    alignItems: 'center',
    marginTop: 40,
    marginBottom: 20,
  },
  footerText: {
    fontSize: 14,
    color: '#999',
    textAlign: 'center',
    marginBottom: 4,
  },
});