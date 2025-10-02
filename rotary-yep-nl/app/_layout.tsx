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
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.country || 'Students',
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
            })}
          />
          <Stack.Screen
            name="rebound/student-detail"
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.country || 'Student Detail',
              headerBackTitle: (route.params as any)?.country || 'Students',
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
          <Stack.Screen
            name="outbound/index"
            options={{
              headerShown: true,
              title: 'Outbound Programs',
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
            name="outbound/long-term/index"
            options={{
              headerShown: true,
              title: 'Long Term Exchange',
              headerBackTitle: 'Outbound',
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
            name="outbound/long-term/class-of/index"
            options={{
              headerShown: true,
              title: 'Huidige Studenten',
              headerBackTitle: 'Long Term',
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
            name="outbound/long-term/class-of/student-detail"
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.studentName || 'Student Detail',
              headerBackTitle: (route.params as any)?.country || 'Students',
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
            name="outbound/long-term/information/how-to-sign-up"
            options={{
              headerShown: true,
              title: 'Hoe meld ik me aan?',
              headerBackTitle: 'Long Term',
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
            name="outbound/long-term/information/selection-day"
            options={{
              headerShown: true,
              title: 'Selectie dag',
              headerBackTitle: 'Long Term',
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
            name="outbound/long-term/information/selection-weekend"
            options={{
              headerShown: true,
              title: 'Selectie weekend',
              headerBackTitle: 'Long Term',
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
            name="outbound/long-term/information/top-3-countries"
            options={{
              headerShown: true,
              title: 'Goede top 3 van landen',
              headerBackTitle: 'Long Term',
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
            name="outbound/long-term/information/comply-with"
            options={{
              headerShown: true,
              title: 'Waar moet ik aan voldoen?',
              headerBackTitle: 'Long Term',
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
            name="outbound/short-term/index"
            options={{
              headerShown: true,
              title: 'Short Term Programs',
              headerBackTitle: 'Outbound',
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
            name="outbound/short-term/camps-and-tours/index"
            options={{
              headerShown: true,
              title: 'Camps & Tours',
              headerBackTitle: 'Short Term',
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
            name="outbound/short-term/camps-and-tours/information/how-to-sign-up"
            options={{
              headerShown: true,
              title: 'Hoe schrijf ik mezelf in?',
              headerBackTitle: 'Camps & Tours',
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
            name="outbound/short-term/camps-and-tours/information/which-countries"
            options={{
              headerShown: true,
              title: 'Met welke landen?',
              headerBackTitle: 'Camps & Tours',
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
            name="outbound/short-term/camps-and-tours/information/comply-with"
            options={{
              headerShown: true,
              title: 'Voor wie?',
              headerBackTitle: 'Camps & Tours',
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
            name="outbound/short-term/family-to-family/index"
            options={{
              headerShown: true,
              title: 'Family to Family',
              headerBackTitle: 'Short Term',
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
            name="outbound/short-term/family-to-family/information/how-to-sign-up"
            options={{
              headerShown: true,
              title: 'Hoe meld ik me aan?',
              headerBackTitle: 'Family to Family',
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
            name="outbound/short-term/family-to-family/information/countries-preference"
            options={{
              headerShown: true,
              title: 'Landen & Voorkeur',
              headerBackTitle: 'Family to Family',
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
            name="outbound/short-term/family-to-family/information/comply-with"
            options={{
              headerShown: true,
              title: 'Voor wie?',
              headerBackTitle: 'Family to Family',
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
            name="inbound/index"
            options={{
              headerShown: true,
              title: 'Inbound Programs',
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
            name="inbound/long-term/index"
            options={{
              headerShown: true,
              title: 'Long Term Inbound',
              headerBackTitle: 'Inbound',
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
            name="inbound/long-term/class-of/index"
            options={{
              headerShown: true,
              title: 'Current Students',
              headerBackTitle: 'Long Term',
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
            name="inbound/long-term/class-of/student-detail"
            options={({ route }) => ({
              headerShown: true,
              title: (route.params as any)?.studentName || 'Student Detail',
              headerBackTitle: 'Students',
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
            name="inbound/long-term/information/welcome-in-the-netherlands"
            options={{
              headerShown: true,
              title: 'Welcome to the Netherlands!',
              headerBackTitle: 'Long Term',
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
            name="inbound/long-term/information/flight-and-arrival"
            options={{
              headerShown: true,
              title: 'Flight and Arrival',
              headerBackTitle: 'Long Term',
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
            name="inbound/long-term/information/language"
            options={{
              headerShown: true,
              title: 'Language',
              headerBackTitle: 'Long Term',
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
            name="inbound/long-term/information/insurance"
            options={{
              headerShown: true,
              title: 'Insurance',
              headerBackTitle: 'Long Term',
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
            name="inbound/long-term/information/travel"
            options={{
              headerShown: true,
              title: 'Travel',
              headerBackTitle: 'Long Term',
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
          {/* Programs */}
          <Stack.Screen
            name="programs/index"
            options={{
              headerShown: true,
              title: 'Programs',
              headerBackTitle: 'Home',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/promo/index"
            options={{
              headerShown: true,
              title: 'Promo Materiaal',
              headerBackTitle: 'Programs',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/promo/podcast"
            options={{
              headerShown: true,
              title: 'Promo Podcast',
              headerBackTitle: 'Promo',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/promo/video"
            options={{
              headerShown: true,
              title: 'Promo Video',
              headerBackTitle: 'Promo',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/information/long-term-exchange"
            options={{
              headerShown: true,
              title: 'Long Term Exchange',
              headerBackTitle: 'Programs',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/information/family-to-family"
            options={{
              headerShown: true,
              title: 'Family To Family',
              headerBackTitle: 'Programs',
              headerStyle: { backgroundColor: '#FFFFFF' },
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
            name="programs/information/camps-tours"
            options={{
              headerShown: true,
              title: 'Camps & Tours',
              headerBackTitle: 'Programs',
              headerStyle: { backgroundColor: '#FFFFFF' },
              headerTitleStyle: {
                color: '#1A237E',
                fontWeight: '600',
                fontSize: 20,
              },
              headerTintColor: '#007AFF',
              headerShadowVisible: true,
            }}
          />
        </Stack>
        <StatusBar style="auto" />
      </ThemeProvider>
    </SafeAreaProvider>
  );
}
