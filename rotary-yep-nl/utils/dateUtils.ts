/**
 * Shared date utility functions for DD/MM/YYYY format parsing
 * Used by camps-tours and other components that work with European date formats
 */

/**
 * Parses a date string in DD/MM/YYYY format
 * @param dateStr - Date string in DD/MM/YYYY format
 * @returns Date object or null if parsing fails
 */
export function parseDateFromDDMMYYYY(dateStr: string): Date | null {
	if (!dateStr) return null;

	const parts = dateStr.split("/");
	if (parts.length !== 3) return null;

	const day = parseInt(parts[0], 10);
	const month = parseInt(parts[1], 10) - 1; // Month is 0-indexed
	const year = parseInt(parts[2], 10);

	if (isNaN(day) || isNaN(month) || isNaN(year)) return null;

	return new Date(year, month, day);
}

/**
 * Checks if a date string (DD/MM/YYYY) represents a date in the past
 * @param dateStr - Date string in DD/MM/YYYY format
 * @returns true if the date is before today
 */
export function isPastDate(dateStr: string): boolean {
	const date = parseDateFromDDMMYYYY(dateStr);
	if (!date) return false;

	const today = new Date();
	today.setHours(0, 0, 0, 0);
	return date < today;
}

/**
 * Compares two date strings in DD/MM/YYYY format for sorting
 * @param a - First date string
 * @param b - Second date string
 * @returns Negative if a < b, positive if a > b, zero if equal
 */
export function compareDatesDD_MM_YYYY(a: string, b: string): number {
	const dateA = parseDateFromDDMMYYYY(a);
	const dateB = parseDateFromDDMMYYYY(b);

	if (!dateA && !dateB) return 0;
	if (!dateA) return 1;
	if (!dateB) return -1;

	return dateA.getTime() - dateB.getTime();
}

/**
 * Sorts an array of items by a date field in DD/MM/YYYY format
 * @param items - Array of items to sort
 * @param getDate - Function to extract date string from item
 * @param ascending - Sort order (default: true for oldest first)
 * @returns Sorted array (new array, original is not mutated)
 */
export function sortByDateDDMMYYYY<T>(
	items: T[],
	getDate: (item: T) => string,
	ascending = true,
): T[] {
	return [...items].sort((a, b) => {
		const comparison = compareDatesDD_MM_YYYY(getDate(a), getDate(b));
		return ascending ? comparison : -comparison;
	});
}

/**
 * Formats a Date object to DD/MM/YYYY string
 * @param date - Date object to format
 * @returns Formatted date string
 */
export function formatToDDMMYYYY(date: Date): string {
	const day = String(date.getDate()).padStart(2, "0");
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const year = date.getFullYear();
	return `${day}/${month}/${year}`;
}

/**
 * Checks if two date strings (DD/MM/YYYY) represent the same day
 * @param dateStr1 - First date string
 * @param dateStr2 - Second date string
 * @returns true if both dates are the same day
 */
export function isSameDayDDMMYYYY(dateStr1: string, dateStr2: string): boolean {
	const date1 = parseDateFromDDMMYYYY(dateStr1);
	const date2 = parseDateFromDDMMYYYY(dateStr2);

	if (!date1 || !date2) return false;

	return (
		date1.getFullYear() === date2.getFullYear() &&
		date1.getMonth() === date2.getMonth() &&
		date1.getDate() === date2.getDate()
	);
}
