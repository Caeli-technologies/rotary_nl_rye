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
