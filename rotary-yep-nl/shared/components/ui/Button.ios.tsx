/**
 * Button component for iOS
 * Uses native iOS button styling
 */

import { ActivityIndicator, Pressable, StyleSheet, Text } from "react-native";
import { useTheme } from "@/core/theme";
import { useHaptics } from "@/shared/hooks";
import type { ButtonProps } from "./types";

export function Button({
  title,
  onPress,
  variant = "primary",
  disabled = false,
  loading = false,
  style,
}: ButtonProps) {
  const { colors } = useTheme();
  const { lightImpact } = useHaptics();

  const getButtonColors = () => {
    switch (variant) {
      case "primary":
        return {
          background: colors.primary,
          text: colors.onPrimary,
        };
      case "secondary":
        return {
          background: colors.surfaceVariant,
          text: colors.primary,
        };
      case "destructive":
        return {
          background: colors.error,
          text: colors.onPrimary,
        };
    }
  };

  const buttonColors = getButtonColors();

  const handlePress = () => {
    if (!disabled && !loading) {
      lightImpact();
      onPress();
    }
  };

  return (
    <Pressable
      onPress={handlePress}
      disabled={disabled || loading}
      style={({ pressed }) => [
        styles.button,
        {
          backgroundColor: buttonColors.background,
          opacity: disabled ? 0.5 : pressed ? 0.8 : 1,
        },
        style,
      ]}
    >
      {loading ? (
        <ActivityIndicator size="small" color={buttonColors.text} />
      ) : (
        <Text style={[styles.text, { color: buttonColors.text }]}>{title}</Text>
      )}
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    paddingVertical: 14,
    paddingHorizontal: 24,
    borderRadius: 10,
    alignItems: "center",
    justifyContent: "center",
    minHeight: 50,
  },
  text: {
    fontSize: 17,
    fontWeight: "600",
  },
});
