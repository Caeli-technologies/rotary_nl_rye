/**
 * News list component for displaying all news items
 */

import { FlatList, View, StyleSheet } from 'react-native';
import { useTheme } from '@/core/theme';
import { spacing } from '@/core/theme/spacing';
import { EmptyState } from '@/shared/components/feedback/EmptyState';
import { NewsCard } from './NewsCard';
import type { NewsItem } from '../types';

interface NewsListProps {
  items: NewsItem[];
  onItemPress: (item: NewsItem) => void;
  ListHeaderComponent?: React.ComponentType | React.ReactElement | null;
  refreshing?: boolean;
  onRefresh?: () => void;
}

export function NewsList({
  items,
  onItemPress,
  ListHeaderComponent,
  refreshing,
  onRefresh,
}: NewsListProps) {
  const { colors } = useTheme();

  if (items.length === 0) {
    return (
      <EmptyState
        icon="newspaper-outline"
        title="No News"
        message="There are no news items to display at this time."
      />
    );
  }

  return (
    <FlatList
      data={items}
      keyExtractor={(item) => String(item.id)}
      renderItem={({ item }) => (
        <NewsCard item={item} onPress={() => onItemPress(item)} />
      )}
      contentContainerStyle={styles.listContent}
      showsVerticalScrollIndicator={false}
      ListHeaderComponent={ListHeaderComponent}
      ListFooterComponent={<View style={{ height: spacing.lg }} />}
      refreshing={refreshing}
      onRefresh={onRefresh}
      style={{ backgroundColor: colors.background }}
    />
  );
}

const styles = StyleSheet.create({
  listContent: {
    paddingVertical: spacing.sm,
  },
});
