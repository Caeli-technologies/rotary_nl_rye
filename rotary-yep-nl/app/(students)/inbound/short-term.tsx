/**
 * Inbound Short Term programs screen
 * Placeholder for short-term exchange programs (camps, family-to-family)
 */

import { StyleSheet, View, Text, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function InboundShortTermScreen() {
  const { colors } = useTheme();

  return (
    <SafeAreaView style={[styles.container, { backgroundColor: colors.background }]}>
      <View style={styles.content}>
        <View style={[styles.iconContainer, { backgroundColor: `${colors.primary}15` }]}>
          <Ionicons name="time-outline" size={48} color={colors.primary} />
        </View>
        <Text style={[styles.title, { color: colors.text }]}>Coming Soon</Text>
        <Text style={[styles.subtitle, { color: colors.textSecondary }]}>
          Short term inbound exchange programs are not yet available in the app.
          Check back soon for updates!
        </Text>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: spacing.xl,
  },
  iconContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: spacing.lg,
  },
  title: {
    fontSize: Platform.OS === "ios" ? 24 : 20,
    fontWeight: "700",
    marginBottom: spacing.sm,
    textAlign: "center",
  },
  subtitle: {
    fontSize: 16,
    lineHeight: 24,
    textAlign: "center",
  },
});
