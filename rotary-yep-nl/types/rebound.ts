// Types for the Rebound feature

export interface Country {
  name: string;
  flagCode: string; // e.g., 'ar', 'au', 'br'
  description?: string;
}

export interface ReboundStudent {
  id: string;
  name: string;
  bio: string;
  imageUrl: string;
  from: string;
  fromFlag: string;
  to: string;
  toFlag: string;
  description: string; // Contains year information
  video?: string;
}

// Available countries for rebounds
export const REBOUND_COUNTRIES: Country[] = [
  { name: 'Argentina', flagCode: 'ar' },
  { name: 'Australia', flagCode: 'au' },
  { name: 'Brazil', flagCode: 'br' },
  { name: 'Canada', flagCode: 'ca' },
  { name: 'Chili', flagCode: 'cl' },
  { name: 'Colombia', flagCode: 'co' },
  { name: 'Ecuador', flagCode: 'ec' },
  { name: 'Finland', flagCode: 'fi' },
  { name: 'India', flagCode: 'in' },
  { name: 'Indonesia', flagCode: 'id' },
  { name: 'Italy', flagCode: 'it' },
  { name: 'Japan', flagCode: 'jp' },
  { name: 'Mexico', flagCode: 'mx' },
  { name: 'New Zealand', flagCode: 'nz' },
  { name: 'Peru', flagCode: 'pe' },
  { name: 'South Africa', flagCode: 'za' },
  { name: 'South Korea', flagCode: 'kr' },
  { name: 'Taiwan', flagCode: 'tw' },
  { name: 'Thailand', flagCode: 'th' },
  { name: 'USA', flagCode: 'us' },
  { name: 'Spain', flagCode: 'es' },
  { name: 'Europa', flagCode: 'eu' },
  { name: 'Switzerland', flagCode: 'ch' },
  { name: 'France', flagCode: 'fr' },
];
