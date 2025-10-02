import { Stack } from 'expo-router';
import { Platform } from 'react-native';

export default function ContactLayout() {
  return (
    <Stack>
      <Stack.Screen
        name="index"
        options={{
          title: 'Contact List',
          headerShown: true,
          headerStyle: {
            backgroundColor: '#FFFFFF',
          },
          headerTitleStyle: {
            color: '#000000',
            fontWeight: '600',
            fontSize: Platform.OS === 'ios' ? 20 : 22,
          },
          headerShadowVisible: Platform.OS === 'ios',
        }}
      />
    </Stack>
  );
}
