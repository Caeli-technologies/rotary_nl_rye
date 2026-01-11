/**
 * Calendar date utilities
 */

import type {
  CalendarEvent,
  EventsData,
  EventWithOriginalData,
} from "../types";

/**
 * Check if two dates are the same day
 */
export function isSameDay(date1: Date, date2: Date): boolean {
  return (
    date1.getFullYear() === date2.getFullYear() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getDate() === date2.getDate()
  );
}

/**
 * Format a date as YYYY-MM-DD
 */
export function formatDateKey(date: Date): string {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
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
 */
export function formatEventTime(date: Date): string {
  return new Intl.DateTimeFormat("en-US", {
    hour: "numeric",
    minute: "2-digit",
    hour12: true,
  }).format(date);
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

  if (
    eventWithOriginal._originalEnd?.date &&
    !eventWithOriginal._originalEnd?.dateTime
  ) {
    // For date-only events, subtract 1 day from end date for display
    return new Date(event.end.dateTime.getTime() - 24 * 60 * 60 * 1000);
  }

  return event.end.dateTime;
}
