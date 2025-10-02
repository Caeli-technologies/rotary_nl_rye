import { Event, EventsData } from '../types/events';
import { fetch } from 'expo/fetch';

// Configuration
const API_KEY = 'AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY';
const CALENDAR_ID = 'rye.netherlands@gmail.com';
const BASE_URL = `https://www.googleapis.com/calendar/v3/calendars/${CALENDAR_ID}/events`;
const TIMEOUT = 30000;
const MAX_RESULTS = 2500;
const MONTHS_BEFORE = 6;

/**
 * Fetches calendar events from Google Calendar API
 */
export const fetchCalendarEvents = async (): Promise<EventsData> => {
  try {
    const now = new Date();
    const timeMin = new Date(now.getFullYear(), now.getMonth() - MONTHS_BEFORE, 1);
    const timeMax = new Date(now.getFullYear() + 1, now.getMonth(), 0);

    const params = new URLSearchParams({
      key: API_KEY,
      timeMin: timeMin.toISOString(),
      timeMax: timeMax.toISOString(),
      singleEvents: 'true',
      orderBy: 'startTime',
      maxResults: MAX_RESULTS.toString(),
    });

    const url = `${BASE_URL}?${params}`;

    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), TIMEOUT);

    try {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        throw new Error(`Calendar API error (${response.status})`);
      }

      const data = await response.json();
      const events = parseEvents(data);
      return groupEventsByDate(events);
    } catch (error) {
      clearTimeout(timeoutId);
      throw error;
    }
  } catch (error) {
    if (error instanceof Error) {
      if (error.name === 'AbortError') {
        throw new Error('Request timed out. Please check your internet connection.');
      }
      throw new Error(`Unable to fetch calendar events: ${error.message}`);
    }
    throw new Error('Unable to fetch calendar events');
  }
};

/**
 * Parses raw calendar data into structured Event objects
 */
const parseEvents = (data: any): Event[] => {
  if (!data?.items || !Array.isArray(data.items)) {
    return [];
  }

  return data.items
    .filter((item: any) => item?.status !== 'cancelled')
    .map((item: any) => {
      const startDateTime = parseDateTime(item.start) || new Date();
      const endDateTime = parseDateTime(item.end) || new Date(startDateTime.getTime() + 3600000);

      return {
        id: item.id || '',
        status: item.status || 'confirmed',
        htmlLink: item.htmlLink || '',
        created: new Date(item.created || Date.now()),
        updated: new Date(item.updated || Date.now()),
        summary: item.summary || 'Untitled Event',
        description: item.description || 'No description available',
        location: item.location || 'Location not specified',
        creator: { email: item.creator?.email || '' },
        organizer: { email: item.organizer?.email || '' },
        start: { dateTime: startDateTime },
        end: { dateTime: endDateTime },
        _originalStart: item.start,
        _originalEnd: item.end,
      } as Event & { _originalStart: any; _originalEnd: any };
    })
    .filter(Boolean);
};

/**
 * Parses a date/time object from the API
 */
const parseDateTime = (dateObj: any): Date | null => {
  if (!dateObj) return null;

  if (dateObj.dateTime) {
    return new Date(dateObj.dateTime);
  }

  if (dateObj.date) {
    return new Date(dateObj.date + 'T00:00:00');
  }

  return null;
};

/**
 * Groups events by date for calendar display
 */
const groupEventsByDate = (events: Event[]): EventsData => {
  const eventsData: EventsData = {};

  for (const event of events) {
    const startDate = new Date(event.start.dateTime);
    const endDate = new Date(event.end.dateTime);

    if (isSameDay(startDate, endDate)) {
      const dateKey = formatDateKey(startDate);
      if (!eventsData[dateKey]) eventsData[dateKey] = [];
      eventsData[dateKey].push(event);
    } else {
      // Multi-day event - add to all days
      const actualEndDate = new Date(endDate);
      actualEndDate.setDate(actualEndDate.getDate() - 1);

      const currentDate = new Date(startDate);
      while (currentDate <= actualEndDate) {
        const dateKey = formatDateKey(currentDate);
        if (!eventsData[dateKey]) eventsData[dateKey] = [];
        eventsData[dateKey].push(event);
        currentDate.setDate(currentDate.getDate() + 1);
      }
    }
  }

  return eventsData;
};

export const isSameDay = (date1: Date, date2: Date): boolean => {
  return (
    date1.getFullYear() === date2.getFullYear() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getDate() === date2.getDate()
  );
};

export const formatDateKey = (date: Date): string => {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
};

export const getEventsForDay = (eventsData: EventsData, date: Date): Event[] => {
  const dateKey = formatDateKey(date);
  return eventsData[dateKey] || [];
};

/**
 * Formats a date for display (e.g., "Monday, January 1, 2024")
 */
export const formatEventDate = (date: Date): string => {
  return new Intl.DateTimeFormat('en-US', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date);
};

/**
 * Formats a time for display (e.g., "2:30 PM")
 */
export const formatEventTime = (date: Date): string => {
  return new Intl.DateTimeFormat('en-US', {
    hour: 'numeric',
    minute: '2-digit',
    hour12: true,
  }).format(date);
};

export const isMultiDayEvent = (event: Event): boolean => {
  return !isSameDay(event.start.dateTime, event.end.dateTime);
};

/**
 * Extracts URLs from event description
 */
export const extractLinksFromDescription = (description: string): string[] => {
  const urlRegex = /(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+/g;
  return description.match(urlRegex) || [];
};

/**
 * Checks if an event is an all-day event
 */
export const isAllDayEvent = (event: Event): boolean => {
  const eventWithOriginal = event as Event & { _originalStart?: any; _originalEnd?: any };
  return eventWithOriginal._originalStart?.date && !eventWithOriginal._originalStart?.dateTime;
};

/**
 * Gets the display end date for an event
 */
export const getDisplayEndDate = (event: Event): Date => {
  const eventWithOriginal = event as Event & { _originalStart?: any; _originalEnd?: any };

  if (eventWithOriginal._originalEnd?.date && !eventWithOriginal._originalEnd?.dateTime) {
    // For date-only events, subtract 1 day from end date for display
    return new Date(event.end.dateTime.getTime() - 24 * 60 * 60 * 1000);
  }

  return event.end.dateTime;
};
