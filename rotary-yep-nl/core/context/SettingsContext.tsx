import { createContext, useContext, useState, useEffect, useCallback, type ReactNode } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface SettingsContextValue {
  // App review state
  hasRequestedReview: boolean;
  appOpenCount: number;

  // Actions
  incrementAppOpen: () => Promise<void>;
  setReviewRequested: () => Promise<void>;

  // Settings state
  isLoading: boolean;
}

const SettingsContext = createContext<SettingsContextValue | null>(null);

const STORAGE_KEYS = {
  REVIEW_REQUESTED: 'settings:reviewRequested',
  APP_OPEN_COUNT: 'settings:appOpenCount',
} as const;

interface SettingsProviderProps {
  children: ReactNode;
}

export function SettingsProvider({ children }: SettingsProviderProps) {
  const [hasRequestedReview, setHasRequestedReview] = useState(false);
  const [appOpenCount, setAppOpenCount] = useState(0);
  const [isLoading, setIsLoading] = useState(true);

  // Load settings from storage on mount
  useEffect(() => {
    const loadSettings = async () => {
      try {
        const [reviewRequested, openCount] = await Promise.all([
          AsyncStorage.getItem(STORAGE_KEYS.REVIEW_REQUESTED),
          AsyncStorage.getItem(STORAGE_KEYS.APP_OPEN_COUNT),
        ]);

        if (reviewRequested !== null) {
          setHasRequestedReview(reviewRequested === 'true');
        }
        if (openCount !== null) {
          setAppOpenCount(parseInt(openCount, 10));
        }
      } catch {
        // Ignore errors, use default values
      } finally {
        setIsLoading(false);
      }
    };

    loadSettings();
  }, []);

  const incrementAppOpen = useCallback(async () => {
    const newCount = appOpenCount + 1;
    setAppOpenCount(newCount);
    try {
      await AsyncStorage.setItem(STORAGE_KEYS.APP_OPEN_COUNT, String(newCount));
    } catch {
      // Ignore storage errors
    }
  }, [appOpenCount]);

  const setReviewRequested = useCallback(async () => {
    setHasRequestedReview(true);
    try {
      await AsyncStorage.setItem(STORAGE_KEYS.REVIEW_REQUESTED, 'true');
    } catch {
      // Ignore storage errors
    }
  }, []);

  return (
    <SettingsContext.Provider
      value={{
        hasRequestedReview,
        appOpenCount,
        incrementAppOpen,
        setReviewRequested,
        isLoading,
      }}
    >
      {children}
    </SettingsContext.Provider>
  );
}

export function useSettings(): SettingsContextValue {
  const context = useContext(SettingsContext);
  if (!context) {
    throw new Error('useSettings must be used within SettingsProvider');
  }
  return context;
}
