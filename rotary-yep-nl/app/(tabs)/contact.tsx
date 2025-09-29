import { Platform, ScrollView, StyleSheet, TouchableOpacity, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ContactCard } from '@/components/enhanced-contact-card';
import { useState, useMemo } from 'react';
import { contactSections } from '@/data/contacts';
import { StatusBar } from 'expo-status-bar';

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);

  const currentSection = useMemo(() => contactSections[activeTab], [activeTab]);

  return (
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <StatusBar style="auto" />
      <View style={styles.header}>
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle}>Contact List</Text>
        </View>
      </View>

      <View style={styles.container}>
        <View style={styles.tabContainer}>
          {contactSections.map((section, index) => {
            const isActive = activeTab === index;
            return (
              <TouchableOpacity
                key={section.id}
                style={[styles.tab, isActive && styles.activeTab]}
                onPress={() => setActiveTab(index)}
              >
                <Text style={[styles.tabText, isActive && styles.activeTabText]}>
                  {section.title}
                </Text>
              </TouchableOpacity>
            );
          })}
        </View>

        <ScrollView style={styles.content} contentContainerStyle={styles.scrollContent}>
          {currentSection.contacts.map((contact, index) => (
            <ContactCard key={`${currentSection.id}-${index}`} contact={contact} index={index} />
          ))}
          
          {currentSection.contacts.length === 0 && (
            <View style={styles.emptyState}>
              <Text style={styles.emptyText}>No contacts available</Text>
            </View>
          )}
        </ScrollView>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  header: {
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'android' ? 16 : 8,
    paddingBottom: 16,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
  },
  headerTitleContainer: {
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 22,
    fontWeight: '600',
    color: '#000000',
    letterSpacing: Platform.OS === 'ios' ? -0.41 : 0,
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: Platform.select({ ios: '#FFFFFF', default: '#f5f5f5' }),
    paddingHorizontal: 16,
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.1,
        shadowRadius: 2,
      },
      default: {},
    }),
  },
  tab: {
    flex: 1,
    paddingVertical: 12,
    alignItems: 'center',
    borderBottomWidth: 2,
    borderBottomColor: 'transparent',
  },
  activeTab: {
    borderBottomColor: '#1f4e79',
  },
  tabText: {
    fontSize: Platform.select({ ios: 16, default: 14 }),
    fontWeight: Platform.select({ ios: '500', default: '600' }),
    color: '#666',
  },
  activeTabText: {
    color: '#1f4e79',
    fontWeight: Platform.select({ ios: '600', default: '700' }),
  },
  content: {
    flex: 1,
    padding: 16,
  },
  scrollContent: {
    paddingBottom: Platform.select({ android: 100, default: 34 }),
  },
  emptyState: {
    padding: 40,
    alignItems: 'center',
  },
  emptyText: {
    color: '#666',
    fontSize: 16,
  },
});