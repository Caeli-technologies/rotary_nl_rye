export interface Student {
  name: string;
  description: string;
  bio: string;
  imageUrl: string;
  videoUrl: string | null;
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