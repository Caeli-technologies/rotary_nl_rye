/**
 * Unified Theme Hook for Rotary YEP App
 *
 * This hook provides a centralized way to access theme colors and utilities
 * following React Native and Expo best practices for dark/light mode support.
 *
 * @see https://docs.expo.dev/guides/color-schemes/
 */

import { useColorScheme } from 'react-native';
import { Colors } from '@/constants/theme';

export type ColorScheme = 'light' | 'dark';
export type ThemeColors = typeof Colors.light;

/**
 * Primary hook for accessing the current theme.
 * Automatically responds to device light/dark mode changes.
 *
 * @returns Object containing:
 *   - colors: All theme colors for current color scheme
 *   - colorScheme: Current color scheme ('light' or 'dark')
 *
 * @example
 * ```tsx
 * function MyComponent() {
 *   const { colors } = useTheme();
 *
 *   return (
 *     <View style={{ backgroundColor: colors.background }}>
 *       <Text style={{ color: colors.text }}>Hello World</Text>
 *     </View>
 *   );
 * }
 * ```
 */
export function useTheme() {
  const colorScheme = useColorScheme() ?? 'light';
  const colors = Colors[colorScheme];

  return {
    colors,
    colorScheme,
  };
}

/**
 * Get a specific theme color with optional overrides.
 * Useful when you need to override a color for a specific use case.
 *
 * @param props - Optional light and dark color overrides
 * @param colorName - The name of the color from the theme
 * @returns The color value for the current theme
 *
 * @example
 * ```tsx
 * function MyComponent() {
 *   const backgroundColor = useThemeColor(
 *     { light: '#fff', dark: '#000' },
 *     'background'
 *   );
 *
 *   return <View style={{ backgroundColor }} />;
 * }
 * ```
 */
export function useThemeColor(
  props: { light?: string; dark?: string } = {},
  colorName: keyof ThemeColors,
): string {
  const { colors, colorScheme } = useTheme();
  const colorFromProps = props[colorScheme];

  return colorFromProps ?? colors[colorName];
}
