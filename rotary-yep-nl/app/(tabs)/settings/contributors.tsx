import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';
import { NetworkImage } from '@/components/network-image';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface Contributor {
  id: string;
  name: string;
  role: string;
  location: string;
  imageUrl?: string;
}

const contributors: Contributor[] = [
  {
    id: '1',
    name: 'Ruben Talstra',
    role: 'Lead Developer',
    location: 'Netherlands',
    imageUrl: undefined,
  },
  {
    id: '2',
    name: '_Bnkn_',
    role: 'Developer',
    location: 'Germany',
    imageUrl: undefined,
  },
  {
    id: '3',
    name: 'Believer',
    role: 'Developer',
    location: 'India',
    imageUrl: undefined,
  },
  {
    id: '4',
    name: 'Frosted Fox',
    role: 'UI Developer',
    location: 'Netherlands',
    imageUrl: undefined,
  },
];

export default function ContributorsScreen() {
  const ContributorCard = ({ contributor }: { contributor: Contributor }) => (
    <View style={styles.contributorCard}>
      <NetworkImage
        imageUrl={contributor.imageUrl}
        name={contributor.name}
        size={60}
        expandable={false}
      />
      <View style={styles.contributorInfo}>
        <Text style={styles.contributorName}>{contributor.name}</Text>
        <Text style={styles.contributorRole}>{contributor.role}</Text>
        <View style={styles.locationContainer}>
          <Ionicons name="location-outline" size={14} color="#666" />
          <Text style={styles.contributorLocation}>{contributor.location}</Text>
        </View>
      </View>
    </View>
  );

  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      

      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="people-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.pageTitle}>Contributors</Text>
            <Text style={styles.pageSubtitle}>
              Thanks to everyone who made this app possible!
            </Text>
          </View>

          {/* Contributors List */}
          <View style={styles.section}>
            <Text style={styles.sectionTitle}>Development Team</Text>
            <View style={styles.contributorsContainer}>
              {contributors.map((contributor) => (
                <ContributorCard
                  key={contributor.id}
                  contributor={contributor}
                />
              ))}
            </View>
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
    backgroundColor: '#FFF3F0',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  pageTitle: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  pageSubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
    paddingHorizontal: 20,
  },

  // Section
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
  },

  // Contributors
  contributorsContainer: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    overflow: 'hidden',
    ...shadowStyle,
  },
  contributorCard: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#E0E0E0',
  },
  contributorInfo: {
    flex: 1,
    marginLeft: 16,
  },
  contributorName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  contributorRole: {
    fontSize: 14,
    color: '#666',
    marginBottom: 4,
  },
  locationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  contributorLocation: {
    fontSize: 12,
    color: '#666',
    marginLeft: 4,
  },
});
