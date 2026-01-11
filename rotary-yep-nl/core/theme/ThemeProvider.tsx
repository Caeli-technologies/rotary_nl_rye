import { createContext, useContext, type ReactNode } from "react";
import { useColorScheme } from "react-native";
import { colors, type ThemeColors, type ColorScheme } from "./colors";

interface ThemeContextValue {
  colors: ThemeColors;
  isDark: boolean;
  colorScheme: ColorScheme;
}

const ThemeContext = createContext<ThemeContextValue | null>(null);

interface ThemeProviderProps {
  children: ReactNode;
}

export function ThemeProvider({ children }: ThemeProviderProps) {
  const systemColorScheme = useColorScheme();
  const colorScheme: ColorScheme = systemColorScheme ?? "light";
  const isDark = colorScheme === "dark";
  const themeColors = isDark ? colors.dark : colors.light;

  return (
    <ThemeContext.Provider value={{ colors: themeColors, isDark, colorScheme }}>
      {children}
    </ThemeContext.Provider>
  );
}

export function useTheme(): ThemeContextValue {
  const context = useContext(ThemeContext);
  if (!context) {
    throw new Error("useTheme must be used within ThemeProvider");
  }
  return context;
}
