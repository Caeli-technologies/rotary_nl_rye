import { Platform } from 'react-native';

/**
 * Common shadow styles used throughout the app
 */
export const shadowStyles = {
  card: Platform.select({
    ios: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.08,
      shadowRadius: 20,
    },
    android: {
      elevation: 2,
    },
    default: {},
  }),
  elevated: Platform.select({
    ios: {
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.08,
      shadowRadius: 20,
    },
    android: {
      elevation: 3,
    },
    default: {},
  }),
  logo: Platform.select({
    ios: {
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.15,
      shadowRadius: 4,
    },
    android: {
      elevation: 4,
    },
    default: {},
  }),
};

/**
 * Common border radius values
 */
export const borderRadius = {
  small: Platform.OS === 'ios' ? 8 : 6,
  medium: Platform.OS === 'ios' ? 12 : 8,
  large: Platform.OS === 'ios' ? 16 : 12,
  extraLarge: Platform.OS === 'ios' ? 20 : 16,
};

/**
 * Common spacing values
 */
export const spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

/**
 * Common font weights
 */
export const fontWeights = {
  normal: '400' as const,
  medium: '500' as const,
  semibold: '600' as const,
  bold: '700' as const,
  heavy: '800' as const,
};
