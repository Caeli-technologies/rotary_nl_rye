import React, { useState, useMemo } from 'react';
import { Platform, StyleSheet, Pressable, View, Text, SectionList } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ContactCard } from '@/components/enhanced-contact-card';
import { contactSections } from '@/data/contacts';
import { StatusBar } from 'expo-status-bar';
import { Contact, Organization, Rotex } from '@/types/contact';

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);

  const currentSection = useMemo(() => contactSections[activeTab], [activeTab]);

  // Convert contacts to sections format for SectionList
  const sections = useMemo(() => {
    if (currentSection.contacts.length === 0) return [];
    
    return [{
      title: currentSection.title,
      count: currentSection.contacts.length,
      data: currentSection.contacts,
    }];
  }, [currentSection]);

  const renderContact = ({ item, index }: { item: Contact | Organization | Rotex; index: number }) => (
    <ContactCard contact={item} index={index} />
  );


  const renderEmptyComponent = () => (
    <View style={styles.emptyState}>
      <Text style={styles.emptyStateTitle}>No contacts available</Text>
      <Text style={styles.emptyStateMessage}>
        There are no contacts in this section at the moment.
      </Text>
    </View>
  );

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <StatusBar style="auto" />
      <View style={styles.container}>
        <View style={styles.tabContainer}>
          {contactSections.map((section, index) => {
            const isActive = activeTab === index;
            return (
              <Pressable
                key={section.id}
                style={({ pressed }) => [
                  styles.tab, 
                  isActive && styles.activeTab,
                  pressed && styles.tabPressed
                ]}
                onPress={() => setActiveTab(index)}
              >
                <Text style={[styles.tabText, isActive && styles.activeTabText]}>
                  {section.title}
                </Text>
              </Pressable>
            );
          })}
        </View>

        <SectionList
          sections={sections}
          renderItem={renderContact}
          ListEmptyComponent={renderEmptyComponent}
          keyExtractor={(item, index) => `${currentSection.id}-${index}`}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
          stickySectionHeadersEnabled={Platform.OS === 'ios'}
          ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
          contentContainerStyle={styles.contentContainer}
          removeClippedSubviews={true}
          initialNumToRender={10}
          maxToRenderPerBatch={5}
          windowSize={10}
          style={styles.sectionList}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  tabContainer: {
    flexDirection: 'row',
    backgroundColor: Platform.OS === 'ios' ? '#FFFFFF' : '#F5F5F5',
    paddingHorizontal: 0,
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
      elevation: 0,
    } : {
      elevation: 2,
      borderBottomWidth: StyleSheet.hairlineWidth,
      borderBottomColor: '#E0E0E0',
    }),
  },
  tab: {
    flex: 1,
    paddingVertical: Platform.OS === 'ios' ? 16 : 14,
    alignItems: 'center',
    borderBottomWidth: Platform.OS === 'ios' ? 3 : 2,
    borderBottomColor: 'transparent',
  },
  activeTab: {
    borderBottomColor: '#1f4e79',
  },
  tabPressed: {
    backgroundColor: Platform.OS === 'ios' ? 'rgba(26, 35, 126, 0.1)' : '#F0F0F0',
  },
  tabText: {
    fontSize: Platform.OS === 'ios' ? 16 : 14,
    fontWeight: Platform.OS === 'ios' ? '500' : '600',
    color: '#666',
  },
  activeTabText: {
    color: '#1f4e79',
    fontWeight: Platform.OS === 'ios' ? '600' : '700',
  },
  sectionList: {
    flex: 1,
  },
  contentContainer: {
    paddingTop: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: Platform.OS === 'android' ? 80 : 30,
    paddingHorizontal: Platform.OS === 'ios' ? 16 : 0,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: Platform.OS === 'ios' ? 0 : 16,
    paddingVertical: Platform.OS === 'ios' ? 8 : 12,
    backgroundColor: Platform.OS === 'ios' ? 'transparent' : '#F5F5F5',
    marginBottom: Platform.OS === 'ios' ? 8 : 0,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1f4e79',
    letterSpacing: Platform.OS === 'ios' ? 0.35 : 0,
  },
  sectionCount: {
    fontSize: 14,
    color: '#666',
    fontWeight: '400',
  },
  itemSeparator: {
    height: Platform.OS === 'ios' ? 12 : 0,
  },
  emptyState: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyStateTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#1f4e79',
    marginBottom: 8,
  },
  emptyStateMessage: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
  },
});