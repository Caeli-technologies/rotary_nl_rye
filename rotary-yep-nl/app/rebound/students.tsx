import React, { useMemo, useLayoutEffect } from 'react';
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  SectionList,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useLocalSearchParams, useNavigation } from 'expo-router';
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
    <Pressable 
      style={({ pressed }) => [
        styles.studentCard,
        pressed && styles.studentCardPressed
      ]} 
      onPress={onPress}
    >
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
        
        <Ionicons 
          name={Platform.OS === 'ios' ? 'chevron-forward' : 'chevron-forward-outline'} 
          size={Platform.OS === 'ios' ? 20 : 24} 
          color={Platform.OS === 'ios' ? '#C7C7CC' : '#9FA8DA'} 
        />
      </View>
    </Pressable>
  );
}

interface StudentWithYear extends Student {
  year: string;
}

export default function ReboundStudentsScreen() {
  const navigation = useNavigation();
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

  const headerFlagAsset = getFlagAsset(params.flag || '');

  // Configure navigation header with country name and student count
  useLayoutEffect(() => {
    navigation.setOptions({
      title: params.country || 'Students',
      headerTitle: () => (
        <View style={{ alignItems: Platform.OS === 'ios' ? 'center' : 'flex-start' }}>
          <View style={{ flexDirection: 'row', alignItems: 'center' }}>
            {headerFlagAsset ? (
              <Image
                source={headerFlagAsset}
                style={{ width: 24, height: 16, marginRight: 8 }}
                contentFit="contain"
              />
            ) : (
              <View style={{
                width: 24,
                height: 16,
                backgroundColor: '#E0E0E0',
                justifyContent: 'center',
                alignItems: 'center',
                marginRight: 8,
                borderRadius: 2,
              }}>
                <Text style={{ fontSize: 8, color: '#666', fontWeight: '600' }}>
                  {(params.flag || '').toUpperCase()}
                </Text>
              </View>
            )}
            <Text style={{
              fontSize: Platform.OS === 'ios' ? 18 : 20,
              fontWeight: '600',
              color: '#1A237E',
            }}>
              {params.country}
            </Text>
          </View>
          {studentsWithYears.length > 0 && (
            <Text style={{
              color: '#8E8E93',
              fontSize: 13,
              fontWeight: '400',
              marginTop: 2,
            }}>
              {studentsWithYears.length} student{studentsWithYears.length !== 1 ? 's' : ''} • {yearGroups.length} year{yearGroups.length !== 1 ? 's' : ''}
            </Text>
          )}
        </View>
      ),
    });
  }, [navigation, params.country, params.flag, headerFlagAsset, studentsWithYears.length, yearGroups.length]);

  // Convert yearGroups to sections format for SectionList
  const sections = useMemo(() => {
    return yearGroups.map(([year, students]) => ({
      title: year,
      count: students.length,
      data: students,
    }));
  }, [yearGroups]);

  const renderStudent = ({ item }: { item: StudentWithYear }) => (
    <StudentCard student={item} onPress={() => handleStudentPress(item)} />
  );

  const renderSectionHeader = ({ section }: { section: { title: string; count: number } }) => (
    <View style={styles.sectionHeader}>
      <Text style={styles.sectionTitle}>{section.title}</Text>
      <Text style={styles.sectionCount}>
        {section.count} student{section.count !== 1 ? 's' : ''}
      </Text>
    </View>
  );

  if (sections.length === 0) {
    return (
      <SafeAreaView style={styles.container} edges={['bottom']}>
        <StatusBar style="auto" />
        <View style={styles.emptyState}>
          <Ionicons name="school-outline" size={48} color="#9FA8DA" />
          <Text style={styles.emptyStateTitle}>No students found</Text>
          <Text style={styles.emptyStateMessage}>
            There are no exchange students who went to {params.country}.
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <StatusBar style="auto" />
      
      <SectionList
        sections={sections}
        renderItem={renderStudent}
        renderSectionHeader={renderSectionHeader}
        keyExtractor={(item) => `${item.name}-${item.year}`}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        stickySectionHeadersEnabled={Platform.OS === 'ios'}
        ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
        SectionSeparatorComponent={() => <View style={styles.sectionSeparator} />}
        contentContainerStyle={styles.contentContainer}
        removeClippedSubviews={true}
        initialNumToRender={15}
        maxToRenderPerBatch={10}
        windowSize={10}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  contentContainer: {
    paddingBottom: 20,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: Platform.OS === 'ios' ? 8 : 12,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#F5F5F5',
    borderBottomWidth: Platform.OS === 'ios' ? 0 : StyleSheet.hairlineWidth,
    borderBottomColor: '#E0E0E0',
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '500',
    color: '#1A237E',
    letterSpacing: Platform.OS === 'ios' ? 0.35 : 0,
  },
  sectionCount: {
    fontSize: 14,
    color: '#666',
    fontWeight: '400',
  },
  studentCard: {
    backgroundColor: '#FFFFFF',
    marginHorizontal: Platform.OS === 'ios' ? 16 : 0,
    borderRadius: Platform.OS === 'ios' ? 12 : 0,
    borderBottomWidth: Platform.OS === 'ios' ? 0 : StyleSheet.hairlineWidth,
    borderBottomColor: '#E0E0E0',
    ...(Platform.OS === 'ios' ? shadowStyle : {}),
  },
  studentCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
    backgroundColor: Platform.OS === 'ios' ? '#F0F0F0' : '#F5F5F5',
  },
  studentCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: Platform.OS === 'ios' ? 80 : 88,
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
    width: 24,
    height: 16,
    marginRight: 8,
  },
  countryText: {
    fontSize: 12,
    color: '#666',
    fontWeight: '500',
  },
  arrowIcon: {
    marginHorizontal: 8,
  },
  itemSeparator: {
    height: Platform.OS === 'ios' ? 12 : 0,
  },
  sectionSeparator: {
    height: Platform.OS === 'ios' ? 20 : 16,
  },
  emptyState: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
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
});