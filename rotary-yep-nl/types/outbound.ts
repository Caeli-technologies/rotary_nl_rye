export interface OutboundStudent {
  name: string;
  bio: string;
  imageUrl: string;
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

export interface CountryGroup {
  country: string;
  flag: string;
  students: OutboundStudent[];
}