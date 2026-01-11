/**
 * Button component for Android
 * Uses Material Design button styling
 */

import { ActivityIndicator, Pressable, StyleSheet, Text } from 'react-native';
import { useTheme } from '@/core/theme';
import type { ButtonProps } from './types';

export function Button({
  title,
  onPress,
  variant = 'primary',
  disabled = false,
  loading = false,
  style,
}: ButtonProps) {
  const { colors } = useTheme();

  const getButtonColors = () => {
    switch (variant) {
      case 'primary':
        return {
          background: colors.primary,
          text: colors.onPrimary,
        };
      case 'secondary':
        return {
          background: colors.surfaceVariant,
          text: colors.primary,
        };
      case 'destructive':
        return {
          background: colors.error,
          text: colors.onPrimary,
        };
    }
  };

  const buttonColors = getButtonColors();

  return (
    <Pressable
      onPress={onPress}
      disabled={disabled || loading}
      android_ripple={{ color: buttonColors.text + '30' }}
      style={({ pressed }) => [
        styles.button,
        {
          backgroundColor: buttonColors.background,
          opacity: disabled ? 0.5 : 1,
          elevation: pressed ? 1 : 2,
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
    paddingVertical: 12,
    paddingHorizontal: 24,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
    minHeight: 48,
  },
  text: {
    fontSize: 16,
    fontWeight: '600',
    letterSpacing: 0.5,
    textTransform: 'uppercase',
  },
});
