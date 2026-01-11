/**
 * Students layout - handles inbound, outbound, and rebound navigation
 */

import { Stack } from "expo-router";
import { useTheme } from "@/core/theme";

export default function StudentsLayout() {
  const { colors, isDark } = useTheme();

  return (
    <Stack
      screenOptions={{
        headerStyle: { backgroundColor: colors.background },
        headerTintColor: colors.primary,
        headerShadowVisible: false,
        headerBackTitleVisible: false,
        contentStyle: { backgroundColor: colors.background },
      }}
    >
      <Stack.Screen
        name="inbound/index"
        options={{
          title: "Inbound",
          headerLargeTitle: true,
          headerLargeTitleStyle: { color: colors.text },
        }}
      />
      <Stack.Screen
        name="inbound/long-term"
        options={{ title: "Long Term" }}
      />
      <Stack.Screen
        name="inbound/short-term"
        options={{ title: "Short Term" }}
      />
      <Stack.Screen
        name="inbound/student-detail"
        options={{ title: "Student" }}
      />
      <Stack.Screen
        name="outbound/index"
        options={{
          title: "Outbound",
          headerLargeTitle: true,
          headerLargeTitleStyle: { color: colors.text },
        }}
      />
      <Stack.Screen
        name="outbound/long-term"
        options={{ title: "Long Term" }}
      />
      <Stack.Screen
        name="outbound/short-term"
        options={{ title: "Short Term" }}
      />
      <Stack.Screen
        name="outbound/student-detail"
        options={{ title: "Student" }}
      />
      <Stack.Screen
        name="rebound/index"
        options={{
          title: "Rebound",
          headerLargeTitle: true,
          headerLargeTitleStyle: { color: colors.text },
        }}
      />
      <Stack.Screen
        name="rebound/[country]"
        options={{ title: "Students" }}
      />
      <Stack.Screen
        name="rebound/student-detail"
        options={{ title: "Student" }}
      />
    </Stack>
  );
}
