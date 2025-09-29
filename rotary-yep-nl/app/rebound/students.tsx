import React, { useMemo } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  FlatList,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useLocalSearchParams } from 'expo-router';
import { NetworkImage } from '../../components/network-image';
import { StatusBar } from 'expo-status-bar';
import { StudentsData, Student } from '../../types/student';
import studentsData from '../../assets/students/list.json';
import { getFlagAsset } from '../../utils/flags';

const data = studentsData as StudentsData;

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface StudentCardProps {
  student: StudentWithYear;
  onPress: () => void;
}

function StudentCard({ student, onPress }: StudentCardProps) {
  const fromFlagAsset = getFlagAsset(student.fromFlag);
  const toFlagAsset = getFlagAsset(student.toFlag);

  return (
    <TouchableOpacity style={styles.studentCard} onPress={onPress} activeOpacity={0.7}>
      <View style={styles.studentCardContent}>
        <NetworkImage
          imageUrl={student.imageUrl}
          name={student.name}
          size={60}
          expandable={false}
          style={styles.studentImageStyle}
        />
        
        <View style={styles.studentInfo}>
          <Text style={styles.studentName}>{student.name}</Text>
          <Text style={styles.studentDescription}>{student.description}</Text>
          
          <View style={styles.exchangeInfo}>
            <View style={styles.countryContainer}>
              {fromFlagAsset ? (
                <Image
                  source={fromFlagAsset}
                  style={styles.flagImage}
                  contentFit="contain"
                />
              ) : (
                <View style={[styles.flagImage, styles.flagPlaceholder]}>
                  <Text style={styles.flagText}>{student.fromFlag.toUpperCase()}</Text>
                </View>
              )}
              <Text style={styles.countryText}>{student.from}</Text>
            </View>
            
            <Ionicons name="arrow-forward" size={16} color="#9FA8DA" style={styles.arrowIcon} />
            
            <View style={styles.countryContainer}>
              {toFlagAsset ? (
                <Image
                  source={toFlagAsset}
                  style={styles.flagImage}
                  contentFit="contain"
                />
              ) : (
                <View style={[styles.flagImage, styles.flagPlaceholder]}>
                  <Text style={styles.flagText}>{student.toFlag.toUpperCase()}</Text>
                </View>
              )}
              <Text style={styles.countryText}>{student.to}</Text>
            </View>
          </View>
        </View>
        
        <Ionicons name="chevron-forward" size={20} color="#9FA8DA" />
      </View>
    </TouchableOpacity>
  );
}

interface StudentWithYear extends Student {
  year: string;
}

export default function ReboundStudentsScreen() {
  const params = useLocalSearchParams<{
    country: string;
    flag: string;
  }>();

  const studentsWithYears = useMemo(() => {
    if (!params.country) return [];
    
    const result: StudentWithYear[] = [];
    
    Object.entries(data.list).forEach(([year, students]) => {
      students
        .filter(student => student.to === params.country)
        .forEach(student => {
          result.push({ ...student, year });
        });
    });
    
    // Sort by year (newest first), then by name
    return result.sort((a, b) => {
      if (a.year !== b.year) {
        return b.year.localeCompare(a.year);
      }
      return a.name.localeCompare(b.name);
    });
  }, [params.country]);

  const yearGroups = useMemo(() => {
    const groups = new Map<string, StudentWithYear[]>();
    
    studentsWithYears.forEach(student => {
      const existing = groups.get(student.year) || [];
      existing.push(student);
      groups.set(student.year, existing);
    });
    
    return Array.from(groups.entries())
      .sort(([a], [b]) => b.localeCompare(a)); // Sort years descending
  }, [studentsWithYears]);

  const handleStudentPress = (student: StudentWithYear) => {
    router.push({
      pathname: '/rebound/student-detail' as any,
      params: {
        year: student.year,
        country: params.country,
        studentName: student.name,
      },
    });
  };

  const renderStudent = ({ item }: { item: StudentWithYear }) => (
    <StudentCard student={item} onPress={() => handleStudentPress(item)} />
  );

  const headerFlagAsset = getFlagAsset(params.flag || '');

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        {/* Header Section */}
        <View style={styles.headerSection}>
          <View style={styles.headerTitleContainer}>
            {headerFlagAsset ? (
              <Image
                source={headerFlagAsset}
                style={styles.headerFlag}
                contentFit="contain"
              />
            ) : (
              <View style={[styles.headerFlag, styles.flagPlaceholder]}>
                <Text style={styles.headerFlagText}>{(params.flag || '').toUpperCase()}</Text>
              </View>
            )}
            <Text style={styles.headerTitle}>{params.country}</Text>
          </View>
          <Text style={styles.headerSubtitle}>
            {studentsWithYears.length} exchange student{studentsWithYears.length !== 1 ? 's' : ''} • {yearGroups.length} year{yearGroups.length !== 1 ? 's' : ''}
          </Text>
        </View>

        {/* Students by Year */}
        <View style={styles.studentsSection}>
          {yearGroups.length > 0 ? (
            yearGroups.map(([year, students]) => (
              <View key={year} style={styles.yearGroup}>
                <View style={styles.yearHeader}>
                  <Text style={styles.yearTitle}>{year}</Text>
                  <Text style={styles.yearCount}>{students.length} student{students.length !== 1 ? 's' : ''}</Text>
                </View>
                
                <FlatList
                  data={students}
                  renderItem={renderStudent}
                  keyExtractor={(item) => `${item.name}-${item.year}`}
                  scrollEnabled={false}
                  ItemSeparatorComponent={() => <View style={styles.separator} />}
                />
              </View>
            ))
          ) : (
            <View style={styles.emptyState}>
              <Ionicons name="school-outline" size={48} color="#9FA8DA" />
              <Text style={styles.emptyStateTitle}>No students found</Text>
              <Text style={styles.emptyStateMessage}>
                There are no exchange students who went to {params.country}.
              </Text>
            </View>
          )}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  scrollView: {
    flex: 1,
  },
  headerSection: {
    paddingHorizontal: 16,
    paddingTop: 20,
    paddingBottom: 10,
  },
  headerTitleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  headerFlag: {
    width: 32,
    height: 21,
    marginRight: 12,
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: '700',
    color: '#1A237E',
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#666',
    lineHeight: 22,
    marginLeft: 44, // Align with title text
  },
  studentsSection: {
    paddingHorizontal: 16,
    marginBottom: 24,
  },
  yearGroup: {
    marginBottom: 32,
  },
  yearHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
    paddingHorizontal: 4,
  },
  yearTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#1A237E',
  },
  yearCount: {
    fontSize: 14,
    color: '#666',
  },
  studentCard: {
    backgroundColor: '#F5F5F5',
    borderRadius: 12,
    ...shadowStyle,
  },
  studentCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  studentImageStyle: {
    marginRight: 16,
  },
  studentInfo: {
    flex: 1,
  },
  studentName: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  studentDescription: {
    fontSize: 14,
    color: '#666',
    marginBottom: 8,
  },
  exchangeInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  countryContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  flagImage: {
    width: 20,
    height: 13,
    marginRight: 6,
  },
  countryText: {
    fontSize: 12,
    color: '#666',
    fontWeight: '500',
  },
  arrowIcon: {
    marginHorizontal: 8,
  },
  separator: {
    height: 12,
  },
  emptyState: {
    alignItems: 'center',
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyStateTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#1A237E',
    marginTop: 16,
    marginBottom: 8,
  },
  emptyStateMessage: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
  },
  flagPlaceholder: {
    backgroundColor: '#E0E0E0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  flagText: {
    fontSize: 8,
    color: '#666',
    fontWeight: '600',
  },
  headerFlagText: {
    fontSize: 12,
    color: '#666',
    fontWeight: '600',
  },
});