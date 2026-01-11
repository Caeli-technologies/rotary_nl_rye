/**
 * News feature - Public API
 *
 * This module provides components and hooks for displaying news items,
 * including both PDF documents and text-based articles.
 */

// Components
export { NewsCard, NewsDetail, NewsList } from "./components";

// Hooks
export {
  useNews,
  useNewsItem,
  useSearchNews,
  useNewsFilteredByType,
} from "./hooks";

// Data
export {
  newsItems,
  getNewsItemById,
  getPdfNewsItems,
  getTextNewsItems,
} from "./data";

// Types
export type { NewsItem, NewsTextBlock, RawNewsItem } from "./types";

// Utilities
export { convertRawNewsItem } from "./types";
