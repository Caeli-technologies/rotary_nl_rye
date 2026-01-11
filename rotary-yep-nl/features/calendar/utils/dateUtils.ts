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
function ensureDate(date: Date | string | number | undefined | null): Date {
	if (!date) {
		return new Date();
	}
	if (date instanceof Date) {
		return date;
	}
	return new Date(date);
}

/**
 * Check if two dates are the same day
 */
export function isSameDay(
	date1: Date | string | undefined | null,
	date2: Date | string | undefined | null,
): boolean {
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
export function formatDateKey(date: Date | string | undefined | null): string {
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
export function formatEventDate(
	date: Date | string | undefined | null,
): string {
	const d = ensureDate(date);
	return new Intl.DateTimeFormat("en-US", {
		weekday: "long",
		year: "numeric",
		month: "long",
		day: "numeric",
	}).format(d);
}

/**
 * Formats a time for display (e.g., "2:30 PM")
 * If endDate is provided, formats as a time range (e.g., "2:30 PM - 4:00 PM")
 */
export function formatEventTime(
	startDate: Date | string | undefined | null,
	endDate?: Date | string | undefined | null,
): string {
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
 *
 * For all-day events: end date is EXCLUSIVE
 *   start="2015-11-13", end="2015-11-16" → 3 days (13, 14, 15) = multi-day
 *   start="2015-11-13", end="2015-11-14" → 1 day (13 only) = NOT multi-day
 *
 * For timed events: compares actual start/end days
 */
export function isMultiDayEvent(event: CalendarEvent): boolean {
	if (!event?.start?.dateTime || !event?.end?.dateTime) {
		return false;
	}

	const eventWithOriginal = event as EventWithOriginalData;
	const isAllDay =
		eventWithOriginal._originalStart?.date &&
		!eventWithOriginal._originalStart?.dateTime;

	const startDate = ensureDate(event.start.dateTime);
	const endDate = ensureDate(event.end.dateTime);

	if (isAllDay) {
		// For all-day events, end is exclusive, so subtract 1 day to get actual last day
		const actualEndDate = new Date(endDate.getTime() - 24 * 60 * 60 * 1000);
		return !isSameDay(startDate, actualEndDate);
	}

	return !isSameDay(startDate, endDate);
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
 * For all-day events, the API end date is EXCLUSIVE, so we subtract 1 day
 * to show the actual last day of the event
 */
export function getDisplayEndDate(event: CalendarEvent): Date {
	const endDate = ensureDate(event.end?.dateTime);
	const eventWithOriginal = event as EventWithOriginalData;
	const isAllDay =
		eventWithOriginal._originalStart?.date &&
		!eventWithOriginal._originalStart?.dateTime;

	if (isAllDay) {
		// For all-day events, subtract 1 day to get the actual last day
		return new Date(endDate.getTime() - 24 * 60 * 60 * 1000);
	}

	return endDate;
}
