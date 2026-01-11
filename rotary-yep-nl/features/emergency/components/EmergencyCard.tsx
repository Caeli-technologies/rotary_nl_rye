/**
 * Emergency contact card component
 */

import { View, Text, Pressable, StyleSheet, Platform } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import { useHaptics } from "@/shared/hooks";
import { makePhoneCall, sendEmail } from "@/shared/utils/communications";
import type { EmergencyContact } from "../types";

interface EmergencyCardProps {
  contact: EmergencyContact;
}

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export function EmergencyCard({ contact }: EmergencyCardProps) {
  const { colors } = useTheme();
  const { mediumImpact } = useHaptics();

  const handleCall = () => {
    mediumImpact();
    makePhoneCall(contact.phone, contact.name);
  };

  const handleEmail = () => {
    if (contact.email) {
      mediumImpact();
      sendEmail(contact.email, contact.name);
    }
  };

  return (
    <View
      style={[
        styles.container,
        {
          backgroundColor: colors.card,
          shadowColor: colors.shadow,
          borderColor: colors.border,
        },
      ]}
    >
      <View style={styles.info}>
        <Text style={[styles.name, { color: colors.text }]}>{contact.name}</Text>
        <Text style={[styles.role, { color: colors.textSecondary }]}>{contact.role}</Text>
        <Text style={[styles.phone, { color: colors.accent }]}>{contact.phone}</Text>
      </View>

      <View style={styles.actions}>
        <Pressable
          style={({ pressed }) => [
            styles.actionButton,
            { backgroundColor: `${colors.primary}15` },
            pressed && styles.actionButtonPressed,
          ]}
          onPress={handleCall}
        >
          <Ionicons name="call" size={20} color={colors.primary} />
        </Pressable>

        {contact.email && (
          <Pressable
            style={({ pressed }) => [
              styles.actionButton,
              { backgroundColor: `${colors.primary}15` },
              pressed && styles.actionButtonPressed,
            ]}
            onPress={handleEmail}
          >
            <Ionicons name="mail" size={20} color={colors.primary} />
          </Pressable>
        )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    borderRadius: spacing.radiusMd,
    padding: spacing.md,
    marginBottom: spacing.sm,
    flexDirection: "row",
    alignItems: "center",
    ...(Platform.OS === "ios"
      ? shadowStyle
      : { elevation: 2, borderWidth: StyleSheet.hairlineWidth }),
  },
  info: {
    flex: 1,
  },
  name: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 4,
  },
  role: {
    fontSize: 14,
    marginBottom: 2,
  },
  phone: {
    fontSize: 14,
    fontWeight: "500",
  },
  actions: {
    flexDirection: "row",
    gap: spacing.sm,
  },
  actionButton: {
    width: Platform.OS === "ios" ? 44 : 48,
    height: Platform.OS === "ios" ? 44 : 48,
    borderRadius: Platform.OS === "ios" ? 22 : 24,
    justifyContent: "center",
    alignItems: "center",
  },
  actionButtonPressed: {
    opacity: 0.8,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
});
