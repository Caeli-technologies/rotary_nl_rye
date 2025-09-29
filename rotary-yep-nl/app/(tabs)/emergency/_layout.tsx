import { Stack } from 'expo-router';
import { Platform } from 'react-native';

export default function EmergencyLayout() {
  return (
    <Stack>
      <Stack.Screen 
        name="index" 
        options={{
          title: 'Emergency',
          headerShown: true,
          headerStyle: {
            backgroundColor: '#d32f2f',
          },
          headerTitleStyle: {
            color: '#FFFFFF',
            fontWeight: '600',
            fontSize: Platform.OS === 'ios' ? 20 : 22,
          },
          headerTintColor: '#FFFFFF',
          headerShadowVisible: Platform.OS === 'ios',
        }}
      />
    </Stack>
  );
}