/**
 * Students layout - handles inbound, outbound, and rebound navigation
 */

import { Stack } from "expo-router";
import { Platform } from "react-native";
import { useTheme } from "@/core/theme";

export default function StudentsLayout() {
	const { colors } = useTheme();

	return (
		<Stack
			screenOptions={{
				headerStyle: { backgroundColor: colors.background },
				headerTintColor: colors.primary,
				headerTitleStyle: {
					color: colors.text,
					fontWeight: "600",
				},
				headerShadowVisible: false,
				headerBackTitle: Platform.OS === "ios" ? "Terug" : undefined,
				contentStyle: { backgroundColor: colors.background },
			}}
		>
			{/* Inbound */}
			<Stack.Screen
				name="inbound/index"
				options={{
					title: "Inbound",
					headerBackTitle: "Home",
				}}
			/>
			<Stack.Screen
				name="inbound/long-term"
				options={{
					title: "Long Term",
					headerBackTitle: "Inbound",
				}}
			/>
			<Stack.Screen
				name="inbound/short-term"
				options={{
					title: "Short Term",
					headerBackTitle: "Inbound",
				}}
			/>
			<Stack.Screen
				name="inbound/student-detail"
				options={{
					title: "Student",
					headerBackTitle: "Terug",
				}}
			/>

			{/* Outbound */}
			<Stack.Screen
				name="outbound/index"
				options={{
					title: "Outbound",
					headerBackTitle: "Home",
				}}
			/>
			<Stack.Screen
				name="outbound/long-term"
				options={{
					title: "Long Term",
					headerBackTitle: "Outbound",
				}}
			/>
			<Stack.Screen
				name="outbound/short-term"
				options={{
					title: "Short Term",
					headerBackTitle: "Outbound",
				}}
			/>
			<Stack.Screen
				name="outbound/student-detail"
				options={{
					title: "Student",
					headerBackTitle: "Terug",
				}}
			/>

			{/* Rebound */}
			<Stack.Screen
				name="rebound/index"
				options={{
					title: "Rebound",
					headerBackTitle: "Home",
				}}
			/>
			<Stack.Screen
				name="rebound/[country]"
				options={({ route }) => ({
					title: (route.params as any)?.countryName || "Students",
					headerBackTitle: "Rebound",
				})}
			/>
			<Stack.Screen
				name="rebound/student-detail"
				options={{
					title: "Student",
					headerBackTitle: "Terug",
				}}
			/>
		</Stack>
	);
}
