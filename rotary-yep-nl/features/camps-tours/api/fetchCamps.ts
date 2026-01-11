/**
 * API for fetching camps and tours data from CSV
 */

import { env } from "@/core/config/env";
import { getCountryName } from "@/shared/utils/flags";
import type { Camp, CountryWithCode } from "../types";

interface FetchCampsResult {
  camps: Camp[];
  countries: CountryWithCode[];
}

/**
 * Quote-aware CSV parser for handling comma delimiters with quoted fields
 * Handles fields that contain commas within quotes (e.g., "1890,1940")
 */
function parseCSVWithQuotes(text: string): string[][] {
  const lines = text.split(/\r?\n/);
  const result: string[][] = [];

  for (const line of lines) {
    if (line.trim() === "") continue;

    const row: string[] = [];
    let current = "";
    let inQuotes = false;

    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        inQuotes = !inQuotes;
      } else if (char === "," && !inQuotes) {
        row.push(current.trim());
        current = "";
      } else {
        current += char;
      }
    }
    row.push(current.trim());
    result.push(row);
  }

  return result;
}

/**
 * Parse date string from DD/MM/YYYY or DD-MM-YYYY format
 */
function parseDateParts(dateStr: string): Date | null {
  // Support both DD/MM/YYYY and DD-MM-YYYY
  const parts = dateStr.split(/[/\-]/);
  if (parts.length !== 3) return null;

  const day = parseInt(parts[0], 10);
  const month = parseInt(parts[1], 10) - 1; // Month is 0-indexed
  const year = parseInt(parts[2], 10);

  return new Date(year, month, day);
}

/**
 * Normalize date string to DD/MM/YYYY format
 */
function normalizeDateString(dateStr: string): string {
  const parts = dateStr.split(/[/\-]/);
  if (parts.length !== 3) return dateStr;
  return `${parts[0].padStart(2, "0")}/${parts[1].padStart(2, "0")}/${parts[2]}`;
}

/**
 * Sort camps chronologically by start date
 */
function sortCampsByDate(camps: Camp[]): Camp[] {
  return [...camps].sort((a, b) => {
    const dateA = parseDateParts(a.startDate);
    const dateB = parseDateParts(b.startDate);

    if (!dateA || !dateB) return 0;
    return dateA.getTime() - dateB.getTime();
  });
}

/**
 * Extract unique countries with their codes from camps data
 * Uses getCountryName to resolve country names from codes
 */
function extractCountries(camps: Camp[]): CountryWithCode[] {
  const countriesMap = new Map<string, string>();

  camps.forEach((camp) => {
    // Country codes can be space or comma separated
    const codes = camp.hostCountryCode
      .split(/[\s,]+/)
      .map((c) => c.trim().toLowerCase())
      .filter(Boolean);

    codes.forEach((code) => {
      if (!countriesMap.has(code)) {
        countriesMap.set(code, getCountryName(code));
      }
    });
  });

  return Array.from(countriesMap.entries())
    .map(([code, country]) => ({ code, country }))
    .sort((a, b) => a.country.localeCompare(b.country));
}

/**
 * Fetch and parse camps data from CSV
 *
 * New CSV column mapping (0-indexed):
 * [0] startDate, [1] endDate, [2] title, [3] countryCode,
 * [4] district, [5] ageMin, [6] ageMax, [7] currency,
 * [8] cost, [9] isFull, [10] invitation
 */
export async function fetchCamps(): Promise<FetchCampsResult> {
  const response = await fetch(env.campsCsvUrl, {
    headers: {
      "Cache-Control": "no-cache",
    },
  });

  if (!response.ok) {
    throw new Error("Kan CSV-gegevens niet laden");
  }

  const csvText = await response.text();

  // Parse CSV with quote-aware parser for comma delimiter
  const parsedData = parseCSVWithQuotes(csvText);

  // Skip header row and convert to Camp objects
  const camps: Camp[] = parsedData.slice(1).map((row, index) => ({
    id: `camp-${index}-${row[2] || "unknown"}`,
    startDate: normalizeDateString(row[0] || ""),
    endDate: normalizeDateString(row[1] || ""),
    title: row[2]?.trim() || "",
    hostCountryCode: row[3]?.trim().toLowerCase() || "",
    hostDistrict: row[4]?.trim() || "",
    ageMin: row[5]?.trim() || "",
    ageMax: row[6]?.trim() || "",
    currency: row[7]?.trim().toUpperCase() || "EUR",
    contribution: row[8]?.trim() || "",
    invitation: row[10]?.trim() || "",
    isFull: Boolean(row[9] && row[9].trim().toLowerCase() === "x"),
  }));

  // Sort camps chronologically
  const sortedCamps = sortCampsByDate(camps);

  // Extract unique countries
  const countries = extractCountries(camps);

  return {
    camps: sortedCamps,
    countries,
  };
}

/**
 * Check if a camp is in the past
 */
export function isCampPast(camp: Camp): boolean {
  const endDate = parseDateParts(camp.endDate);
  if (!endDate) return false;

  const today = new Date();
  today.setHours(0, 0, 0, 0);

  return endDate < today;
}
