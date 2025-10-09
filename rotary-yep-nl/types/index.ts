// Common types for the Rotary YEP app
export interface ExchangeStudent {
	id: string;
	name: string;
	age?: number;
	bio: string;
	imageUrl?: string;
	email?: string;
	phoneNumber?: string;
	country?: string;
	city?: string;
	hostFamily?: string;
	socialMedia?: {
		instagram?: string;
		facebook?: string;
		snapchat?: string;
		linkedin?: string;
		website?: string;
	};
}

export interface EmergencyContact {
	id: string;
	name: string;
	function: string;
	phoneNumber: string;
	email?: string;
	type: "emergency" | "coordinator" | "counselor" | "confidant" | "medical";
}

export interface RotaryContact {
	id: string;
	name: string;
	function: string;
	organization: string;
	phoneNumber?: string;
	email?: string;
	type: "mdjc" | "rotex" | "long_term" | "short_term";
}

// Re-export contact types
export * from "./contact";

export interface NewsItem {
	id: string;
	title: string;
	content: string;
	imageUrl?: string;
	date: string;
	author?: string;
}

export interface Event {
	id: string;
	title: string;
	description: string;
	date: string;
	location?: string;
	type: "meeting" | "workshop" | "social" | "travel";
}
