# Rotary YEP NL App - Full Rewrite Plan

## Summary

Full rewrite of the Rotary YEP NL Expo app to follow best practices with:
- **Feature-based folder structure** (`app/` for routes + `features/` for modules)
- **@expo/ui** with platform-specific files (`.ios.tsx` / `.android.tsx`) for native SwiftUI/Jetpack Compose components
- **React Context** for client state management (native React, no extra deps)
- **Custom hooks + expo-file-system** for data fetching with file-based caching
- **Restructured data** with improved TypeScript types (homeCountry/hostCountry naming)
- Keep **Expo SDK 54** (no upgrade)
- **iOS and Android only** (no web)
- **No new dependencies** - uses only built-in React and existing Expo SDK

---

## Tech Stack

| Category | Current | New |
|----------|---------|-----|
| State Management | Component useState | React Context (native) |
| Data Fetching | Inline fetch | Custom hooks + expo-file-system cache |
| UI Components | Inline StyleSheet | @expo/ui (platform-specific) + React Native |
| Folder Structure | Flat/mixed | Feature-based |
| API Keys | Hardcoded | Environment variables (.env) |
| Settings Storage | None | AsyncStorage (already installed) |

### Dependencies to Add

```bash
# No new dependencies needed! Using native React and Expo SDK libraries only.
# expo-file-system is already installed
```

---

## Folder Structure

```
rotary-yep-nl/
├── app/                              # Routes only (thin screens)
│   ├── _layout.tsx                   # Root layout with providers
│   ├── (tabs)/
│   │   ├── _layout.tsx
│   │   ├── index.tsx                 # Home
│   │   ├── about.tsx
│   │   ├── emergency.tsx
│   │   ├── contact.tsx
│   │   └── settings.tsx
│   ├── (students)/
│   │   ├── _layout.tsx
│   │   ├── inbound/
│   │   │   ├── index.tsx
│   │   │   ├── long-term.tsx
│   │   │   └── short-term.tsx
│   │   ├── outbound/
│   │   │   ├── index.tsx
│   │   │   ├── long-term.tsx
│   │   │   └── short-term.tsx
│   │   └── rebound/
│   │       ├── index.tsx
│   │       └── [country].tsx
│   ├── camps-tours.tsx
│   ├── calendar.tsx
│   ├── news/
│   │   ├── index.tsx
│   │   └── [id].tsx
│   ├── pdf-viewer.tsx
│   ├── programs/
│   │   ├── index.tsx
│   │   └── [program].tsx
│   └── rotary-clubs/
│       ├── index.tsx
│       └── [section].tsx
│
├── features/                         # Feature modules
│   ├── students/
│   │   ├── components/
│   │   │   ├── StudentCard.tsx
│   │   │   ├── StudentDetail.tsx
│   │   │   ├── StudentsList.tsx
│   │   │   └── CountrySection.tsx
│   │   ├── hooks/
│   │   │   └── useStudents.ts
│   │   ├── data/
│   │   │   ├── inbound.ts
│   │   │   ├── outbound.ts
│   │   │   └── rebound.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── camps-tours/
│   │   ├── components/
│   │   │   ├── CampCard.tsx
│   │   │   ├── CampsList.tsx
│   │   │   ├── FilterBar.tsx
│   │   │   ├── AvailabilityChip.tsx
│   │   │   ├── TimingChip.tsx
│   │   │   └── CountryModal.tsx
│   │   ├── hooks/
│   │   │   ├── useCampsQuery.ts
│   │   │   └── useCampsFilters.ts
│   │   ├── api/
│   │   │   └── fetchCamps.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── calendar/
│   │   ├── components/
│   │   │   ├── CalendarView.tsx
│   │   │   ├── EventCard.tsx
│   │   │   ├── EventsList.tsx
│   │   │   └── EventModal.tsx
│   │   ├── hooks/
│   │   │   ├── useCalendarEvents.ts
│   │   │   └── useMarkedDates.ts
│   │   ├── api/
│   │   │   └── fetchEvents.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── contacts/
│   │   ├── components/
│   │   │   ├── ContactCard.tsx
│   │   │   ├── ContactModal.tsx
│   │   │   └── ContactSection.tsx
│   │   ├── hooks/
│   │   │   └── useContacts.ts
│   │   ├── data/
│   │   │   ├── mdjc.ts
│   │   │   ├── rotex.ts
│   │   │   ├── long-term.ts
│   │   │   └── short-term.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── news/
│   │   ├── components/
│   │   │   ├── NewsCard.tsx
│   │   │   └── NewsDetail.tsx
│   │   ├── hooks/
│   │   │   └── useNews.ts
│   │   ├── data/
│   │   │   └── news.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── emergency/
│   │   ├── components/
│   │   │   └── EmergencyCard.tsx
│   │   ├── data/
│   │   │   └── contacts.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── programs/
│   │   ├── components/
│   │   │   ├── ProgramCard.tsx
│   │   │   └── InfoScreen.tsx
│   │   ├── data/
│   │   │   └── programs.ts
│   │   ├── types.ts
│   │   └── index.ts
│   │
│   ├── pdf-viewer/
│   │   ├── components/
│   │   │   └── PDFViewer.tsx
│   │   ├── hooks/
│   │   │   └── usePDFDownload.ts
│   │   └── index.ts
│   │
│   └── rotary-clubs/
│       ├── components/
│       │   └── InfoCard.tsx
│       ├── data/
│       │   └── club-info.ts
│       ├── types.ts
│       └── index.ts
│
├── shared/                           # Shared across features
│   ├── components/
│   │   ├── ui/                       # @expo/ui wrappers (platform-specific)
│   │   │   ├── Button.ios.tsx
│   │   │   ├── Button.android.tsx
│   │   │   ├── Section.ios.tsx
│   │   │   ├── Section.android.tsx
│   │   │   ├── Card.ios.tsx
│   │   │   ├── Card.android.tsx
│   │   │   ├── types.ts              # Shared types
│   │   │   └── index.ts
│   │   ├── feedback/
│   │   │   ├── LoadingState.tsx
│   │   │   ├── ErrorState.tsx
│   │   │   └── EmptyState.tsx
│   │   ├── media/
│   │   │   ├── NetworkImage.tsx
│   │   │   └── ImageModal.tsx
│   │   └── index.ts
│   │
│   ├── hooks/
│   │   ├── useHaptics.ts
│   │   ├── useRefresh.ts
│   │   └── index.ts
│   │
│   └── utils/
│       ├── date.ts
│       ├── flags.ts
│       ├── communications.ts
│       └── index.ts
│
├── core/                             # Core infrastructure
│   ├── theme/
│   │   ├── colors.ts
│   │   ├── spacing.ts
│   │   ├── ThemeProvider.tsx
│   │   ├── useTheme.ts
│   │   └── index.ts
│   │
│   ├── context/
│   │   ├── AppContext.tsx
│   │   ├── SettingsContext.tsx
│   │   └── index.ts
│   │
│   ├── cache/
│   │   ├── fileCache.ts
│   │   └── index.ts
│   │
│   ├── config/
│   │   ├── env.ts
│   │   └── constants.ts
│   │
│   └── types/
│       ├── common.ts
│       └── navigation.ts
│
├── assets/                           # Keep existing structure
├── .env                              # NEW: Environment variables
├── app.json
├── tsconfig.json
└── package.json
```

---

## Code Examples

### 1. Core Theme Provider

```typescript
// core/theme/ThemeProvider.tsx
import { ThemeProvider as NavigationThemeProvider } from '@react-navigation/native';
import { createContext, useContext, type ReactNode } from 'react';
import { useColorScheme } from 'react-native';
import { colors, type ThemeColors } from './colors';

interface ThemeContextValue {
  colors: ThemeColors;
  isDark: boolean;
}

const ThemeContext = createContext<ThemeContextValue | null>(null);

export function ThemeProvider({ children }: { children: ReactNode }) {
  const colorScheme = useColorScheme() ?? 'light';
  const isDark = colorScheme === 'dark';
  const themeColors = isDark ? colors.dark : colors.light;

  return (
    <ThemeContext.Provider value={{ colors: themeColors, isDark }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme() {
  const context = useContext(ThemeContext);
  if (!context) throw new Error('useTheme must be used within ThemeProvider');
  return context;
}
```

### 2. React Context for App State

```typescript
// core/context/AppContext.tsx
import { createContext, useContext, useState, type ReactNode } from 'react';
import type { Contact } from '@/features/contacts/types';

interface AppContextValue {
  // Modal state
  contactModalOpen: boolean;
  selectedContact: Contact | null;

  // Actions
  openContactModal: (contact: Contact) => void;
  closeContactModal: () => void;
}

const AppContext = createContext<AppContextValue | null>(null);

export function AppProvider({ children }: { children: ReactNode }) {
  const [contactModalOpen, setContactModalOpen] = useState(false);
  const [selectedContact, setSelectedContact] = useState<Contact | null>(null);

  const openContactModal = (contact: Contact) => {
    setSelectedContact(contact);
    setContactModalOpen(true);
  };

  const closeContactModal = () => {
    setContactModalOpen(false);
    setSelectedContact(null);
  };

  return (
    <AppContext.Provider value={{
      contactModalOpen,
      selectedContact,
      openContactModal,
      closeContactModal,
    }}>
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) throw new Error('useApp must be used within AppProvider');
  return context;
}
```

```typescript
// core/context/SettingsContext.tsx
import { createContext, useContext, useState, useEffect, type ReactNode } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface SettingsContextValue {
  hasRequestedReview: boolean;
  appOpenCount: number;

  incrementAppOpen: () => void;
  setReviewRequested: () => void;
}

const SettingsContext = createContext<SettingsContextValue | null>(null);

const STORAGE_KEYS = {
  REVIEW_REQUESTED: 'settings:reviewRequested',
  APP_OPEN_COUNT: 'settings:appOpenCount',
};

export function SettingsProvider({ children }: { children: ReactNode }) {
  const [hasRequestedReview, setHasRequestedReview] = useState(false);
  const [appOpenCount, setAppOpenCount] = useState(0);

  // Load settings from storage on mount
  useEffect(() => {
    const loadSettings = async () => {
      try {
        const [reviewRequested, openCount] = await Promise.all([
          AsyncStorage.getItem(STORAGE_KEYS.REVIEW_REQUESTED),
          AsyncStorage.getItem(STORAGE_KEYS.APP_OPEN_COUNT),
        ]);
        if (reviewRequested) setHasRequestedReview(reviewRequested === 'true');
        if (openCount) setAppOpenCount(parseInt(openCount, 10));
      } catch {
        // Ignore errors
      }
    };
    loadSettings();
  }, []);

  const incrementAppOpen = async () => {
    const newCount = appOpenCount + 1;
    setAppOpenCount(newCount);
    await AsyncStorage.setItem(STORAGE_KEYS.APP_OPEN_COUNT, String(newCount));
  };

  const setReviewRequested = async () => {
    setHasRequestedReview(true);
    await AsyncStorage.setItem(STORAGE_KEYS.REVIEW_REQUESTED, 'true');
  };

  return (
    <SettingsContext.Provider value={{
      hasRequestedReview,
      appOpenCount,
      incrementAppOpen,
      setReviewRequested,
    }}>
      {children}
    </SettingsContext.Provider>
  );
}

export function useSettings() {
  const context = useContext(SettingsContext);
  if (!context) throw new Error('useSettings must be used within SettingsProvider');
  return context;
}
```

### 3. File Cache Utility (expo-file-system)

```typescript
// core/cache/fileCache.ts
import * as FileSystem from 'expo-file-system';

const CACHE_DIR = FileSystem.cacheDirectory + 'data/';

interface CacheEntry<T> {
  data: T;
  timestamp: number;
  expiresAt: number;
}

export async function getCached<T>(key: string): Promise<T | null> {
  try {
    const path = CACHE_DIR + key + '.json';
    const info = await FileSystem.getInfoAsync(path);

    if (!info.exists) return null;

    const content = await FileSystem.readAsStringAsync(path);
    const entry: CacheEntry<T> = JSON.parse(content);

    // Check if expired
    if (Date.now() > entry.expiresAt) {
      await FileSystem.deleteAsync(path, { idempotent: true });
      return null;
    }

    return entry.data;
  } catch {
    return null;
  }
}

export async function setCache<T>(
  key: string,
  data: T,
  ttlMinutes: number = 10
): Promise<void> {
  try {
    // Ensure cache directory exists
    const dirInfo = await FileSystem.getInfoAsync(CACHE_DIR);
    if (!dirInfo.exists) {
      await FileSystem.makeDirectoryAsync(CACHE_DIR, { intermediates: true });
    }

    const entry: CacheEntry<T> = {
      data,
      timestamp: Date.now(),
      expiresAt: Date.now() + ttlMinutes * 60 * 1000,
    };

    const path = CACHE_DIR + key + '.json';
    await FileSystem.writeAsStringAsync(path, JSON.stringify(entry));
  } catch (error) {
    console.warn('Cache write failed:', error);
  }
}

export async function clearCache(key?: string): Promise<void> {
  try {
    if (key) {
      await FileSystem.deleteAsync(CACHE_DIR + key + '.json', { idempotent: true });
    } else {
      await FileSystem.deleteAsync(CACHE_DIR, { idempotent: true });
    }
  } catch {
    // Ignore errors
  }
}
```

### 4. Root Layout with Providers

```typescript
// app/_layout.tsx
import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';

import { ThemeProvider, useTheme } from '@/core/theme';
import { AppProvider } from '@/core/context/AppContext';
import { SettingsProvider } from '@/core/context/SettingsContext';

function RootLayoutNav() {
  const { colors, isDark } = useTheme();

  return (
    <>
      <StatusBar style={isDark ? 'light' : 'dark'} />
      <Stack
        screenOptions={{
          headerStyle: { backgroundColor: colors.background },
          headerTintColor: colors.text,
          contentStyle: { backgroundColor: colors.background },
        }}
      >
        <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
        <Stack.Screen name="(students)" options={{ headerShown: false }} />
        <Stack.Screen name="camps-tours" options={{ title: 'Camps & Tours' }} />
        <Stack.Screen name="calendar" options={{ title: 'Kalender' }} />
        <Stack.Screen name="pdf-viewer" options={{ presentation: 'modal' }} />
      </Stack>
    </>
  );
}

export default function RootLayout() {
  return (
    <SafeAreaProvider>
      <ThemeProvider>
        <SettingsProvider>
          <AppProvider>
            <RootLayoutNav />
          </AppProvider>
        </SettingsProvider>
      </ThemeProvider>
    </SafeAreaProvider>
  );
}
```

### 5. Environment Variables

```bash
# .env
EXPO_PUBLIC_GOOGLE_API_KEY=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
EXPO_PUBLIC_GOOGLE_CALENDAR_ID=rye.netherlands@gmail.com
EXPO_PUBLIC_CAMPS_CSV_URL=https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv
```

```typescript
// core/config/env.ts
export const env = {
  googleApiKey: process.env.EXPO_PUBLIC_GOOGLE_API_KEY!,
  googleCalendarId: process.env.EXPO_PUBLIC_GOOGLE_CALENDAR_ID!,
  campsCsvUrl: process.env.EXPO_PUBLIC_CAMPS_CSV_URL!,
} as const;
```

### 6. Custom Hook with File Caching

```typescript
// features/calendar/hooks/useCalendarEvents.ts
import { useState, useEffect, useCallback } from 'react';
import { getCached, setCache } from '@/core/cache/fileCache';
import { fetchCalendarEvents } from '../api/fetchEvents';
import type { EventsData } from '../types';

const CACHE_KEY = 'calendar-events';
const CACHE_TTL_MINUTES = 10;

export function useCalendarEvents() {
  const [data, setData] = useState<EventsData | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const loadEvents = useCallback(async (forceRefresh = false) => {
    try {
      setIsLoading(true);
      setError(null);

      // Try cache first (unless forcing refresh)
      if (!forceRefresh) {
        const cached = await getCached<EventsData>(CACHE_KEY);
        if (cached) {
          setData(cached);
          setIsLoading(false);
          return;
        }
      }

      // Fetch fresh data
      const freshData = await fetchCalendarEvents();
      setData(freshData);

      // Save to cache
      await setCache(CACHE_KEY, freshData, CACHE_TTL_MINUTES);
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to load events'));
    } finally {
      setIsLoading(false);
    }
  }, []);

  // Initial load
  useEffect(() => {
    loadEvents();
  }, [loadEvents]);

  return {
    data,
    isLoading,
    error,
    refetch: () => loadEvents(true),
  };
}

// features/calendar/api/fetchEvents.ts
import { env } from '@/core/config/env';
import type { GoogleCalendarResponse, EventsData } from '../types';

export async function fetchCalendarEvents(): Promise<EventsData> {
  const now = new Date();
  const timeMin = new Date(now.getFullYear(), now.getMonth() - 6, 1).toISOString();
  const timeMax = new Date(now.getFullYear() + 1, now.getMonth(), 1).toISOString();

  const params = new URLSearchParams({
    key: env.googleApiKey,
    timeMin,
    timeMax,
    maxResults: '2500',
    singleEvents: 'true',
    orderBy: 'startTime',
  });

  const response = await fetch(
    `https://www.googleapis.com/calendar/v3/calendars/${env.googleCalendarId}/events?${params}`
  );

  if (!response.ok) {
    throw new Error('Failed to fetch calendar events');
  }

  const data: GoogleCalendarResponse = await response.json();
  return groupEventsByDate(data.items);
}
```

### 7. Restructured Student Types

```typescript
// features/students/types.ts

// Base types
export interface SocialMedia {
  instagram?: string;
  facebook?: string;
  snapchat?: string;
  linkedin?: string;
  website?: string;
}

export interface Country {
  code: string;       // e.g., "NL"
  name: string;       // e.g., "Netherlands"
  flag: string;       // emoji or asset path
}

// Main student type
export interface Student {
  id: string;
  name: string;
  bio: string;
  description?: string;
  imageUrl?: string;
  videoUrl?: string;

  // Contact
  email?: string;
  phone?: string;
  socialMedia?: SocialMedia;

  // Exchange info
  homeCountry: Country;
  hostCountry: Country;
  hostFamily?: string;

  // Metadata
  year: string;        // e.g., "2025-26"
  type: StudentType;
}

export type StudentType = 'inbound' | 'outbound' | 'rebound';

// Grouped by country for display
export interface CountryGroup {
  country: Country;
  students: Student[];
}

// Year-based grouping for rebound
export interface YearGroup {
  year: string;
  students: Student[];
}
```

### 8. Restructured Contact Types

```typescript
// features/contacts/types.ts

export type ContactCategory = 'mdjc' | 'rotex' | 'longterm' | 'shortterm';

export interface SocialMedia {
  instagram?: string;
  facebook?: string;
  linkedin?: string;
  website?: string;
}

export interface Contact {
  id: string;
  name: string;
  role: string;           // e.g., "Voorzitter", "Secretaris"
  bio?: string;
  imageUrl?: string;

  // Contact methods
  email?: string;
  phone?: string;
  whatsapp?: string;      // If different from phone
  socialMedia?: SocialMedia;

  // Organization info (for MDJC)
  club?: string;
  district?: string;

  // Category
  category: ContactCategory;
}

export interface ContactSection {
  category: ContactCategory;
  title: string;          // Display title
  description?: string;
  contacts: Contact[];
}
```

### 9. Feature Module Example (Students)

```typescript
// features/students/index.ts
// Public API for students feature

export { StudentCard } from './components/StudentCard';
export { StudentDetail } from './components/StudentDetail';
export { StudentsList } from './components/StudentsList';
export { CountrySection } from './components/CountrySection';

export { useStudents } from './hooks/useStudents';

export type { Student, StudentType, CountryGroup } from './types';
```

```typescript
// features/students/hooks/useStudents.ts
import { useMemo } from 'react';
import { inboundStudents } from '../data/inbound';
import { outboundStudents } from '../data/outbound';
import { reboundStudents } from '../data/rebound';
import type { Student, StudentType, CountryGroup } from '../types';

export function useStudents(type: StudentType) {
  const students = useMemo(() => {
    switch (type) {
      case 'inbound':
        return inboundStudents;
      case 'outbound':
        return outboundStudents;
      case 'rebound':
        return reboundStudents;
      default:
        return [];
    }
  }, [type]);

  const countryGroups = useMemo<CountryGroup[]>(() => {
    const grouped = new Map<string, Student[]>();

    students.forEach((student) => {
      const key = student.homeCountry.code;
      const existing = grouped.get(key) || [];
      grouped.set(key, [...existing, student]);
    });

    return Array.from(grouped.entries())
      .map(([_, students]) => ({
        country: students[0].homeCountry,
        students,
      }))
      .sort((a, b) => a.country.name.localeCompare(b.country.name));
  }, [students]);

  return {
    students,
    countryGroups,
    totalCount: students.length,
    countryCount: countryGroups.length,
  };
}
```

### 10. Thin Route Screen Example

```typescript
// app/(students)/inbound/long-term.tsx
import { SafeAreaView } from 'react-native-safe-area-context';
import { StudentsList, useStudents } from '@/features/students';
import { LoadingState, ErrorState } from '@/shared/components';

export default function InboundLongTermScreen() {
  const { students, countryGroups, totalCount } = useStudents('inbound');

  return (
    <SafeAreaView style={{ flex: 1 }} edges={['bottom']}>
      <StudentsList
        countryGroups={countryGroups}
        totalCount={totalCount}
      />
    </SafeAreaView>
  );
}
```

### 11. Camps-Tours with Custom Hook + Caching

```typescript
// features/camps-tours/hooks/useCampsQuery.ts
import { useState, useEffect, useCallback } from 'react';
import { getCached, setCache } from '@/core/cache/fileCache';
import { fetchCamps } from '../api/fetchCamps';
import type { Camp } from '../types';

const CACHE_KEY = 'camps-tours';
const CACHE_TTL_MINUTES = 15;

export function useCampsQuery() {
  const [data, setData] = useState<Camp[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  const loadCamps = useCallback(async (forceRefresh = false) => {
    try {
      setIsLoading(true);
      setError(null);

      // Try cache first
      if (!forceRefresh) {
        const cached = await getCached<Camp[]>(CACHE_KEY);
        if (cached) {
          setData(cached);
          setIsLoading(false);
          return;
        }
      }

      // Fetch and parse CSV
      const freshData = await fetchCamps();
      setData(freshData);
      await setCache(CACHE_KEY, freshData, CACHE_TTL_MINUTES);
    } catch (err) {
      setError(err instanceof Error ? err : new Error('Failed to load camps'));
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    loadCamps();
  }, [loadCamps]);

  return {
    data,
    isLoading,
    error,
    refetch: () => loadCamps(true),
  };
}

// features/camps-tours/hooks/useCampsFilters.ts
import { useState, useMemo } from 'react';
import type { Camp, FilterState } from '../types';

const initialFilters: FilterState = {
  availability: 'alle',
  timing: 'toekomstig',
  country: 'alle',
};

export function useCampsFilters(camps: Camp[]) {
  const [filters, setFilters] = useState<FilterState>(initialFilters);

  const filteredCamps = useMemo(() => {
    return camps.filter((camp) => {
      // Availability filter
      if (filters.availability === 'niet-vol' && camp.isFull) return false;
      if (filters.availability === 'vol' && !camp.isFull) return false;

      // Timing filter
      const now = new Date();
      const startDate = new Date(camp.startDate);
      if (filters.timing === 'toekomstig' && startDate < now) return false;
      if (filters.timing === 'afgelopen' && startDate >= now) return false;

      // Country filter
      if (filters.country !== 'alle' && camp.hostCountryCode !== filters.country) {
        return false;
      }

      return true;
    });
  }, [camps, filters]);

  const countries = useMemo(() => {
    const unique = new Set(camps.map((c) => c.hostCountryCode));
    return Array.from(unique).sort();
  }, [camps]);

  return {
    filters,
    setFilters,
    filteredCamps,
    countries,
    resetFilters: () => setFilters(initialFilters),
  };
}
```

### 12. @expo/ui Native Components (Platform-Specific)

**Important:** @expo/ui provides platform-specific components:
- iOS: `@expo/ui/swift-ui` (SwiftUI components)
- Android: `@expo/ui/jetpack-compose` (Jetpack Compose components)

We use platform-specific file extensions (`.ios.tsx` and `.android.tsx`) for native UI:

```typescript
// shared/components/ui/Section.ios.tsx
import { Section as ExpoSection, Text } from '@expo/ui/swift-ui';
import type { ReactNode } from 'react';

interface SectionProps {
  title?: string;
  children: ReactNode;
}

export function Section({ title, children }: SectionProps) {
  return (
    <ExpoSection title={title}>
      {children}
    </ExpoSection>
  );
}
```

```typescript
// shared/components/ui/Section.android.tsx
import { Section as ExpoSection, Text } from '@expo/ui/jetpack-compose';
import type { ReactNode } from 'react';

interface SectionProps {
  title?: string;
  children: ReactNode;
}

export function Section({ title, children }: SectionProps) {
  return (
    <ExpoSection title={title}>
      {children}
    </ExpoSection>
  );
}
```

```typescript
// shared/components/ui/Section.tsx (fallback/types export)
// This file exports the types and is used for imports
export type { SectionProps } from './Section.ios';
```

**Available @expo/ui Components:**

| iOS (swift-ui) | Android (jetpack-compose) |
|----------------|---------------------------|
| Host | Host |
| Section | Section |
| Text | Text |
| Image | Image |
| Switch | Switch |
| Button | Button |
| HStack, VStack | Row, Column |
| CircularProgress | CircularProgressIndicator |
| LinearProgress | LinearProgressIndicator |
| Spacer | Spacer |
| BottomSheet | - |

```typescript
// Example usage with platform-specific rendering
// features/contacts/components/ContactSection.tsx
import { Section } from '@/shared/components/ui';
import { ContactCard } from './ContactCard';
import type { Contact } from '../types';

interface ContactSectionProps {
  title: string;
  contacts: Contact[];
  onContactPress: (contact: Contact) => void;
}

export function ContactSection({ title, contacts, onContactPress }: ContactSectionProps) {
  return (
    <Section title={title}>
      {contacts.map((contact) => (
        <ContactCard
          key={contact.id}
          contact={contact}
          onPress={() => onContactPress(contact)}
        />
      ))}
    </Section>
  );
}
```

---

## Implementation Order

### Step 1: Core Infrastructure
Create in this order (no external dependencies):
1. `.env` file
2. `core/config/env.ts`
3. `core/config/constants.ts`
4. `core/types/common.ts`
5. `core/types/navigation.ts`
6. `core/theme/colors.ts`
7. `core/theme/spacing.ts`
8. `core/theme/useTheme.ts`
9. `core/theme/ThemeProvider.tsx`
10. `core/theme/index.ts`
11. `core/cache/fileCache.ts` (expo-file-system)
12. `core/cache/index.ts`
13. `core/context/AppContext.tsx`
14. `core/context/SettingsContext.tsx`
15. `core/context/index.ts`

### Step 2: Shared Components
Create shared utilities and components:
1. `shared/utils/date.ts`
2. `shared/utils/flags.ts`
3. `shared/utils/communications.ts`
4. `shared/hooks/useHaptics.ts`
5. `shared/hooks/useRefresh.ts`
6. `shared/components/feedback/LoadingState.tsx`
7. `shared/components/feedback/ErrorState.tsx`
8. `shared/components/feedback/EmptyState.tsx`
9. `shared/components/media/NetworkImage.tsx`
10. `shared/components/ui/Section.tsx`
11. `shared/components/ui/Card.tsx`
12. `shared/components/ui/Button.tsx`

### Step 3: Feature Modules
Create each feature module completely:
1. **contacts/** - simplest, static data only
2. **emergency/** - simple, static data
3. **students/** - static data (inbound, outbound, rebound)
4. **news/** - static data, slightly more complex
5. **rotary-clubs/** - static data
6. **programs/** - static data
7. **pdf-viewer/** - utility feature
8. **calendar/** - custom hook + file cache, Google Calendar API
9. **camps-tours/** - custom hook + file cache, CSV parsing, filtering

### Step 4: Route Files
Update all route files to be thin wrappers:
1. `app/_layout.tsx` - add providers
2. `app/(tabs)/_layout.tsx`
3. `app/(tabs)/index.tsx`
4. `app/(tabs)/contact.tsx`
5. `app/(tabs)/emergency.tsx`
6. `app/(tabs)/about.tsx`
7. `app/(tabs)/settings.tsx`
8. All student routes
9. All program routes
10. Calendar, camps-tours, news routes

### Step 5: Cleanup
1. Delete old `components/` folder
2. Delete old `hooks/` folder
3. Delete old `utils/` folder
4. Delete old `types/` folder
5. Delete old `data/` folder
6. Delete old `constants/` folder
7. Update `tsconfig.json` path aliases
8. Run linting and fix issues
9. Test all screens

---

## Files to Delete (After Migration)

```
components/
├── enhanced-contact-card.tsx
├── contact-modal.tsx
├── network-image.tsx
├── image-modal.tsx
├── camps-tours/
│   ├── types.ts
│   └── hooks/
└── students/
    ├── StudentsList.tsx
    └── StudentDetail.tsx

hooks/
├── use-theme.tsx
└── use-contact-info.ts

utils/
├── communications.ts
├── dateUtils.ts
├── flags.ts
└── eventUtils.ts

types/
├── contact.ts
├── student.ts
├── events.ts
├── googleCalendar.ts
└── index.ts

data/
├── inbound-students.ts
├── outbound-students.ts
└── contacts/
    ├── mdjc.ts
    ├── rotex.ts
    ├── long-term.ts
    └── short-term.ts

constants/
├── theme.ts
└── styles.ts
```

---

## tsconfig.json Updates

```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"],
      "@/features/*": ["./features/*"],
      "@/shared/*": ["./shared/*"],
      "@/core/*": ["./core/*"]
    }
  }
}
```

---

## Detailed Implementation Checklist

This is a step-by-step checklist. Complete each item in order. Do not skip any steps.

### Phase 1: Setup & Configuration

- [ ] **1.1** Create `.env` file in project root with:
  ```
  EXPO_PUBLIC_GOOGLE_API_KEY=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
  EXPO_PUBLIC_GOOGLE_CALENDAR_ID=rye.netherlands@gmail.com
  EXPO_PUBLIC_CAMPS_CSV_URL=https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv
  ```
- [ ] **1.2** Add `.env` to `.gitignore` if not already there
- [ ] **1.3** Update `tsconfig.json` to add path aliases:
  ```json
  "paths": {
    "@/*": ["./*"],
    "@/features/*": ["./features/*"],
    "@/shared/*": ["./shared/*"],
    "@/core/*": ["./core/*"]
  }
  ```
- [ ] **1.4** Create folder structure:
  - [ ] Create `core/` directory
  - [ ] Create `core/config/` directory
  - [ ] Create `core/theme/` directory
  - [ ] Create `core/context/` directory
  - [ ] Create `core/cache/` directory
  - [ ] Create `core/types/` directory
  - [ ] Create `features/` directory
  - [ ] Create `shared/` directory
  - [ ] Create `shared/components/` directory
  - [ ] Create `shared/components/ui/` directory
  - [ ] Create `shared/components/feedback/` directory
  - [ ] Create `shared/components/media/` directory
  - [ ] Create `shared/hooks/` directory
  - [ ] Create `shared/utils/` directory

### Phase 2: Core Infrastructure

#### 2.1 Configuration
- [ ] **2.1.1** Create `core/config/env.ts` - environment variables accessor
- [ ] **2.1.2** Create `core/config/constants.ts` - app constants (app name, URLs, etc.)

#### 2.2 Types
- [ ] **2.2.1** Create `core/types/common.ts` - base interfaces (BaseEntity, WithImage, WithSocialMedia)
- [ ] **2.2.2** Create `core/types/navigation.ts` - navigation type definitions

#### 2.3 Theme
- [ ] **2.3.1** Create `core/theme/colors.ts` - migrate colors from `constants/theme.ts`
  - Include Rotary brand colors (Royal Blue, Gold, Azure)
  - Include light and dark mode color schemes
- [ ] **2.3.2** Create `core/theme/spacing.ts` - spacing scale (4/8/16/24/32/48px)
- [ ] **2.3.3** Create `core/theme/useTheme.ts` - useTheme hook
- [ ] **2.3.4** Create `core/theme/ThemeProvider.tsx` - theme context provider
- [ ] **2.3.5** Create `core/theme/index.ts` - export all theme modules

#### 2.4 Cache
- [ ] **2.4.1** Create `core/cache/fileCache.ts` - file-based caching with expo-file-system
  - getCached<T>(key) function
  - setCache<T>(key, data, ttlMinutes) function
  - clearCache(key?) function
- [ ] **2.4.2** Create `core/cache/index.ts` - export cache utilities

#### 2.5 Context
- [ ] **2.5.1** Create `core/context/AppContext.tsx` - app-wide state (modals, selections)
- [ ] **2.5.2** Create `core/context/SettingsContext.tsx` - user preferences with AsyncStorage
- [ ] **2.5.3** Create `core/context/index.ts` - export contexts

### Phase 3: Shared Utilities

#### 3.1 Utils
- [ ] **3.1.1** Create `shared/utils/date.ts` - migrate from `utils/dateUtils.ts`
  - formatDate function
  - parseDate function
  - isMultiDayEvent function
  - compareDates function
- [ ] **3.1.2** Create `shared/utils/flags.ts` - migrate from `utils/flags.ts`
  - getFlag function (returns emoji or asset path)
  - Country code to flag mapping
- [ ] **3.1.3** Create `shared/utils/communications.ts` - migrate from `utils/communications.ts`
  - openPhone function
  - openEmail function
  - openWhatsApp function
  - openURL function
  - formatPhoneNumber function
  - getInitials function
- [ ] **3.1.4** Create `shared/utils/index.ts` - export all utils

#### 3.2 Hooks
- [ ] **3.2.1** Create `shared/hooks/useHaptics.ts` - haptic feedback hook
- [ ] **3.2.2** Create `shared/hooks/useRefresh.ts` - pull-to-refresh hook
- [ ] **3.2.3** Create `shared/hooks/index.ts` - export all hooks

### Phase 4: Shared Components

#### 4.1 Feedback Components
- [ ] **4.1.1** Create `shared/components/feedback/LoadingState.tsx`
  - Accept optional message prop
  - Use ActivityIndicator with theme colors
- [ ] **4.1.2** Create `shared/components/feedback/ErrorState.tsx`
  - Accept error message and onRetry callback
  - Display error icon and retry button
- [ ] **4.1.3** Create `shared/components/feedback/EmptyState.tsx`
  - Accept title, message, and optional icon
  - Used when lists are empty

#### 4.2 Media Components
- [ ] **4.2.1** Create `shared/components/media/NetworkImage.tsx` - migrate from `components/network-image.tsx`
  - Accept source, placeholder, and style props
  - Handle loading and error states
- [ ] **4.2.2** Create `shared/components/media/ImageModal.tsx` - migrate from `components/image-modal.tsx`
  - Full-screen image preview
  - Pinch to zoom

#### 4.3 UI Components (Platform-Specific)
- [ ] **4.3.1** Create `shared/components/ui/types.ts` - shared component prop types
- [ ] **4.3.2** Create `shared/components/ui/Section.ios.tsx` - using @expo/ui/swift-ui
- [ ] **4.3.3** Create `shared/components/ui/Section.android.tsx` - using @expo/ui/jetpack-compose
- [ ] **4.3.4** Create `shared/components/ui/Card.ios.tsx`
- [ ] **4.3.5** Create `shared/components/ui/Card.android.tsx`
- [ ] **4.3.6** Create `shared/components/ui/Button.ios.tsx`
- [ ] **4.3.7** Create `shared/components/ui/Button.android.tsx`
- [ ] **4.3.8** Create `shared/components/ui/index.ts` - export all UI components

- [ ] **4.4** Create `shared/components/index.ts` - export all shared components

### Phase 5: Feature Modules

#### 5.1 Contacts Feature
- [ ] **5.1.1** Create `features/contacts/` directory
- [ ] **5.1.2** Create `features/contacts/types.ts` - Contact, ContactCategory, ContactSection
- [ ] **5.1.3** Create `features/contacts/data/` directory
- [ ] **5.1.4** Create `features/contacts/data/mdjc.ts` - migrate from `data/contacts/mdjc.ts`
- [ ] **5.1.5** Create `features/contacts/data/rotex.ts` - migrate from `data/contacts/rotex.ts`
- [ ] **5.1.6** Create `features/contacts/data/long-term.ts` - migrate from `data/contacts/long-term.ts`
- [ ] **5.1.7** Create `features/contacts/data/short-term.ts` - migrate from `data/contacts/short-term.ts`
- [ ] **5.1.8** Create `features/contacts/hooks/useContacts.ts`
- [ ] **5.1.9** Create `features/contacts/components/` directory
- [ ] **5.1.10** Create `features/contacts/components/ContactCard.tsx`
- [ ] **5.1.11** Create `features/contacts/components/ContactModal.tsx` - migrate from `components/contact-modal.tsx`
- [ ] **5.1.12** Create `features/contacts/components/ContactSection.tsx`
- [ ] **5.1.13** Create `features/contacts/index.ts` - public API exports

#### 5.2 Emergency Feature
- [ ] **5.2.1** Create `features/emergency/` directory
- [ ] **5.2.2** Create `features/emergency/types.ts`
- [ ] **5.2.3** Create `features/emergency/data/contacts.ts` - emergency contact data
- [ ] **5.2.4** Create `features/emergency/components/` directory
- [ ] **5.2.5** Create `features/emergency/components/EmergencyCard.tsx`
- [ ] **5.2.6** Create `features/emergency/index.ts`

#### 5.3 Students Feature
- [ ] **5.3.1** Create `features/students/` directory
- [ ] **5.3.2** Create `features/students/types.ts` - Student, CountryGroup, StudentType
- [ ] **5.3.3** Create `features/students/data/` directory
- [ ] **5.3.4** Create `features/students/data/inbound.ts` - migrate and restructure from `data/inbound-students.ts`
- [ ] **5.3.5** Create `features/students/data/outbound.ts` - migrate and restructure from `data/outbound-students.ts`
- [ ] **5.3.6** Create `features/students/data/rebound.ts` - convert from `assets/students/list.json`
- [ ] **5.3.7** Create `features/students/hooks/useStudents.ts`
- [ ] **5.3.8** Create `features/students/components/` directory
- [ ] **5.3.9** Create `features/students/components/StudentCard.tsx`
- [ ] **5.3.10** Create `features/students/components/StudentDetail.tsx` - migrate from `components/students/StudentDetail.tsx`
- [ ] **5.3.11** Create `features/students/components/StudentsList.tsx` - migrate from `components/students/StudentsList.tsx`
- [ ] **5.3.12** Create `features/students/components/CountrySection.tsx`
- [ ] **5.3.13** Create `features/students/index.ts`

#### 5.4 News Feature
- [ ] **5.4.1** Create `features/news/` directory
- [ ] **5.4.2** Create `features/news/types.ts` - NewsItem type
- [ ] **5.4.3** Create `features/news/data/news.ts` - news data
- [ ] **5.4.4** Create `features/news/hooks/useNews.ts`
- [ ] **5.4.5** Create `features/news/components/` directory
- [ ] **5.4.6** Create `features/news/components/NewsCard.tsx`
- [ ] **5.4.7** Create `features/news/components/NewsDetail.tsx`
- [ ] **5.4.8** Create `features/news/index.ts`

#### 5.5 Rotary Clubs Feature
- [ ] **5.5.1** Create `features/rotary-clubs/` directory
- [ ] **5.5.2** Create `features/rotary-clubs/types.ts`
- [ ] **5.5.3** Create `features/rotary-clubs/data/club-info.ts`
- [ ] **5.5.4** Create `features/rotary-clubs/components/` directory
- [ ] **5.5.5** Create `features/rotary-clubs/components/InfoCard.tsx`
- [ ] **5.5.6** Create `features/rotary-clubs/index.ts`

#### 5.6 Programs Feature
- [ ] **5.6.1** Create `features/programs/` directory
- [ ] **5.6.2** Create `features/programs/types.ts`
- [ ] **5.6.3** Create `features/programs/data/programs.ts`
- [ ] **5.6.4** Create `features/programs/components/` directory
- [ ] **5.6.5** Create `features/programs/components/ProgramCard.tsx`
- [ ] **5.6.6** Create `features/programs/components/InfoScreen.tsx`
- [ ] **5.6.7** Create `features/programs/index.ts`

#### 5.7 PDF Viewer Feature
- [ ] **5.7.1** Create `features/pdf-viewer/` directory
- [ ] **5.7.2** Create `features/pdf-viewer/hooks/usePDFDownload.ts`
- [ ] **5.7.3** Create `features/pdf-viewer/components/` directory
- [ ] **5.7.4** Create `features/pdf-viewer/components/PDFViewer.tsx`
- [ ] **5.7.5** Create `features/pdf-viewer/index.ts`

#### 5.8 Calendar Feature
- [ ] **5.8.1** Create `features/calendar/` directory
- [ ] **5.8.2** Create `features/calendar/types.ts` - Event, EventsData, GoogleCalendarResponse
- [ ] **5.8.3** Create `features/calendar/api/` directory
- [ ] **5.8.4** Create `features/calendar/api/fetchEvents.ts` - Google Calendar API fetch
- [ ] **5.8.5** Create `features/calendar/hooks/` directory
- [ ] **5.8.6** Create `features/calendar/hooks/useCalendarEvents.ts` - with file caching
- [ ] **5.8.7** Create `features/calendar/hooks/useMarkedDates.ts` - calendar marking logic
- [ ] **5.8.8** Create `features/calendar/components/` directory
- [ ] **5.8.9** Create `features/calendar/components/CalendarView.tsx`
- [ ] **5.8.10** Create `features/calendar/components/EventCard.tsx`
- [ ] **5.8.11** Create `features/calendar/components/EventsList.tsx`
- [ ] **5.8.12** Create `features/calendar/components/EventModal.tsx`
- [ ] **5.8.13** Create `features/calendar/index.ts`

#### 5.9 Camps & Tours Feature
- [ ] **5.9.1** Create `features/camps-tours/` directory
- [ ] **5.9.2** Create `features/camps-tours/types.ts` - Camp, FilterState
- [ ] **5.9.3** Create `features/camps-tours/api/` directory
- [ ] **5.9.4** Create `features/camps-tours/api/fetchCamps.ts` - CSV fetch and parse
- [ ] **5.9.5** Create `features/camps-tours/hooks/` directory
- [ ] **5.9.6** Create `features/camps-tours/hooks/useCampsQuery.ts` - with file caching
- [ ] **5.9.7** Create `features/camps-tours/hooks/useCampsFilters.ts` - filtering logic
- [ ] **5.9.8** Create `features/camps-tours/components/` directory
- [ ] **5.9.9** Create `features/camps-tours/components/CampCard.tsx`
- [ ] **5.9.10** Create `features/camps-tours/components/CampsList.tsx`
- [ ] **5.9.11** Create `features/camps-tours/components/FilterBar.tsx`
- [ ] **5.9.12** Create `features/camps-tours/components/AvailabilityChip.tsx`
- [ ] **5.9.13** Create `features/camps-tours/components/TimingChip.tsx`
- [ ] **5.9.14** Create `features/camps-tours/components/CountryModal.tsx`
- [ ] **5.9.15** Create `features/camps-tours/index.ts`

### Phase 6: Route Files

#### 6.1 Root Layout
- [ ] **6.1.1** Update `app/_layout.tsx`:
  - Add SafeAreaProvider
  - Add ThemeProvider
  - Add SettingsProvider
  - Add AppProvider
  - Configure Stack screens

#### 6.2 Tab Routes
- [ ] **6.2.1** Update `app/(tabs)/_layout.tsx` - tab configuration
- [ ] **6.2.2** Rewrite `app/(tabs)/index.tsx` - Home screen (thin wrapper)
- [ ] **6.2.3** Rewrite `app/(tabs)/about.tsx` (or `about/index.tsx`)
- [ ] **6.2.4** Rewrite `app/(tabs)/emergency.tsx` (or `emergency/index.tsx`)
- [ ] **6.2.5** Rewrite `app/(tabs)/contact.tsx` (or `contact/index.tsx`)
- [ ] **6.2.6** Rewrite `app/(tabs)/settings.tsx` (or `settings/index.tsx`)

#### 6.3 Student Routes
- [ ] **6.3.1** Update/create `app/(students)/_layout.tsx`
- [ ] **6.3.2** Rewrite `app/(students)/inbound/index.tsx`
- [ ] **6.3.3** Rewrite `app/(students)/inbound/long-term.tsx`
- [ ] **6.3.4** Rewrite `app/(students)/inbound/short-term.tsx`
- [ ] **6.3.5** Rewrite `app/(students)/outbound/index.tsx`
- [ ] **6.3.6** Rewrite `app/(students)/outbound/long-term.tsx`
- [ ] **6.3.7** Rewrite `app/(students)/outbound/short-term.tsx`
- [ ] **6.3.8** Rewrite `app/(students)/rebound/index.tsx`
- [ ] **6.3.9** Rewrite `app/(students)/rebound/[country].tsx`

#### 6.4 Other Routes
- [ ] **6.4.1** Rewrite `app/camps-tours.tsx` - thin wrapper using features/camps-tours
- [ ] **6.4.2** Rewrite `app/calendar.tsx` (or `calendar/index.tsx`)
- [ ] **6.4.3** Rewrite `app/news/index.tsx`
- [ ] **6.4.4** Rewrite `app/news/[id].tsx`
- [ ] **6.4.5** Rewrite `app/pdf-viewer.tsx`
- [ ] **6.4.6** Rewrite `app/programs/index.tsx`
- [ ] **6.4.7** Rewrite `app/programs/[program].tsx`
- [ ] **6.4.8** Rewrite `app/rotary-clubs/index.tsx`
- [ ] **6.4.9** Rewrite `app/rotary-clubs/[section].tsx`

### Phase 7: Cleanup

- [ ] **7.1** Delete `components/` folder
- [ ] **7.2** Delete `hooks/` folder
- [ ] **7.3** Delete `utils/` folder
- [ ] **7.4** Delete `types/` folder
- [ ] **7.5** Delete `data/` folder
- [ ] **7.6** Delete `constants/` folder
- [ ] **7.7** Run `npx expo lint` and fix all issues
- [ ] **7.8** Run `npx tsc --noEmit` and fix all TypeScript errors
- [ ] **7.9** Test the app on iOS simulator
- [ ] **7.10** Test the app on Android emulator

### Phase 8: Final Verification

Run through all verification steps in the Verification section below.

---

## Verification Steps

After implementation, verify:

1. **Build Check**
   ```bash
   npx expo prebuild --clean
   npx expo run:ios
   npx expo run:android
   ```

2. **Feature Testing**
   - [ ] Home screen loads with all navigation cards
   - [ ] Tab navigation works (all 5 tabs)
   - [ ] Inbound students list loads with country grouping
   - [ ] Outbound students list loads with country grouping
   - [ ] Rebound students list loads
   - [ ] Contact sections show all 4 categories
   - [ ] Contact modal opens with full details
   - [ ] Calendar loads events from Google Calendar
   - [ ] Calendar date selection shows events
   - [ ] Camps & Tours loads from CSV
   - [ ] Camps filtering works (availability, timing, country)
   - [ ] News list displays
   - [ ] News detail with PDF opens correctly
   - [ ] PDF viewer works
   - [ ] Emergency contacts display
   - [ ] Settings screen works
   - [ ] Light/Dark theme works
   - [ ] Haptic feedback works on iOS
   - [ ] All deep links work (phone, email, WhatsApp, social media)

3. **Performance Check**
   - No warning about missing keys
   - No console errors
   - Smooth scrolling in lists
   - Fast screen transitions

---

## Critical Files Reference

Current files that need to be analyzed during migration:

| Current File | Purpose | New Location |
|--------------|---------|--------------|
| `app/camps-tours.tsx` (36KB) | Largest file, needs decomposition | `features/camps-tours/` |
| `constants/theme.ts` | Theme colors | `core/theme/colors.ts` |
| `utils/eventUtils.ts` | Has exposed API key | `features/calendar/api/` + `core/config/env.ts` |
| `components/students/StudentsList.tsx` | Good pattern example | `features/students/components/` |
| `data/contacts/*.ts` | Contact data | `features/contacts/data/` |
| `types/*.ts` | All type definitions | Feature-specific `types.ts` files |
