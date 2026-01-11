/**
 * News data
 * Loaded from the existing JSON file
 */

import type { NewsItem, RawNewsItem } from "../types";
import { convertRawNewsItem } from "../types";

// TODO: news is comming from an url not an asset file!
// https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/news/news.js

// Import the existing JSON data
import newsData from "@/assets/website-files/news.json";

interface NewsDataFormat {
  news: RawNewsItem[];
}

const data = newsData as NewsDataFormat;

/**
 * Convert all news items from JSON to normalized format
 */
function loadNewsItems(): NewsItem[] {
  return data.news.map(convertRawNewsItem);
}

/**
 * All news items
 */
export const newsItems: NewsItem[] = loadNewsItems();

/**
 * Get a single news item by ID
 */
export function getNewsItemById(id: number): NewsItem | undefined {
  return newsItems.find((item) => item.id === id);
}

/**
 * Get news items that are PDFs
 */
export function getPdfNewsItems(): NewsItem[] {
  return newsItems.filter((item) => item.isPdf);
}

/**
 * Get news items with text content
 */
export function getTextNewsItems(): NewsItem[] {
  return newsItems.filter((item) => !item.isPdf && item.textContent);
}
