/**
 * File-based caching utility using expo-file-system
 * Provides persistent caching with TTL support
 */

import * as FileSystem from 'expo-file-system';

const CACHE_DIR = FileSystem.cacheDirectory + 'data/';

interface CacheEntry<T> {
  data: T;
  timestamp: number;
  expiresAt: number;
}

/**
 * Get cached data by key
 * Returns null if not found or expired
 */
export async function getCached<T>(key: string): Promise<T | null> {
  try {
    const path = CACHE_DIR + key + '.json';
    const info = await FileSystem.getInfoAsync(path);

    if (!info.exists) {
      return null;
    }

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

/**
 * Set cache data with TTL
 * @param key - Cache key
 * @param data - Data to cache
 * @param ttlMinutes - Time to live in minutes (default: 10)
 */
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

/**
 * Clear cache by key or all cache
 * @param key - Optional key to clear specific cache
 */
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

/**
 * Check if cache exists and is valid
 */
export async function isCacheValid(key: string): Promise<boolean> {
  try {
    const path = CACHE_DIR + key + '.json';
    const info = await FileSystem.getInfoAsync(path);

    if (!info.exists) {
      return false;
    }

    const content = await FileSystem.readAsStringAsync(path);
    const entry: CacheEntry<unknown> = JSON.parse(content);

    return Date.now() <= entry.expiresAt;
  } catch {
    return false;
  }
}

/**
 * Get cache age in milliseconds
 * Returns null if cache doesn't exist
 */
export async function getCacheAge(key: string): Promise<number | null> {
  try {
    const path = CACHE_DIR + key + '.json';
    const info = await FileSystem.getInfoAsync(path);

    if (!info.exists) {
      return null;
    }

    const content = await FileSystem.readAsStringAsync(path);
    const entry: CacheEntry<unknown> = JSON.parse(content);

    return Date.now() - entry.timestamp;
  } catch {
    return null;
  }
}
