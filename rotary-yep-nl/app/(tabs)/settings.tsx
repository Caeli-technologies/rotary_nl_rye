import { ScrollView, StyleSheet, TouchableOpacity, Alert, Linking, Switch, Platform, Share } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { useState, useEffect } from 'react';
import * as Sharing from 'expo-sharing';
import { Ionicons } from '@expo/vector-icons';
import * as Application from 'expo-application';

export default function SettingsScreen() {
  const [autoLoadVideos, setAutoLoadVideos] = useState(true);
  const [notifications, setNotifications] = useState(true);
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

  const handleShare = async () => {
    try {
      // Check if sharing is available
      const isAvailable = await Sharing.isAvailableAsync();
      
      if (isAvailable) {
        // Use React Native's built-in Share API for sharing text/links
        await Share.share({
          message: 'Check out the Rotary Youth Exchange Netherlands app! 📱✈️',
          title: 'Rotary Youth Exchange Netherlands',
          url: Platform.OS === 'ios' ? 'https://apps.apple.com/app/rotary-yep-nl' : undefined, // Add your app store URL when available
        });
      } else {
        // Fallback for platforms that don't support sharing
        Alert.alert(
          'Share App',
          'Share the Rotary Youth Exchange Netherlands app with friends!\n\nRotary Youth Exchange Netherlands - Connect with young global citizens worldwide! 📱✈️',
          [{ text: 'OK' }]
        );
      }
    } catch (error) {
      console.error('Error sharing:', error);
      Alert.alert('Share Error', 'Unable to share at this time. Please try again later.');
    }
  };

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
    <SafeAreaView style={styles.safeContainer} edges={['top']}>
      <ThemedView style={styles.header}>
        <ThemedText type="title" style={styles.title}>Settings</ThemedText>
        <TouchableOpacity style={styles.shareButton} onPress={handleShare}>
          <Ionicons 
            name={Platform.OS === 'ios' ? 'share-outline' : 'share-social-outline'} 
            size={20} 
            color="#fff" 
          />
        </TouchableOpacity>
      </ThemedView>
      
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
    backgroundColor: '#1f4e79',
  },
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    paddingBottom: Platform.OS === 'android' ? 100 : 34,
  },
  header: {
    paddingHorizontal: 20,
    paddingBottom: 20,
    backgroundColor: '#1f4e79',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  title: {
    color: '#fff',
    fontSize: 28,
    fontWeight: 'bold',
  },
  shareButton: {
    width: 40,
    height: 40,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
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