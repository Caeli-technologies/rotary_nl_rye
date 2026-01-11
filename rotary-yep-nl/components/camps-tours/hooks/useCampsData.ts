import { useState, useCallback, useEffect } from "react";
import { readString } from "react-native-csv";
import { parseDateFromDDMMYYYY, compareDatesDD_MM_YYYY } from "@/utils/dateUtils";
import type {
	CampTourData,
	FilterState,
	CountryWithCode,
	CsvRow,
} from "../types";

const CSV_URL =
	"https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv";

/**
 * Hook for fetching and managing camps/tours data
 */
export function useCampsData() {
	const [data, setData] = useState<CampTourData[]>([]);
	const [filteredData, setFilteredData] = useState<CampTourData[]>([]);
	const [loading, setLoading] = useState(true);
	const [refreshing, setRefreshing] = useState(false);
	const [error, setError] = useState<string | null>(null);
	const [availableCountries, setAvailableCountries] = useState<
		CountryWithCode[]
	>([]);

	const [filters, setFilters] = useState<FilterState>({
		availability: "alle",
		timing: "alle",
		country: "",
	});

	/**
	 * Parse CSV row to CampTourData object
	 */
	const parseRow = (row: CsvRow): CampTourData => ({
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
		full: row[10]?.toString() || "",
	});

	/**
	 * Sort camps by start date (chronological)
	 */
	const sortByStartDate = (camps: CampTourData[]): CampTourData[] => {
		return [...camps].sort((a, b) =>
			compareDatesDD_MM_YYYY(a.startDate, b.startDate),
		);
	};

	/**
	 * Extract unique countries with their codes from data
	 */
	const extractCountries = (camps: CampTourData[]): CountryWithCode[] => {
		const countriesMap = new Map<string, string>();

		camps.forEach((item) => {
			const countryList = item.hostCountry.split("/");
			const countryCodeList = item.hostCountryCode.split("/");

			countryList.forEach((country, index) => {
				const trimmedCountry = country.trim();
				const countryCode = countryCodeList[index]?.trim();

				if (trimmedCountry && countryCode) {
					countriesMap.set(trimmedCountry, countryCode);
				}
			});
		});

		return Array.from(countriesMap.entries())
			.map(([country, code]) => ({ country, code }))
			.sort((a, b) => a.country.localeCompare(b.country));
	};

	/**
	 * Fetch CSV data from server
	 */
	const fetchData = useCallback(async (isRefresh = false) => {
		try {
			if (isRefresh) {
				setRefreshing(true);
			} else {
				setLoading(true);
			}
			setError(null);

			const response = await fetch(CSV_URL);

			if (!response.ok) {
				throw new Error("Kan CSV-gegevens niet laden");
			}

			const csvText = await response.text();

			const parsedData = readString(csvText, {
				delimiter: ";",
				skipEmptyLines: true,
			});

			// Skip header row and convert to objects
			const formattedData: CampTourData[] = parsedData.data
				.slice(1)
				.map((row) => parseRow(row as CsvRow));

			const sortedData = sortByStartDate(formattedData);
			const countries = extractCountries(formattedData);

			setData(sortedData);
			setFilteredData(sortedData);
			setAvailableCountries(countries);
		} catch (err) {
			const error = err as Error;
			console.error("Error fetching CSV data:", error);

			// Provide specific error messages
			if (error.name === "AbortError") {
				setError("Verzoek time-out. Controleer je internetverbinding.");
			} else if (error.message.includes("network")) {
				setError("Netwerkfout. Controleer je internetverbinding.");
			} else {
				setError("Kan zomerkampen-gegevens niet laden. Probeer opnieuw.");
			}
		} finally {
			setLoading(false);
			setRefreshing(false);
		}
	}, []);

	/**
	 * Apply current filters to data
	 */
	const applyFilters = useCallback(() => {
		let filtered = [...data];

		// Availability filter
		if (filters.availability === "niet-vol") {
			filtered = filtered.filter(
				(item) => !item.full || item.full.trim() === "",
			);
		} else if (filters.availability === "vol") {
			filtered = filtered.filter(
				(item) => item.full && item.full.trim() !== "",
			);
		}

		// Timing filter
		if (filters.timing === "toekomstig" || filters.timing === "afgelopen") {
			const today = new Date();
			today.setHours(0, 0, 0, 0);

			filtered = filtered.filter((item) => {
				const endDate = parseDateFromDDMMYYYY(item.endDate);
				if (!endDate) return filters.timing === "toekomstig";

				const isFuture = endDate >= today;
				return filters.timing === "toekomstig" ? isFuture : !isFuture;
			});
		}

		// Country filter
		if (filters.country) {
			filtered = filtered.filter((item) =>
				item.hostCountry.toLowerCase().includes(filters.country.toLowerCase()),
			);
		}

		setFilteredData(sortByStartDate(filtered));
	}, [filters, data]);

	/**
	 * Clear all filters
	 */
	const clearFilters = useCallback(() => {
		setFilters({
			availability: "alle",
			timing: "alle",
			country: "",
		});
	}, []);

	/**
	 * Check if any filter is active
	 */
	const hasActiveFilters =
		filters.availability !== "alle" ||
		filters.timing !== "alle" ||
		filters.country !== "";

	// Fetch data on mount
	useEffect(() => {
		fetchData();
	}, [fetchData]);

	// Apply filters when they change
	useEffect(() => {
		if (data.length > 0) {
			applyFilters();
		}
	}, [filters, data, applyFilters]);

	// When filters are cleared, reset to full data
	useEffect(() => {
		if (!hasActiveFilters && data.length > 0) {
			setFilteredData(data);
		}
	}, [hasActiveFilters, data]);

	return {
		// Data
		data: filteredData,
		allData: data,
		availableCountries,

		// State
		loading,
		refreshing,
		error,

		// Filters
		filters,
		setFilters,
		hasActiveFilters,
		clearFilters,

		// Actions
		refresh: () => fetchData(true),
		retry: () => fetchData(false),
	};
}
