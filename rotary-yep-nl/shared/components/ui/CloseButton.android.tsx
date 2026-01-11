/**
 * CloseButton component for Android
 * Uses Material Design styled button
 */

import { Pressable, StyleSheet } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { CloseButtonProps } from "@/shared/components/ui/types";

export function CloseButton({ onPress }: CloseButtonProps) {
  return (
    <Pressable
      onPress={onPress}
      style={styles.button}
      android_ripple={{ color: "rgba(255,255,255,0.3)", borderless: true, radius: 24 }}
    >
      <Ionicons name="close" size={24} color="white" />
    </Pressable>
  );
}

const styles = StyleSheet.create({
  button: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "center",
    alignItems: "center",
  },
});
