// Interfaces for Google Calendar API response
export interface GoogleCalendarDateTime {
	dateTime?: string;
	date?: string;
	timeZone?: string;
}

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

export interface GoogleCalendarResponse {
	items?: GoogleCalendarEvent[];
}
