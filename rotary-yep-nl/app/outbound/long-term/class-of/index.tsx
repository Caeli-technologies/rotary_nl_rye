import {
  currentOutboundStudents,
  groupStudentsByCountry,
} from "@/data/outbound-students";
import StudentsList from "@/components/students/StudentsList";

export default function CurrentStudentsScreen() {
  const countryGroups = groupStudentsByCountry(currentOutboundStudents);

  return (
    <StudentsList
      students={currentOutboundStudents}
      countryGroups={countryGroups}
      studentType="outbound"
      basePath="/outbound/long-term/class-of"
      title="Current Students"
    />
  );
}
