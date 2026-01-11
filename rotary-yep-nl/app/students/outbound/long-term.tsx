/**
 * Outbound Long Term students list screen
 * Thin wrapper using students feature
 */

import { useCallback } from "react";
import { StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { router } from "expo-router";
import { useTheme } from "@/core/theme";
import { StudentsList, useStudents, type Student } from "@/features/students";

export default function OutboundLongTermScreen() {
  const { colors } = useTheme();
  const { countryGroups, totalCount } = useStudents("outbound");

  const handleStudentPress = useCallback((student: Student) => {
    router.push({
      pathname: "/students/outbound/student-detail" as const,
      params: { studentId: student.id },
    } as never);
  }, []);

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
    >
      <StudentsList
        countryGroups={countryGroups}
        totalCount={totalCount}
        onStudentPress={handleStudentPress}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
