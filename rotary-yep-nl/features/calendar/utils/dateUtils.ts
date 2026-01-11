/**
 * Calendar date utilities
 */

import type {
	CalendarEvent,
	EventsData,
	EventWithOriginalData,
} from "../types";

/**
 * Ensures a value is a Date object
 */
function ensureDate(date: Date | string | number): Date {
	if (date instanceof Date) {
		return date;
	}
	return new Date(date);
}

/**
 * Check if two dates are the same day
 */
export function isSameDay(date1: Date | string, date2: Date | string): boolean {
	const d1 = ensureDate(date1);
	const d2 = ensureDate(date2);
	return (
		d1.getFullYear() === d2.getFullYear() &&
		d1.getMonth() === d2.getMonth() &&
		d1.getDate() === d2.getDate()
	);
}

/**
 * Format a date as YYYY-MM-DD
 */
export function formatDateKey(date: Date | string): string {
	const d = ensureDate(date);
	return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}

/**
 * Gets events for a specific day
 */
export function getEventsForDay(
	eventsData: EventsData,
	date: Date,
): CalendarEvent[] {
	const dateKey = formatDateKey(date);
	return eventsData[dateKey] || [];
}

/**
 * Formats a date for display (e.g., "Monday, January 1, 2024")
 */
export function formatEventDate(date: Date): string {
	return new Intl.DateTimeFormat("en-US", {
		weekday: "long",
		year: "numeric",
		month: "long",
		day: "numeric",
	}).format(date);
}

/**
 * Formats a time for display (e.g., "2:30 PM")
 * If endDate is provided, formats as a time range (e.g., "2:30 PM - 4:00 PM")
 */
export function formatEventTime(startDate: Date | string, endDate?: Date | string): string {
	const formatter = new Intl.DateTimeFormat("en-US", {
		hour: "numeric",
		minute: "2-digit",
		hour12: true,
	});

	const start = ensureDate(startDate);
	const startTime = formatter.format(start);

	if (endDate) {
		const end = ensureDate(endDate);
		const endTime = formatter.format(end);
		return `${startTime} - ${endTime}`;
	}

	return startTime;
}

/**
 * Check if an event spans multiple days
 */
export function isMultiDayEvent(event: CalendarEvent): boolean {
	return !isSameDay(event.start.dateTime, event.end.dateTime);
}

/**
 * Extracts URLs from event description
 */
export function extractLinksFromDescription(description: string): string[] {
	const urlRegex = /(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+/g;
	return description.match(urlRegex) || [];
}

/**
 * Checks if an event is an all-day event
 */
export function isAllDayEvent(event: CalendarEvent): boolean {
	const eventWithOriginal = event as EventWithOriginalData;
	return !!(
		eventWithOriginal._originalStart?.date &&
		!eventWithOriginal._originalStart?.dateTime
	);
}

/**
 * Gets the display end date for an event
 */
export function getDisplayEndDate(event: CalendarEvent): Date {
	const eventWithOriginal = event as EventWithOriginalData;
	const endDate = ensureDate(event.end.dateTime);

	if (
		eventWithOriginal._originalEnd?.date &&
		!eventWithOriginal._originalEnd?.dateTime
	) {
		// For date-only events, subtract 1 day from end date for display
		return new Date(endDate.getTime() - 24 * 60 * 60 * 1000);
	}

	return endDate;
}
