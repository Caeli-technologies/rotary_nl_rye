import { Stack } from 'expo-router';
import { Platform } from 'react-native';

export default function AboutLayout() {
  return (
    <Stack
      screenOptions={{
        headerStyle: {
          backgroundColor: '#FFFFFF',
        },
        headerTintColor: '#000000',
        contentStyle: {
          backgroundColor: '#F2F2F7',
        },
      }}
    >
      <Stack.Screen 
        name="index" 
        options={{
          title: 'About Us',
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
          headerTransparent: false,
        }}
      />
    </Stack>
  );
}