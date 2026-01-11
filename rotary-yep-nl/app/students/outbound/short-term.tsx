/**
 * Outbound Short Term programs screen
 * Shows Family to Family exchange info
 */

import { useCallback } from "react";
import { StyleSheet, View, Text, ScrollView, Pressable, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function OutboundShortTermScreen() {
  const { colors } = useTheme();

  const handleCampsPress = useCallback(async () => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push("/camps-tours");
    } catch {
      router.push("/camps-tours");
    }
  }, []);

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
      edges={["bottom"]}
    >
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Intro Section */}
        <View style={styles.introContainer}>
          <Text style={[styles.introTitle, { color: colors.primary }]}>Family to Family</Text>
          <Text style={[styles.introText, { color: colors.textSecondary }]}>
            The Family to Family exchange program allows families to host and send students for a
            short period. This is a great way to experience another culture without the commitment
            of a full year exchange.
          </Text>
        </View>

        {/* Camps Card */}
        <Pressable
          style={({ pressed }) => [
            styles.card,
            {
              backgroundColor: colors.card,
              borderColor: colors.border,
              shadowColor: colors.shadow,
            },
            pressed && styles.cardPressed,
          ]}
          onPress={handleCampsPress}
          android_ripple={{ color: `${colors.primary}20`, borderless: false }}
        >
          <View style={styles.cardContent}>
            <View style={[styles.iconContainer, { backgroundColor: `${colors.primary}15` }]}>
              <Ionicons name="earth" size={28} color={colors.primary} />
            </View>
            <View style={styles.cardTextContainer}>
              <Text style={[styles.cardTitle, { color: colors.text }]}>Zomerkampen & Tours</Text>
              <Text style={[styles.cardSubtitle, { color: colors.textSecondary }]}>
                View available camps and cultural programs
              </Text>
            </View>
            <Ionicons
              name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
              size={20}
              color={colors.textTertiary}
            />
          </View>
        </Pressable>

        {/* Info Card */}
        <View
          style={[
            styles.infoCard,
            {
              backgroundColor: `${colors.primary}10`,
              borderColor: colors.border,
            },
          ]}
        >
          <View style={styles.infoHeader}>
            <Ionicons name="information-circle" size={24} color={colors.primary} />
            <Text style={[styles.infoTitle, { color: colors.text }]}>How it works</Text>
          </View>
          <Text style={[styles.infoText, { color: colors.textSecondary }]}>
            Short term exchanges typically last 2-4 weeks. Families agree to host a student from
            another country while their own child travels to that country to stay with the exchange
            family.
          </Text>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: spacing.md,
    paddingBottom: spacing.xl,
  },
  introContainer: {
    marginBottom: spacing.lg,
  },
  introTitle: {
    fontSize: 24,
    fontWeight: "600",
    marginBottom: spacing.md,
  },
  introText: {
    fontSize: 15,
    lineHeight: 22,
  },
  card: {
    borderRadius: 12,
    marginBottom: spacing.md,
    ...shadowStyle,
    ...(Platform.OS === "android" && {
      borderWidth: StyleSheet.hairlineWidth,
    }),
  },
  cardPressed: {
    opacity: 0.8,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  cardContent: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    minHeight: 80,
  },
  iconContainer: {
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  cardTextContainer: {
    flex: 1,
    marginRight: spacing.sm,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 4,
  },
  cardSubtitle: {
    fontSize: 14,
    lineHeight: 20,
  },
  infoCard: {
    borderRadius: 12,
    padding: spacing.md,
    marginTop: spacing.md,
    borderWidth: StyleSheet.hairlineWidth,
  },
  infoHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  infoText: {
    fontSize: 15,
    lineHeight: 22,
  },
});
