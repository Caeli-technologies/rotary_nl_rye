import type { GoogleCalendarDateTime } from "./googleCalendar";

export interface Creator {
	email: string;
}

export interface EventTime {
	dateTime: Date;
}

export interface Event {
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

// Extended Event type that includes original Google Calendar data
export interface EventWithOriginalData extends Event {
	_originalStart: GoogleCalendarDateTime;
	_originalEnd: GoogleCalendarDateTime;
}

export interface EventsData {
	[date: string]: Event[];
}
