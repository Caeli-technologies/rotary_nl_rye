import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import 'react-native-reanimated';

import { useColorScheme } from '@/hooks/use-color-scheme';

export const unstable_settings = {
  anchor: '(tabs)',
};

export default function RootLayout() {
  const colorScheme = useColorScheme();

  return (
    <SafeAreaProvider>
      <ThemeProvider value={colorScheme === 'dark' ? DarkTheme : DefaultTheme}>
        <Stack>
          <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
          <Stack.Screen 
            name="rebound/countries" 
            options={{ 
              headerShown: true,
              title: 'Rebound Students',
              headerBackTitle: 'Home',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rebound/students" 
            options={{ 
              headerShown: true,
              title: 'Students',
              headerBackTitle: 'Countries',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rebound/student-detail" 
            options={{ 
              headerShown: true,
              title: 'Student Detail',
              headerBackTitle: 'Students',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="news" 
            options={{ 
              headerShown: true,
              title: 'News',
              headerBackTitle: 'Home',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="calendar" 
            options={{ 
              headerShown: true,
              title: 'Calendar',
              headerBackTitle: 'Home',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="camps-tours" 
            options={{ 
              headerShown: true,
              title: 'Camps & Tours',
              headerBackTitle: 'Home',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs" 
            options={{ 
              headerShown: true,
              title: 'For Rotary Clubs',
              headerBackTitle: 'Home',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs/algemene-informatie" 
            options={{ 
              headerShown: true,
              title: 'Algemene Informatie',
              headerBackTitle: 'Rotary Clubs',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs/jeugdcommissaris" 
            options={{ 
              headerShown: true,
              title: 'Info Jeugdcommissaris',
              headerBackTitle: 'Rotary Clubs',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs/gastgezin" 
            options={{ 
              headerShown: true,
              title: 'Info Gastgezin',
              headerBackTitle: 'Rotary Clubs',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs/counselor" 
            options={{ 
              headerShown: true,
              title: 'Info Counselor',
              headerBackTitle: 'Rotary Clubs',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="rotary-clubs/documenten" 
            options={{ 
              headerShown: true,
              title: 'Belangrijke Documenten',
              headerBackTitle: 'Rotary Clubs',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }} 
          />
          <Stack.Screen 
            name="pdf-viewer" 
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.title || 'PDF Document',
              headerBackTitle: 'Back',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 18,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            })} 
          />
          <Stack.Screen 
            name="news/[id]" 
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.title || 'News Detail',
              headerBackTitle: 'News',
              headerStyle: {
                backgroundColor: '#FFFFFF',
              },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            })} 
          />
        </Stack>
        <StatusBar style="auto" />
      </ThemeProvider>
    </SafeAreaProvider>
  );
}
