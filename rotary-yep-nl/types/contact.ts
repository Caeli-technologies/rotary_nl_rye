export interface Contact {
  name: string;
  bio?: string;
  imageUrl?: string;
  email?: string;
  phoneNumber?: string;
  functions: string[];
}

export interface Organization extends Contact {
  club?: string;
  district?: string;
}

export interface Rotex extends Contact {
  socialMedia?: {
    instagram?: string;
    facebook?: string;
    snapchat?: string;
    linkedin?: string;
    website?: string;
  };
}

export type ContactCategory = 'mdjc' | 'rotex' | 'longterm' | 'shortterm';

export interface ContactSection {
  id: ContactCategory;
  title: string;
  contacts: Contact[];
}