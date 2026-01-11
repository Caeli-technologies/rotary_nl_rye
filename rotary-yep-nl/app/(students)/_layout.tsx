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
        name="inbound/student-detail"
        options={{
          title: "Student",
          headerBackTitle: "Terug",
        }}
      />

      {/* Inbound Long Term */}
      <Stack.Screen
        name="inbound/long-term/index"
        options={{
          title: "Long Term",
          headerBackTitle: "Inbound",
        }}
      />
      <Stack.Screen
        name="inbound/long-term/welcome"
        options={{
          title: "Welcome",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="inbound/long-term/flight-arrival"
        options={{
          title: "Flight & Arrival",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="inbound/long-term/insurance"
        options={{
          title: "Insurance",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="inbound/long-term/language"
        options={{
          title: "Language",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="inbound/long-term/travel"
        options={{
          title: "Travel",
          headerBackTitle: "Long Term",
        }}
      />

      {/* Inbound Short Term */}
      <Stack.Screen
        name="inbound/short-term"
        options={{
          title: "Short Term",
          headerBackTitle: "Inbound",
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
        name="outbound/student-detail"
        options={{
          title: "Student",
          headerBackTitle: "Terug",
        }}
      />

      {/* Outbound Long Term */}
      <Stack.Screen
        name="outbound/long-term/index"
        options={{
          title: "Long Term",
          headerBackTitle: "Outbound",
        }}
      />
      <Stack.Screen
        name="outbound/long-term/how-to-sign-up"
        options={{
          title: "Aanmelden",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="outbound/long-term/requirements"
        options={{
          title: "Vereisten",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="outbound/long-term/selection-day"
        options={{
          title: "Selectie dag",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="outbound/long-term/selection-weekend"
        options={{
          title: "Selectie weekend",
          headerBackTitle: "Long Term",
        }}
      />
      <Stack.Screen
        name="outbound/long-term/top-countries"
        options={{
          title: "Top 3 landen",
          headerBackTitle: "Long Term",
        }}
      />

      {/* Outbound Short Term */}
      <Stack.Screen
        name="outbound/short-term/index"
        options={{
          title: "Short Term",
          headerBackTitle: "Outbound",
        }}
      />

      {/* Short Term - Camps */}
      <Stack.Screen
        name="outbound/short-term/camps/signup"
        options={{
          title: "Aanmelden",
          headerBackTitle: "Short Term",
        }}
      />
      <Stack.Screen
        name="outbound/short-term/camps/countries"
        options={{
          title: "Landen",
          headerBackTitle: "Short Term",
        }}
      />
      <Stack.Screen
        name="outbound/short-term/camps/requirements"
        options={{
          title: "Voor wie?",
          headerBackTitle: "Short Term",
        }}
      />

      {/* Short Term - Family to Family */}
      <Stack.Screen
        name="outbound/short-term/family-to-family/signup"
        options={{
          title: "Aanmelden",
          headerBackTitle: "Short Term",
        }}
      />
      <Stack.Screen
        name="outbound/short-term/family-to-family/countries"
        options={{
          title: "Landen",
          headerBackTitle: "Short Term",
        }}
      />
      <Stack.Screen
        name="outbound/short-term/family-to-family/requirements"
        options={{
          title: "Vereisten",
          headerBackTitle: "Short Term",
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
