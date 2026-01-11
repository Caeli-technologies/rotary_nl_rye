/**
 * News screen route
 * Thin wrapper using the news feature module
 */

import { useCallback } from "react";
import { SafeAreaView } from "react-native-safe-area-context";
import { router } from "expo-router";
import { useTheme } from "@/core/theme";
import { LoadingState, ErrorState } from "@/shared/components/feedback";
import { NewsList, useNews, type NewsItem } from "@/features/news";

export default function NewsScreen() {
  const { colors } = useTheme();
  const { items, loading, error, refresh } = useNews();

  const handleItemPress = useCallback((item: NewsItem) => {
    router.push({
      pathname: "/news/[id]" as const,
      params: { id: String(item.id) },
    } as never);
  }, []);

  if (loading && items.length === 0) {
    return (
      <SafeAreaView style={{ flex: 1, backgroundColor: colors.background }} edges={[]}>
        <LoadingState message="Nieuws laden..." />
      </SafeAreaView>
    );
  }

  if (error && items.length === 0) {
    return (
      <SafeAreaView style={{ flex: 1, backgroundColor: colors.background }} edges={[]}>
        <ErrorState message={error} onRetry={refresh} />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: colors.background }} edges={[]}>
      <NewsList
        items={items}
        onItemPress={handleItemPress}
        refreshing={loading}
        onRefresh={refresh}
      />
    </SafeAreaView>
  );
}
