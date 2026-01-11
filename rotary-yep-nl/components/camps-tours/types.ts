/**
 * Types for the Camps & Tours feature
 */

import type { Colors } from "@/constants/theme";

/**
 * Data structure for a single camp/tour from the CSV
 */
export interface CampTourData {
	startDate: string; // Format: DD/MM/YYYY
	endDate: string; // Format: DD/MM/YYYY
	title: string;
	hostCountryCode: string; // ISO country code(s), may contain "/" for multiple
	hostCountry: string; // Country name(s), may contain "/" for multiple
	hostDistrict: string;
	ageMin: string;
	ageMax: string;
	contribution: string;
	invitation: string; // URL to invitation PDF
	full: string; // Non-empty if camp is full
}

/**
 * Row from CSV parsing - typed array of strings
 */
export type CsvRow = [
	string, // startDate
	string, // endDate
	string, // title
	string, // hostCountryCode
	string, // hostCountry
	string, // hostDistrict
	string, // ageMin
	string, // ageMax
	string, // contribution
	string, // invitation
	string, // full
];

/**
 * Filter state for camps listing
 */
export interface FilterState {
	availability: "alle" | "niet-vol" | "vol";
	timing: "alle" | "toekomstig" | "afgelopen";
	country: string;
}

/**
 * Country with its ISO code for filtering
 */
export interface CountryWithCode {
	country: string;
	code: string;
}

/**
 * Theme colors type alias for convenience
 */
export type ThemeColors = typeof Colors.light;

/**
 * Props for filter chip components
 */
export interface FilterChipProps {
	filters: FilterState;
	setFilters: React.Dispatch<React.SetStateAction<FilterState>>;
	themeColors: ThemeColors;
}

/**
 * Props for the TravelCard component
 */
export interface TravelCardProps extends CampTourData {
	themeColors: ThemeColors;
}

/**
 * Props for the CountryModal component
 */
export interface CountryModalProps {
	visible: boolean;
	onClose: () => void;
	countries: CountryWithCode[];
	selectedCountry: string;
	onSelect: (country: string) => void;
	themeColors: ThemeColors;
}

/**
 * Data loading state
 */
export interface CampsDataState {
	data: CampTourData[];
	loading: boolean;
	error: string | null;
	refreshing: boolean;
}
