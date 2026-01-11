/**
 * Calendar API for fetching events from Google Calendar
 */

import { fetch } from "expo/fetch";
import { env } from "@/core/config/env";
import type {
	CalendarEvent,
	EventsData,
	EventWithOriginalData,
	GoogleCalendarDateTime,
	GoogleCalendarEvent,
	GoogleCalendarResponse,
} from "../types";

const TIMEOUT = 30000;
const MAX_RESULTS = 2500;
const MONTHS_BEFORE = 6;

/**
 * Fetches calendar events from Google Calendar API
 */
export async function fetchCalendarEvents(): Promise<EventsData> {
	try {
		const now = new Date();
		const timeMin = new Date(
			now.getFullYear(),
			now.getMonth() - MONTHS_BEFORE,
			1,
		);
		const timeMax = new Date(now.getFullYear() + 1, now.getMonth(), 0);

		const params = new URLSearchParams({
			key: env.googleApiKey,
			timeMin: timeMin.toISOString(),
			timeMax: timeMax.toISOString(),
			singleEvents: "true",
			orderBy: "startTime",
			maxResults: MAX_RESULTS.toString(),
		});

		const url = `https://www.googleapis.com/calendar/v3/calendars/${env.googleCalendarId}/events?${params}`;

		const controller = new AbortController();
		const timeoutId = setTimeout(() => controller.abort(), TIMEOUT);

		try {
			const response = await fetch(url, {
				method: "GET",
				headers: {
					Accept: "application/json",
					"Content-Type": "application/json",
				},
				signal: controller.signal,
			});

			clearTimeout(timeoutId);

			if (!response.ok) {
				throw new Error(`Calendar API error (${response.status})`);
			}

			const data: GoogleCalendarResponse = await response.json();
			const events = parseEvents(data);
			return groupEventsByDate(events);
		} catch (error) {
			clearTimeout(timeoutId);
			throw error;
		}
	} catch (error) {
		if (error instanceof Error) {
			if (error.name === "AbortError") {
				throw new Error(
					"Request timed out. Please check your internet connection.",
				);
			}
			throw new Error(`Unable to fetch calendar events: ${error.message}`);
		}
		throw new Error("Unable to fetch calendar events");
	}
}

/**
 * Parses raw calendar data into structured Event objects
 */
function parseEvents(data: GoogleCalendarResponse): CalendarEvent[] {
	if (!data?.items || !Array.isArray(data.items)) {
		return [];
	}

	return data.items
		.filter((item: GoogleCalendarEvent) => item?.status !== "cancelled")
		.map((item: GoogleCalendarEvent) => {
			const startDateTime = parseDateTime(item.start) || new Date();
			const endDateTime =
				parseDateTime(item.end) || new Date(startDateTime.getTime() + 3600000);

			return {
				id: item.id || "",
				status: item.status || "confirmed",
				htmlLink: item.htmlLink || "",
				created: new Date(item.created || Date.now()),
				updated: new Date(item.updated || Date.now()),
				summary: item.summary || "Untitled Event",
				description: item.description || "No description available",
				location: item.location || "Location not specified",
				creator: { email: item.creator?.email || "" },
				organizer: { email: item.organizer?.email || "" },
				start: { dateTime: startDateTime },
				end: { dateTime: endDateTime },
				_originalStart: item.start,
				_originalEnd: item.end,
			} as EventWithOriginalData;
		})
		.filter(Boolean);
}

/**
 * Parses a date/time object from the API
 */
function parseDateTime(dateObj: GoogleCalendarDateTime): Date | null {
	if (!dateObj) return null;

	if (dateObj.dateTime) {
		return new Date(dateObj.dateTime);
	}

	if (dateObj.date) {
		return new Date(`${dateObj.date}T00:00:00`);
	}

	return null;
}

/**
 * Groups events by date for calendar display
 *
 * Google Calendar API behavior:
 * - All-day events (date field): end date is EXCLUSIVE
 *   Example: start="2015-11-13", end="2015-11-16" → Nov 13, 14, 15 (NOT 16)
 * - Timed events (dateTime field): includes the end day
 */
function groupEventsByDate(events: CalendarEvent[]): EventsData {
	const eventsData: EventsData = {};

	for (const event of events) {
		const eventWithOriginal = event as EventWithOriginalData;
		const isAllDayEvent =
			eventWithOriginal._originalStart?.date &&
			!eventWithOriginal._originalStart?.dateTime;

		// Get start date (normalize to midnight)
		const startDate = new Date(
			event.start?.dateTime instanceof Date
				? event.start.dateTime.getTime()
				: event.start?.dateTime || Date.now(),
		);
		startDate.setHours(0, 0, 0, 0);

		// Get end date (normalize to midnight)
		const endDate = new Date(
			event.end?.dateTime instanceof Date
				? event.end.dateTime.getTime()
				: event.end?.dateTime || Date.now(),
		);
		endDate.setHours(0, 0, 0, 0);

		// Add event to each day it spans
		const currentDate = new Date(startDate);

		if (isAllDayEvent) {
			// All-day events: end date is EXCLUSIVE (don't include it)
			while (currentDate < endDate) {
				const dateKey = formatDateKey(currentDate);
				if (!eventsData[dateKey]) eventsData[dateKey] = [];
				eventsData[dateKey].push(event);
				currentDate.setDate(currentDate.getDate() + 1);
			}
		} else {
			// Timed events: include the end day
			while (currentDate <= endDate) {
				const dateKey = formatDateKey(currentDate);
				if (!eventsData[dateKey]) eventsData[dateKey] = [];
				eventsData[dateKey].push(event);
				currentDate.setDate(currentDate.getDate() + 1);
			}
		}
	}

	return eventsData;
}

/**
 * Check if two dates are the same day
 */
function isSameDay(date1: Date, date2: Date): boolean {
	return (
		date1.getFullYear() === date2.getFullYear() &&
		date1.getMonth() === date2.getMonth() &&
		date1.getDate() === date2.getDate()
	);
}

/**
 * Format a date as YYYY-MM-DD
 */
function formatDateKey(date: Date): string {
	return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
}
