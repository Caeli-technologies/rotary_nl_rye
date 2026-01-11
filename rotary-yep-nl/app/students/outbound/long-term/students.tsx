import { useCallback } from "react";
import { StyleSheet, View, Text, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { router } from "expo-router";
import { Image } from "expo-image";

import { useTheme } from "@/core/theme";
import { StudentsList, useStudents, type Student } from "@/features/students";

export default function OutboundStudentsScreen() {
  const { colors } = useTheme();
  const { countryGroups, totalCount } = useStudents("outbound");

  const handleStudentPress = useCallback((student: Student) => {
    router.push({
      pathname: "/students/outbound/long-term/student-detail",
      params: { studentId: student.id },
    });
  }, []);

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
      edges={["bottom"]}
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
  headerContainer: {
    marginBottom: 16,
  },
  headerImage: {
    width: "100%",
    height: 180,
    borderRadius: 12,
    marginBottom: 16,
    marginHorizontal: 16,
    alignSelf: "center",
    maxWidth: Platform.OS === "ios" ? "92%" : "100%",
  },
  headerTextContainer: {
    paddingHorizontal: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === "ios" ? 28 : 24,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    marginBottom: 4,
  },
  headerSubtitle: {
    fontSize: 16,
    lineHeight: 22,
  },
});
