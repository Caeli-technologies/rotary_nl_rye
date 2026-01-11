/**
 * CloseButton component for iOS
 * Uses native iOS glass effect with SF Symbol
 */

import { Pressable, StyleSheet } from "react-native";
import { GlassView } from "expo-glass-effect";
import { Ionicons } from "@expo/vector-icons";
import * as Haptics from "expo-haptics";
import { CloseButtonProps } from "@/shared/components/ui/types";

export function CloseButton({ onPress }: CloseButtonProps) {
  const handlePress = async () => {
    await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    onPress();
  };

  return (
    <Pressable onPress={handlePress} style={styles.pressable}>
      <GlassView style={styles.glassButton} isInteractive>
        <Ionicons name="close" size={17} color="white" />
      </GlassView>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  pressable: {
    borderRadius: 15,
    overflow: "hidden",
  },
  glassButton: {
    width: 30,
    height: 30,
    borderRadius: 15,
    justifyContent: "center",
    alignItems: "center",
    overflow: "hidden",
  },
});
