import React, { useMemo } from 'react';
import { useLocalSearchParams } from 'expo-router';
import StudentDetail from '@/components/students/StudentDetail';
import { currentInboundStudents } from '@/data/inbound-students';

export default function InboundStudentDetailScreen() {
  const params = useLocalSearchParams<{
    studentName: string;
  }>();

  const student = useMemo(() => {
    if (!params.studentName) return null;

    return (
      currentInboundStudents.find((s) => s.name === params.studentName) || null
    );
  }, [params.studentName]);

  if (!student) {
    return null; // StudentDetail component handles this case
  }

  return <StudentDetail student={student} studentType="inbound" />;
}
