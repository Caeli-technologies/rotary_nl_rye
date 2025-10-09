import { useMemo } from "react";
import { View, Text, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { useLocalSearchParams } from "expo-router";

import { StudentDetail } from "@/components/students/StudentDetail";
import { currentOutboundStudents } from "@/data/outbound-students";
import { useTheme } from "@/hooks/use-theme";
export default function StudentDetailScreen() {
	const { colors: themeColors } = useTheme();

	const params = useLocalSearchParams();

	const student = useMemo(() => {
		if (!params.studentName) return null;
		return currentOutboundStudents.find((s) => s.name === params.studentName);
	}, [params.studentName]);

	if (!student) {
		return (
			<SafeAreaView
				style={[styles.container, { backgroundColor: themeColors.background }]}
			>
				<View style={styles.centered}>
					<Text style={[styles.errorText, { color: themeColors.text }]}>
						Student niet gevonden
					</Text>
				</View>
			</SafeAreaView>
		);
	}

	return <StudentDetail student={student} studentType="outbound" />;
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
	},
	centered: {
		flex: 1,
		justifyContent: "center",
		alignItems: "center",
	},
	errorText: {
		fontSize: 18,
		textAlign: "center",
	},
});
