/**
 * Calendar feature types
 */

/**
 * Google Calendar API DateTime
 */
export interface GoogleCalendarDateTime {
  dateTime?: string;
  date?: string;
  timeZone?: string;
}

/**
 * Google Calendar API Event
 */
export interface GoogleCalendarEvent {
  id: string;
  status: string;
  htmlLink: string;
  created: string;
  updated: string;
  summary: string;
  description?: string;
  location?: string;
  creator?: { email: string };
  organizer?: { email: string };
  start: GoogleCalendarDateTime;
  end: GoogleCalendarDateTime;
}

/**
 * Google Calendar API Response
 */
export interface GoogleCalendarResponse {
  items?: GoogleCalendarEvent[];
}

/**
 * Creator/Organizer
 */
export interface Creator {
  email: string;
}

/**
 * Event time with parsed Date
 */
export interface EventTime {
  dateTime: Date;
}

/**
 * Parsed calendar event
 */
export interface CalendarEvent {
  id: string;
  status: string;
  htmlLink: string;
  created: Date;
  updated: Date;
  summary: string;
  description: string;
  location: string;
  creator: Creator;
  organizer: Creator;
  start: EventTime;
  end: EventTime;
}

/**
 * Event with original data for date-only detection
 */
export interface EventWithOriginalData extends CalendarEvent {
  _originalStart: GoogleCalendarDateTime;
  _originalEnd: GoogleCalendarDateTime;
}

/**
 * Events grouped by date string (YYYY-MM-DD)
 */
export interface EventsData {
  [date: string]: CalendarEvent[];
}

/**
 * Marked dates for calendar component
 */
export interface MarkedDates {
  [date: string]: {
    marked?: boolean;
    dotColor?: string;
    selected?: boolean;
    selectedColor?: string;
    selectedTextColor?: string;
  };
}
