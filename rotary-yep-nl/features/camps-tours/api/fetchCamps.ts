/**
 * API for fetching camps and tours data from CSV
 */

import { parse } from "csv-parse/sync";
import { env } from "@/core/config/env";
import type { Camp, CountryWithCode } from "../types";

interface FetchCampsResult {
	camps: Camp[];
	countries: CountryWithCode[];
}

/**
 * Parse date string from DD/MM/YYYY format
 */
function parseDateParts(dateStr: string): Date | null {
	const parts = dateStr.split("/");
	if (parts.length !== 3) return null;

	const day = parseInt(parts[0], 10);
	const month = parseInt(parts[1], 10) - 1; // Month is 0-indexed
	const year = parseInt(parts[2], 10);

	return new Date(year, month, day);
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
 */
function extractCountries(camps: Camp[]): CountryWithCode[] {
	const countriesMap = new Map<string, string>();

	camps.forEach((camp) => {
		const countryList = camp.hostCountry.split("/");
		const codeList = camp.hostCountryCode.split("/");

		countryList.forEach((country, index) => {
			const trimmedCountry = country.trim();
			const code = codeList[index]?.trim();

			if (trimmedCountry && code) {
				countriesMap.set(trimmedCountry, code);
			}
		});
	});

	return Array.from(countriesMap.entries())
		.map(([country, code]) => ({ country, code }))
		.sort((a, b) => a.country.localeCompare(b.country));
}

/**
 * Fetch and parse camps data from CSV
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

	// Parse CSV with semicolon delimiter
	const parsedData = parse(csvText, {
		delimiter: ";",
		skip_empty_lines: true,
	}) as string[][];

	// Skip header row and convert to Camp objects
	const camps: Camp[] = parsedData.slice(1).map((row, index) => ({
		id: `camp-${index}-${row[2] || "unknown"}`,
		startDate: row[0]?.toString() || "",
		endDate: row[1]?.toString() || "",
		title: row[2]?.toString() || "",
		hostCountryCode: row[3]?.toString() || "",
		hostCountry: row[4]?.toString() || "",
		hostDistrict: row[5]?.toString() || "",
		ageMin: row[6]?.toString() || "",
		ageMax: row[7]?.toString() || "",
		contribution: row[8]?.toString() || "",
		invitation: row[9]?.toString() || "",
		isFull: Boolean(row[10] && row[10].toString().trim() !== ""),
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
