/**
 * Inbound Long Term students list screen
 * Thin wrapper using students feature
 */

import { useCallback } from "react";
import { SafeAreaView, StyleSheet } from "react-native";
import { router } from "expo-router";
import { useTheme } from "@/core/theme";
import { StudentsList, useStudents, type Student } from "@/features/students";

export default function InboundLongTermScreen() {
  const { colors } = useTheme();
  const { countryGroups, totalCount } = useStudents("inbound");

  const handleStudentPress = useCallback((student: Student) => {
    router.push({
      pathname: "/inbound/student-detail",
      params: { studentId: student.id },
    });
  }, []);

  return (
    <SafeAreaView style={[styles.container, { backgroundColor: colors.background }]}>
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
