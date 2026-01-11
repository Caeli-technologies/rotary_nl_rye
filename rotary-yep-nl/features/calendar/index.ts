/**
 * Calendar feature public API
 */

// Components
export { CalendarView, EventCard, EventsList, EventModal } from "./components";

// Hooks
export { useCalendarEvents, useMarkedDates, useSelectedDate } from "./hooks";

// Types
export type {
  CalendarEvent,
  EventsData,
  MarkedDates,
  GoogleCalendarEvent,
  GoogleCalendarResponse,
  GoogleCalendarDateTime,
  EventTime,
  Creator,
  EventWithOriginalData,
} from "./types";

// Utils
export {
  formatDateKey,
  getEventsForDay,
  formatEventDate,
  formatEventTime,
  isMultiDayEvent,
  extractLinksFromDescription,
} from "./utils";

// API
export { fetchCalendarEvents } from "./api";
