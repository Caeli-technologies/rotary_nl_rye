import {
	currentInboundStudents,
	groupInboundStudentsByCountry,
} from "@/data/inbound-students";
import StudentsList from "@/components/students/StudentsList";

export default function InboundClassOfScreen() {
	const countryGroups = groupInboundStudentsByCountry(currentInboundStudents);

	return (
		<StudentsList
			students={currentInboundStudents}
			countryGroups={countryGroups}
			studentType="inbound"
			basePath="/inbound/long-term/class-of"
			title="Class Of 2024-25"
		/>
	);
}
