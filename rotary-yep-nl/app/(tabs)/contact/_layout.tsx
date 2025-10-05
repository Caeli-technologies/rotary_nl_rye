import { Stack } from 'expo-router';
import { Platform } from 'react-native';
import { useTheme } from '@react-navigation/native';

export default function ContactLayout() {
  const theme = useTheme();

  return (
    <Stack
      screenOptions={{
        headerStyle: {
          backgroundColor: theme.colors.card,
        },
        headerTitleStyle: {
          color: theme.colors.text,
          fontWeight: '600',
          fontSize: Platform.OS === 'ios' ? 20 : 22,
        },
        headerTintColor: theme.colors.primary,
        headerShadowVisible: Platform.OS === 'ios',
      }}>
      <Stack.Screen
        name="index"
        options={{
          title: 'Contact List',
        }}
      />
    </Stack>
  );
}
