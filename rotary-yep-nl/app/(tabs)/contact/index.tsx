/**
 * Contact screen route
 * Thin wrapper using the contacts feature module
 */

import { useState } from "react";
import { Platform, StyleSheet, View, Text, SectionList } from "react-native";
import SegmentedControl from "@react-native-segmented-control/segmented-control";
import { useTheme } from "@/core/theme";
import { ContactCard, contactSections } from "@/features/contacts";

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);
  const { colors, isDark } = useTheme();

  const currentSection = contactSections[activeTab];
  const tabValues = contactSections.map((section) => section.title);
  const contacts = currentSection?.contacts || [];

  const handleSegmentChange = (event: any) => {
    setActiveTab(event.nativeEvent.selectedSegmentIndex);
  };

  if (contacts.length === 0) {
    return (
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        <View style={styles.segmentedControlContainer}>
          <SegmentedControl
            values={tabValues}
            selectedIndex={activeTab}
            onChange={handleSegmentChange}
            style={styles.segmentedControl}
            appearance={isDark ? "dark" : "light"}
            tintColor={colors.primary}
            fontStyle={{ color: colors.textSecondary }}
            activeFontStyle={{ color: colors.onPrimary }}
          />
        </View>
        <View style={styles.emptyState}>
          <Text style={[styles.emptyStateTitle, { color: colors.primary }]}>
            Geen contacten beschikbaar
          </Text>
          <Text
            style={[styles.emptyStateMessage, { color: colors.textSecondary }]}
          >
            Er zijn momenteel geen contacten in deze sectie.
          </Text>
        </View>
      </View>
    );
  }

  return (
    <View style={[styles.container, { backgroundColor: colors.background }]}>
      <View style={styles.segmentedControlContainer}>
        <SegmentedControl
          values={tabValues}
          selectedIndex={activeTab}
          onChange={handleSegmentChange}
          style={styles.segmentedControl}
          appearance={isDark ? "dark" : "light"}
          tintColor={colors.primary}
          fontStyle={{ color: colors.textSecondary }}
          activeFontStyle={{ color: colors.onPrimary }}
        />
      </View>

      <SectionList
        sections={[{ data: contacts }]}
        renderItem={({ item }) => <ContactCard contact={item} />}
        keyExtractor={(_item, index) => `${currentSection.id}-${index}`}
        showsVerticalScrollIndicator={false}
        ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
        contentContainerStyle={styles.contentContainer}
        style={styles.sectionList}
        automaticallyAdjustContentInsets={true}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  segmentedControlContainer: {
    paddingHorizontal: 16,
    paddingVertical: Platform.OS === "ios" ? 12 : 10,
    paddingTop: Platform.OS === "ios" ? 8 : 10,
  },
  segmentedControl: {
    height: Platform.OS === "ios" ? 32 : 40,
  },
  sectionList: {
    flex: 1,
  },
  contentContainer: {
    paddingTop: Platform.OS === "ios" ? 16 : 12,
    paddingBottom: Platform.OS === "android" ? 100 : 40,
    paddingHorizontal: Platform.OS === "ios" ? 16 : 0,
  },
  itemSeparator: {
    height: Platform.OS === "ios" ? 12 : 0,
  },
  emptyState: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyStateTitle: {
    fontSize: 20,
    fontWeight: "600",
    marginBottom: 8,
  },
  emptyStateMessage: {
    fontSize: 16,
    textAlign: "center",
    lineHeight: 22,
  },
});
