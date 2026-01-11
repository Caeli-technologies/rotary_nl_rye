/**
 * News hooks for accessing and filtering news items
 */

import { useMemo } from 'react';
import { newsItems, getNewsItemById } from '../data';
import type { NewsItem } from '../types';

/**
 * Get all news items
 */
export function useNews() {
  return useMemo(
    () => ({
      items: newsItems,
      count: newsItems.length,
    }),
    []
  );
}

/**
 * Get a single news item by ID
 */
export function useNewsItem(id: number): NewsItem | undefined {
  return useMemo(() => getNewsItemById(id), [id]);
}

/**
 * Search news items by title or description
 */
export function useSearchNews(query: string): NewsItem[] {
  return useMemo(() => {
    if (!query.trim()) return newsItems;

    const lowerQuery = query.toLowerCase();
    return newsItems.filter(
      (item) =>
        item.title.toLowerCase().includes(lowerQuery) ||
        item.description.toLowerCase().includes(lowerQuery)
    );
  }, [query]);
}

/**
 * Get news items filtered by type (PDF or text)
 */
export function useNewsFilteredByType(type: 'all' | 'pdf' | 'text'): NewsItem[] {
  return useMemo(() => {
    switch (type) {
      case 'pdf':
        return newsItems.filter((item) => item.isPdf);
      case 'text':
        return newsItems.filter((item) => !item.isPdf);
      default:
        return newsItems;
    }
  }, [type]);
}
