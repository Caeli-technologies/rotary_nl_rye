import { useState } from "react";
import { Platform, StyleSheet, View, Text, SectionList } from "react-native";
import SegmentedControl from "@react-native-segmented-control/segmented-control";
import { ContactCard } from "@/components/enhanced-contact-card";
import { contactSections } from "@/data/contacts";
import { useTheme } from "@/hooks/use-theme";

export default function ContactScreen() {
  const [activeTab, setActiveTab] = useState(0);
  const { colors: themeColors, colorScheme } = useTheme();

  // Map theme colors to component-specific colors
  const activeColors = {
    primary: themeColors.primary,
    background: themeColors.background,
    cardBackground: themeColors.card,
    text: themeColors.textSecondary,
    activeText: themeColors.onPrimary,
    segmentedBg: themeColors.surfaceVariant,
  };

  const currentSection = contactSections[activeTab];
  const tabValues = contactSections.map((section) => section.title);
  const contacts = currentSection?.contacts || [];

  const handleSegmentChange = (event: any) => {
    setActiveTab(event.nativeEvent.selectedSegmentIndex);
  };

  if (contacts.length === 0) {
    return (
      <View
        style={[styles.container, { backgroundColor: activeColors.background }]}
      >
        <View style={styles.segmentedControlContainer}>
          <SegmentedControl
            values={tabValues}
            selectedIndex={activeTab}
            onChange={handleSegmentChange}
            style={styles.segmentedControl}
            appearance={colorScheme === "dark" ? "dark" : "light"}
            tintColor={activeColors.primary}
            fontStyle={{
              color: activeColors.text,
            }}
            activeFontStyle={{
              color: activeColors.activeText,
            }}
          />
        </View>
        <View style={styles.emptyState}>
          <Text
            style={[styles.emptyStateTitle, { color: activeColors.primary }]}
          >
            No contacts available
          </Text>
          <Text
            style={[styles.emptyStateMessage, { color: activeColors.text }]}
          >
            There are no contacts in this section at the moment.
          </Text>
        </View>
      </View>
    );
  }

  return (
    <View
      style={[styles.container, { backgroundColor: activeColors.background }]}
    >
      <View style={styles.segmentedControlContainer}>
        <SegmentedControl
          values={tabValues}
          selectedIndex={activeTab}
          onChange={handleSegmentChange}
          style={styles.segmentedControl}
          appearance={colorScheme === "dark" ? "dark" : "light"}
          tintColor={activeColors.primary}
          fontStyle={{
            color: activeColors.text,
          }}
          activeFontStyle={{
            color: activeColors.activeText,
          }}
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
