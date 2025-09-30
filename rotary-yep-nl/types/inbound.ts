import { Student } from './student';

export type InboundStudent = Student;

export interface InboundCountryGroup {
  country: string;
  flag: string;
  students: InboundStudent[];
}
