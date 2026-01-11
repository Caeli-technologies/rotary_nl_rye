/**
 * Students list component with country grouping
 */

import { useCallback } from "react";
import { SectionList, View, Text, StyleSheet, Platform } from "react-native";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import { StudentCard } from "./StudentCard";
import { EmptyState } from "@/shared/components/feedback/EmptyState";
import type { CountryGroup, Student } from "../types";

interface StudentsListProps {
  countryGroups: CountryGroup[];
  totalCount: number;
  onStudentPress: (student: Student) => void;
  ListHeaderComponent?: React.ComponentType | React.ReactElement | null;
}

interface SectionData {
  country: CountryGroup["country"];
  data: Student[];
}

export function StudentsList({
  countryGroups,
  totalCount,
  onStudentPress,
  ListHeaderComponent,
}: StudentsListProps) {
  const { colors } = useTheme();

  const sections: SectionData[] = countryGroups.map((group) => ({
    country: group.country,
    data: group.students,
  }));

  const renderItem = useCallback(
    ({ item }: { item: Student }) => (
      <StudentCard student={item} onPress={() => onStudentPress(item)} showExchangeInfo={false} />
    ),
    [onStudentPress],
  );

  const renderSectionHeader = useCallback(
    ({ section }: { section: SectionData }) => (
      <View
        style={[
          styles.sectionHeader,
          {
            backgroundColor: colors.background,
            borderBottomColor: colors.divider,
          },
        ]}
      >
        <Text style={[styles.sectionTitle, { color: colors.primary }]}>{section.country.name}</Text>
        <Text style={[styles.sectionCount, { color: colors.textSecondary }]}>
          {section.data.length} student{section.data.length !== 1 ? "s" : ""}
        </Text>
      </View>
    ),
    [colors],
  );

  const keyExtractor = useCallback((item: Student) => item.id, []);

  if (totalCount === 0) {
    return (
      <EmptyState
        icon="school-outline"
        title="No students found"
        message="There are no students to display."
      />
    );
  }

  return (
    <SectionList
      sections={sections}
      renderItem={renderItem}
      renderSectionHeader={renderSectionHeader}
      keyExtractor={keyExtractor}
      showsVerticalScrollIndicator={false}
      contentInsetAdjustmentBehavior="automatic"
      stickySectionHeadersEnabled={Platform.OS === "ios"}
      ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
      SectionSeparatorComponent={() => <View style={styles.sectionSeparator} />}
      contentContainerStyle={styles.contentContainer}
      ListHeaderComponent={ListHeaderComponent}
      removeClippedSubviews={true}
      initialNumToRender={15}
      maxToRenderPerBatch={10}
      windowSize={10}
    />
  );
}

const styles = StyleSheet.create({
  contentContainer: {
    paddingBottom: spacing.xl,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: spacing.md,
    paddingVertical: Platform.OS === "ios" ? spacing.sm : spacing.md,
    borderBottomWidth: Platform.OS === "ios" ? 0 : StyleSheet.hairlineWidth,
  },
  sectionTitle: {
    fontSize: Platform.OS === "ios" ? 22 : 18,
    fontWeight: Platform.OS === "ios" ? "700" : "500",
    letterSpacing: Platform.OS === "ios" ? 0.35 : 0,
  },
  sectionCount: {
    fontSize: 14,
    fontWeight: "400",
  },
  itemSeparator: {
    height: Platform.OS === "ios" ? spacing.sm : 0,
  },
  sectionSeparator: {
    height: Platform.OS === "ios" ? spacing.lg : spacing.md,
  },
});
