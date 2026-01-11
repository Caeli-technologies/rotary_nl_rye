/**
 * News screen route
 * Thin wrapper using the news feature module
 */

import { SafeAreaView } from "react-native-safe-area-context";
import { useTheme } from "@/core/theme";
import { NewsList } from "@/features/news";

export default function NewsScreen() {
  const { colors } = useTheme();

  return (
    <SafeAreaView
      style={{ flex: 1, backgroundColor: colors.background }}
      edges={[]}
    >
      <NewsList />
    </SafeAreaView>
  );
}
