import React from 'react';
import {
  View,
  Text,
  Pressable,
  StyleSheet,
  Platform,
  useColorScheme,
  ViewStyle,
  TextStyle,
} from 'react-native';
import * as Haptics from 'expo-haptics';

interface UIColors {
  background: string;
  surface: string;
  primary: string;
  primaryVariant: string;
  secondary: string;
  onBackground: string;
  onSurface: string;
  onPrimary: string;
  border: string;
  shadow: string;
}

export function useUIColors(): UIColors {
  const colorScheme = useColorScheme();

  return {
    light: {
      background: '#F2F2F7',
      surface: '#FFFFFF',
      primary: '#1A237E',
      primaryVariant: '#9FA8DA',
      secondary: '#3F51B5',
      onBackground: '#000000',
      onSurface: '#000000',
      onPrimary: '#FFFFFF',
      border: '#E5E5EA',
      shadow: '#000000',
    },
    dark: {
      background: '#000000',
      surface: '#1C1C1E',
      primary: '#9FA8DA',
      primaryVariant: '#1A237E',
      secondary: '#7986CB',
      onBackground: '#FFFFFF',
      onSurface: '#FFFFFF',
      onPrimary: '#000000',
      border: '#38383A',
      shadow: '#000000',
    },
  }[colorScheme ?? 'light'];
}

interface NativeButtonProps {
  title: string;
  onPress?: () => void;
  variant?: 'primary' | 'secondary' | 'surface';
  size?: 'small' | 'medium' | 'large';
  disabled?: boolean;
  style?: ViewStyle;
  textStyle?: TextStyle;
  haptics?: boolean;
}

export function NativeButton({
  title,
  onPress,
  variant = 'primary',
  size = 'medium',
  disabled = false,
  style,
  textStyle,
  haptics = true,
}: NativeButtonProps) {
  const colors = useUIColors();

  const handlePress = () => {
    if (haptics && Platform.OS === 'ios') {
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    onPress?.();
  };

  const getButtonStyles = (): ViewStyle => {
    const baseStyle: ViewStyle = {
      borderRadius: Platform.OS === 'ios' ? 12 : 8,
      alignItems: 'center',
      justifyContent: 'center',
      ...Platform.select({
        ios: {
          shadowColor: colors.shadow,
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        },
        android: {
          elevation: 2,
        },
      }),
    };

    const sizeStyles = {
      small: { paddingHorizontal: 16, paddingVertical: 8 },
      medium: { paddingHorizontal: 20, paddingVertical: 12 },
      large: { paddingHorizontal: 24, paddingVertical: 16 },
    }[size];

    const variantStyles = {
      primary: { backgroundColor: colors.primary },
      secondary: { backgroundColor: colors.secondary },
      surface: {
        backgroundColor: colors.surface,
        borderWidth: 1,
        borderColor: colors.border,
      },
    }[variant];

    return {
      ...baseStyle,
      ...sizeStyles,
      ...variantStyles,
      opacity: disabled ? 0.6 : 1,
    };
  };

  const getTextStyles = (): TextStyle => {
    const baseStyle: TextStyle = {
      fontWeight: '600',
      textAlign: 'center',
    };

    const sizeStyles = {
      small: { fontSize: 14 },
      medium: { fontSize: 16 },
      large: { fontSize: 18 },
    }[size];

    const variantStyles = {
      primary: { color: colors.onPrimary },
      secondary: { color: colors.onPrimary },
      surface: { color: colors.onSurface },
    }[variant];

    return {
      ...baseStyle,
      ...sizeStyles,
      ...variantStyles,
    };
  };

  return (
    <Pressable
      style={({ pressed }) => [
        getButtonStyles(),
        style,
        pressed && { opacity: 0.8, transform: [{ scale: 0.98 }] },
      ]}
      onPress={handlePress}
      disabled={disabled}
      android_ripple={{
        color: 'rgba(255, 255, 255, 0.2)',
      }}>
      <Text style={[getTextStyles(), textStyle]}>{title}</Text>
    </Pressable>
  );
}

interface NativeCardProps {
  children: React.ReactNode;
  onPress?: () => void;
  style?: ViewStyle;
  haptics?: boolean;
}

export function NativeCard({ children, onPress, style, haptics = true }: NativeCardProps) {
  const colors = useUIColors();

  const handlePress = () => {
    if (haptics && Platform.OS === 'ios') {
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    onPress?.();
  };

  const cardStyles: ViewStyle = {
    backgroundColor: colors.surface,
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    ...Platform.select({
      ios: {
        shadowColor: colors.shadow,
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.08,
        shadowRadius: 8,
      },
      android: {
        elevation: 2,
      },
    }),
  };

  if (onPress) {
    return (
      <Pressable
        style={({ pressed }) => [
          cardStyles,
          style,
          pressed && { opacity: 0.8, transform: [{ scale: 0.98 }] },
        ]}
        onPress={handlePress}
        android_ripple={{
          color: 'rgba(0, 0, 0, 0.05)',
        }}>
        {children}
      </Pressable>
    );
  }

  return <View style={[cardStyles, style]}>{children}</View>;
}

interface NativeHeaderProps {
  title: string;
  subtitle?: string;
  style?: ViewStyle;
}

export function NativeHeader({ title, subtitle, style }: NativeHeaderProps) {
  const colors = useUIColors();

  return (
    <View style={[styles.headerContainer, style]}>
      <Text style={[styles.headerTitle, { color: colors.onBackground }]}>{title}</Text>
      {subtitle && (
        <Text style={[styles.headerSubtitle, { color: colors.onBackground }]}>{subtitle}</Text>
      )}
    </View>
  );
}

interface NativeListItemProps {
  title: string;
  subtitle?: string;
  onPress?: () => void;
  rightElement?: React.ReactNode;
  leftElement?: React.ReactNode;
  style?: ViewStyle;
}

export function NativeListItem({
  title,
  subtitle,
  onPress,
  rightElement,
  leftElement,
  style,
}: NativeListItemProps) {
  const colors = useUIColors();

  const handlePress = () => {
    if (Platform.OS === 'ios') {
      Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    onPress?.();
  };

  return (
    <Pressable
      style={({ pressed }) => [
        styles.listItem,
        { backgroundColor: colors.surface, borderBottomColor: colors.border },
        style,
        pressed && { backgroundColor: colors.border },
      ]}
      onPress={handlePress}
      android_ripple={{
        color: 'rgba(0, 0, 0, 0.05)',
      }}>
      {leftElement && <View style={styles.leftElement}>{leftElement}</View>}

      <View style={styles.listItemContent}>
        <Text style={[styles.listItemTitle, { color: colors.onSurface }]}>{title}</Text>
        {subtitle && (
          <Text style={[styles.listItemSubtitle, { color: colors.onSurface }]}>{subtitle}</Text>
        )}
      </View>

      {rightElement && <View style={styles.rightElement}>{rightElement}</View>}
    </Pressable>
  );
}

const styles = StyleSheet.create({
  headerContainer: {
    paddingVertical: 16,
    paddingHorizontal: 20,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 34 : 28,
    fontWeight: 'bold',
    lineHeight: Platform.OS === 'ios' ? 41 : 34,
  },
  headerSubtitle: {
    fontSize: 17,
    fontWeight: '400',
    marginTop: 4,
    opacity: 0.7,
  },
  listItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
    minHeight: 44,
  },
  listItemContent: {
    flex: 1,
    marginHorizontal: 12,
  },
  listItemTitle: {
    fontSize: 17,
    fontWeight: '400',
    lineHeight: 22,
  },
  listItemSubtitle: {
    fontSize: 15,
    fontWeight: '400',
    marginTop: 2,
    opacity: 0.6,
  },
  leftElement: {
    marginRight: 8,
  },
  rightElement: {
    marginLeft: 8,
  },
});
