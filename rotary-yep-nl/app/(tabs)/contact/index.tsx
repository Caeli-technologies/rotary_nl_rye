import React, { useState } from 'react';
import { Platform, StyleSheet, View, Text, SectionList } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import SegmentedControl from '@react-native-segmented-control/segmented-control';
import { ContactCard } from '@/components/enhanced-contact-card';
import { contactSections } from '@/data/contacts';

// Constants
const COLORS = {
  primary: '#1f4e79',
  text: '#666',
  background: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  cardBackground: Platform.OS === 'ios' ? '#FFFFFF' : '#F5F5F5',
  white: '#FFFFFF',
};

const SEGMENTED_CONTROL_CONFIG = {
  tintColor: COLORS.primary,
  backgroundColor: COLORS.cardBackground,
  fontStyle: {
    color: COLORS.text,
    fontSize: Platform.OS === 'ios' ? 16 : 14,
    fontWeight: Platform.OS === 'ios' ? ('500' as const) : ('600' as const),
  },
  activeFontStyle: {
    color: COLORS.white,
    fontWeight: Platform.OS === 'ios' ? ('600' as const) : ('700' as const),
  },
};

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);

  const currentSection = contactSections[activeTab];
  const tabValues = contactSections.map((section) => section.title);
  const contacts = currentSection?.contacts || [];

  const handleSegmentChange = (event: any) => {
    setActiveTab(event.nativeEvent.selectedSegmentIndex);
  };

  if (contacts.length === 0) {
    return (
      <SafeAreaView style={styles.safeArea} edges={['bottom']}>
        <View style={styles.container}>
          <View style={styles.segmentedControlContainer}>
            <SegmentedControl
              values={tabValues}
              selectedIndex={activeTab}
              onChange={handleSegmentChange}
              style={styles.segmentedControl}
              {...SEGMENTED_CONTROL_CONFIG}
            />
          </View>
          <View style={styles.emptyState}>
            <Text style={styles.emptyStateTitle}>No contacts available</Text>
            <Text style={styles.emptyStateMessage}>
              There are no contacts in this section at the moment.
            </Text>
          </View>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <View style={styles.container}>
        <View style={styles.segmentedControlContainer}>
          <SegmentedControl
            values={tabValues}
            selectedIndex={activeTab}
            onChange={handleSegmentChange}
            style={styles.segmentedControl}
            {...SEGMENTED_CONTROL_CONFIG}
          />
        </View>

        <SectionList
          sections={[{ data: contacts }]}
          renderItem={({ item, index }) => <ContactCard contact={item} index={index} />}
          keyExtractor={(item, index) => `${currentSection.id}-${index}`}
          showsVerticalScrollIndicator={false}
          ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
          contentContainerStyle={styles.contentContainer}
          style={styles.sectionList}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  container: {
    flex: 1,
    backgroundColor: COLORS.background,
  },
  segmentedControlContainer: {
    backgroundColor: COLORS.cardBackground,
    paddingHorizontal: 16,
    paddingVertical: Platform.OS === 'ios' ? 12 : 10,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 2,
          borderBottomWidth: StyleSheet.hairlineWidth,
          borderBottomColor: '#E0E0E0',
        }),
  },
  segmentedControl: {
    height: Platform.OS === 'ios' ? 28 : 40,
  },
  sectionList: {
    flex: 1,
  },
  contentContainer: {
    paddingTop: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: Platform.OS === 'android' ? 80 : 30,
    paddingHorizontal: Platform.OS === 'ios' ? 16 : 0,
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
    color: COLORS.primary,
    marginBottom: 8,
  },
  emptyStateMessage: {
    fontSize: 16,
    color: COLORS.text,
    textAlign: 'center',
    lineHeight: 22,
  },
});
