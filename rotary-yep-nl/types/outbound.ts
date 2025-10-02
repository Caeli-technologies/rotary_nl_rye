import { Student } from './student';

export type OutboundStudent = Student;

export interface OutboundCountryGroup {
  country: string;
  flag: string;
  students: OutboundStudent[];
}
