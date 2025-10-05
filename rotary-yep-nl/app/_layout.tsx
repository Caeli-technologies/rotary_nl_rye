import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { Platform } from 'react-native';
import { useTheme } from '@/hooks/use-theme';
import 'react-native-reanimated';

export const unstable_settings = {
  initialRouteName: '(tabs)',
};

export default function RootLayout() {
  const { colors: themeColors, colorScheme } = useTheme();

  // Custom theme using Rotary brand colors
  const customTheme = {
    ...(colorScheme === 'dark' ? DarkTheme : DefaultTheme),
    colors: {
      ...(colorScheme === 'dark' ? DarkTheme.colors : DefaultTheme.colors),
    },
  };

  return (
    <SafeAreaProvider>
      <ThemeProvider value={customTheme}>
        <Stack
          screenOptions={{
            headerStyle: {
              backgroundColor: customTheme.colors.card,
            },
            headerTitleStyle: {
              color: customTheme.colors.text,
              fontWeight: '600' as const,
              fontSize: Platform.OS === 'ios' ? 20 : 22,
            },
            headerTintColor: customTheme.colors.primary,
            headerShadowVisible: Platform.OS === 'ios',
            headerBackTitle: Platform.OS === 'ios' ? 'Terug' : '',
            contentStyle: {
              backgroundColor: customTheme.colors.background,
            },
          }}>
          {/* Main tab navigator */}
          <Stack.Screen name="(tabs)" options={{ headerShown: false }} />

          {/* Settings sub-screen - outside of tabs */}
          <Stack.Screen
            name="settings/contributors"
            options={{
              title: 'Contributors',
              headerBackTitle: 'Settings',
            }}
          />

          {/* Utility Screens */}
          <Stack.Screen
            name="camps-tours"
            options={{
              title: 'Zomerkampen',
              headerBackTitle: 'Home',
            }}
          />
          <Stack.Screen
            name="pdf-viewer"
            options={({ route }) => ({
              title: (route.params as any)?.title || 'PDF Document',
              headerBackTitle: 'Terug',
              headerTitleStyle: {
                fontSize: 18,
              },
            })}
          />

          {/* Calendar */}
          <Stack.Screen
            name="calendar/index"
            options={{
              title: 'Evenementen Kalender',
              headerBackTitle: 'Home',
            }}
          />

          {/* News */}
          <Stack.Screen
            name="news/index"
            options={{
              title: 'Nieuws & Updates',
              headerBackTitle: 'Home',
            }}
          />
          <Stack.Screen
            name="news/[id]"
            options={({ route }) => ({
              title: (route.params as any)?.title || 'Nieuws',
              headerBackTitle: 'Nieuws',
            })}
          />

          {/* Rebound */}
          <Stack.Screen
            name="rebound/index"
            options={{
              title: 'Rebound Studenten',
              headerBackTitle: 'Home',
            }}
          />
          <Stack.Screen
            name="rebound/students"
            options={({ route }) => ({
              title: (route.params as any)?.country || 'Studenten',
              headerBackTitle: 'Landen',
            })}
          />
          <Stack.Screen
            name="rebound/student-detail"
            options={({ route }) => ({
              title: (route.params as any)?.country || 'Student Detail',
              headerBackTitle: (route.params as any)?.country || 'Studenten',
            })}
          />

          {/* Rotary Clubs */}
          <Stack.Screen
            name="rotary-clubs/index"
            options={{
              title: 'Voor Rotary Clubs',
              headerBackTitle: 'Home',
            }}
          />
          <Stack.Screen
            name="rotary-clubs/algemene-informatie"
            options={{
              title: 'Algemene Informatie',
              headerBackTitle: 'Rotary Clubs',
            }}
          />
          <Stack.Screen
            name="rotary-clubs/jeugdcommissaris"
            options={{
              title: 'Info Jeugdcommissaris',
              headerBackTitle: 'Rotary Clubs',
            }}
          />
          <Stack.Screen
            name="rotary-clubs/gastgezin"
            options={{
              title: 'Info Gastgezin',
              headerBackTitle: 'Rotary Clubs',
            }}
          />
          <Stack.Screen
            name="rotary-clubs/counselor"
            options={{
              title: 'Info Counselor',
              headerBackTitle: 'Rotary Clubs',
            }}
          />
          <Stack.Screen
            name="rotary-clubs/documenten"
            options={{
              title: 'Belangrijke Documenten',
              headerBackTitle: 'Rotary Clubs',
            }}
          />

          {/* Programs */}
          <Stack.Screen
            name="programs/index"
            options={{
              title: "Programma's",
              headerBackTitle: 'Home',
            }}
          />
          <Stack.Screen
            name="programs/promo/index"
            options={{
              title: 'Promo Materiaal',
              headerBackTitle: "Programma's",
            }}
          />
          <Stack.Screen
            name="programs/promo/podcast"
            options={{
              title: 'Promo Podcast',
              headerBackTitle: 'Promo',
            }}
          />
          <Stack.Screen
            name="programs/promo/video"
            options={{
              title: 'Promo Video',
              headerBackTitle: 'Promo',
            }}
          />
          <Stack.Screen
            name="programs/information/long-term-exchange"
            options={{
              title: 'Long Term Exchange',
              headerBackTitle: "Programma's",
            }}
          />
          <Stack.Screen
            name="programs/information/family-to-family"
            options={{
              title: 'Family To Family',
              headerBackTitle: "Programma's",
            }}
          />
          <Stack.Screen
            name="programs/information/camps-tours"
            options={{
              title: 'Zomerkampen',
              headerBackTitle: "Programma's",
            }}
          />

          {/* Inbound */}
          <Stack.Screen
            name="inbound/index"
            options={{
              title: "Inbound Programma's",
              headerBackTitle: 'Home',
            }}
          />
          {/* Inbound - Long Term */}
          <Stack.Screen
            name="inbound/long-term/index"
            options={{
              title: 'Long Term Inbound',
              headerBackTitle: 'Inbound',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/class-of/index"
            options={{
              title: 'Huidige Studenten',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/class-of/student-detail"
            options={({ route }) => ({
              title: (route.params as any)?.studentName || 'Student Detail',
              headerBackTitle: 'Studenten',
              headerTitleStyle: {
                fontSize: 18,
              },
            })}
          />
          <Stack.Screen
            name="inbound/long-term/information/welcome-in-the-netherlands"
            options={{
              title: 'Welkom in Nederland',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/information/flight-and-arrival"
            options={{
              title: 'Vlucht en Aankomst',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/information/insurance"
            options={{
              title: 'Verzekering',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/information/language"
            options={{
              title: 'Nederlandse Taal',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="inbound/long-term/information/travel"
            options={{
              title: 'Reizen in Nederland',
              headerBackTitle: 'Long Term',
            }}
          />
          {/* Inbound - Short Term */}
          <Stack.Screen
            name="inbound/short-term/camps-and-tours/index"
            options={{
              title: 'Zomerkampen',
              headerBackTitle: 'Inbound',
            }}
          />
          <Stack.Screen
            name="inbound/short-term/family-to-family/index"
            options={{
              title: 'Family To Family',
              headerBackTitle: 'Inbound',
            }}
          />

          {/* Outbound */}
          <Stack.Screen
            name="outbound/index"
            options={{
              title: "Outbound Programma's",
              headerBackTitle: 'Home',
            }}
          />
          {/* Outbound - Long Term */}
          <Stack.Screen
            name="outbound/long-term/index"
            options={{
              title: 'Long Term Exchange',
              headerBackTitle: 'Outbound',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/class-of/index"
            options={{
              title: 'Huidige Studenten',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/class-of/student-detail"
            options={({ route }) => ({
              title: (route.params as any)?.studentName || 'Student Detail',
              headerBackTitle: 'Studenten',
              headerTitleStyle: {
                fontSize: 18,
              },
            })}
          />
          <Stack.Screen
            name="outbound/long-term/information/comply-with"
            options={{
              title: 'Regels & Voorwaarden',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/information/how-to-sign-up"
            options={{
              title: 'Hoe Aanmelden',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/information/selection-day"
            options={{
              title: 'Selectiedag',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/information/selection-weekend"
            options={{
              title: 'Selectieweekend',
              headerBackTitle: 'Long Term',
            }}
          />
          <Stack.Screen
            name="outbound/long-term/information/top-3-countries"
            options={{
              title: 'Top 3 Landen',
              headerBackTitle: 'Long Term',
            }}
          />
          {/* Outbound - Short Term */}
          <Stack.Screen
            name="outbound/short-term/camps-and-tours/index"
            options={{
              title: 'Zomerkampen',
              headerBackTitle: 'Short Term',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/camps-and-tours/information/comply-with"
            options={{
              title: 'Regels & Voorwaarden',
              headerBackTitle: 'Zomerkampen',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/camps-and-tours/information/how-to-sign-up"
            options={{
              title: 'Hoe Aanmelden',
              headerBackTitle: 'Zomerkampen',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/camps-and-tours/information/which-countries"
            options={{
              title: 'Welke Landen',
              headerBackTitle: 'Zomerkampen',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/family-to-family/index"
            options={{
              title: 'Family To Family',
              headerBackTitle: 'Short Term',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/family-to-family/information/comply-with"
            options={{
              title: 'Regels & Voorwaarden',
              headerBackTitle: 'Family To Family',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/family-to-family/information/how-to-sign-up"
            options={{
              title: 'Hoe Aanmelden',
              headerBackTitle: 'Family To Family',
            }}
          />
          <Stack.Screen
            name="outbound/short-term/family-to-family/information/countries-preference"
            options={{
              title: 'Landen Voorkeur',
              headerBackTitle: 'Family To Family',
            }}
          />
        </Stack>
        <StatusBar style="auto" backgroundColor={customTheme.colors.background} />
      </ThemeProvider>
    </SafeAreaProvider>
  );
}
