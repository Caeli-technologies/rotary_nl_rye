export interface Student {
	name: string;
	description?: string;
	bio: string;
	imageUrl?: string;
	videoUrl?: string | null;
	email?: string | null;
	phoneNumber?: string | null;
	snapchatUrl?: string | null;
	facebookUrl?: string | null;
	instagramUrl?: string | null;
	websiteUrl?: string | null;
	linkedinUrl?: string | null;
	from: string;
	fromFlag: string;
	to: string;
	toFlag: string;
}

export interface StudentsData {
	list: {
		[year: string]: Student[];
	};
}

export interface CountryInfo {
	country: string;
	flag: string;
	count: number;
	year: string;
}

export interface CountryGroup {
	country: string;
	flag: string;
	students: Student[];
}

export type StudentType = "outbound" | "inbound";
