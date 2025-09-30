import React, { useMemo, useLayoutEffect } from 'react';
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  SectionList,
  Platform,
} from 'react-native';
import { Image } from 'expo-image';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { router, useNavigation } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import * as Haptics from 'expo-haptics';
import { NetworkImage } from '@/components/network-image';
import { Student, CountryGroup, StudentType } from '@/types/student';
import { getFlagAsset } from '@/utils/flags';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface StudentCardProps {
  student: Student;
  onPress: () => void;
  studentType: StudentType;
}

function StudentCard({ student, onPress, studentType }: StudentCardProps) {
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
          imageUrl={student.imageUrl || undefined}
          name={student.name}
          size={60}
          expandable={false}
          showInitials={true}
        />
        
        <View style={styles.studentInfo}>
          <Text style={styles.studentName}>{student.name}</Text>
          <Text style={styles.studentSubtitle}>
            Current {studentType === 'outbound' ? 'Outbound' : 'Inbound'} Student
          </Text>
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

interface StudentsListProps {
  students: Student[];
  countryGroups: CountryGroup[];
  studentType: StudentType;
  basePath: string;
  title: string;
  groupByCountryKey?: 'from' | 'to';
}

export default function StudentsList({ 
  students, 
  countryGroups, 
  studentType, 
  basePath,
  title,
  groupByCountryKey = 'to'
}: StudentsListProps) {
  const navigation = useNavigation();

  const handleStudentPress = async (student: Student, country: string) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push({
        pathname: `${basePath}/student-detail` as any,
        params: { 
          student: JSON.stringify(student),
          country: country,
          studentName: student.name
        }
      });
    } catch (error) {
      console.error('Error navigating to student detail:', error);
      router.push({
        pathname: `${basePath}/student-detail` as any,
        params: { 
          student: JSON.stringify(student),
          country: country,
          studentName: student.name
        }
      });
    }
  };

  // Configure navigation header with student count
  useLayoutEffect(() => {
    navigation.setOptions({
      title: title,
      headerTitle: () => (
        <View style={{ alignItems: Platform.OS === 'ios' ? 'center' : 'flex-start' }}>
          <Text style={{
            fontSize: Platform.OS === 'ios' ? 18 : 20,
            fontWeight: '600',
            color: '#1A237E',
          }}>
            {title}
          </Text>
          {students.length > 0 && (
            <Text style={{
              color: '#8E8E93',
              fontSize: 13,
              fontWeight: '400',
              marginTop: 2,
            }}>
              {students.length} student{students.length !== 1 ? 's' : ''} • {countryGroups.length} countr{countryGroups.length !== 1 ? 'ies' : 'y'}
            </Text>
          )}
        </View>
      ),
    });
  }, [navigation, students.length, countryGroups.length, title]);

  // Convert countryGroups to sections format for SectionList
  const sections = useMemo(() => {
    return countryGroups.map((group) => ({
      title: group.country,
      flag: group.flag,
      count: group.students.length,
      data: group.students,
    }));
  }, [countryGroups]);

  const renderStudent = ({ item, section }: { item: Student; section: any }) => (
    <StudentCard 
      student={item} 
      onPress={() => handleStudentPress(item, section.title)}
      studentType={studentType}
    />
  );

  const renderSectionHeader = ({ section }: { section: { title: string; flag: string; count: number } }) => {
    const flagAsset = getFlagAsset(section.flag);
    
    return (
      <View style={styles.sectionHeader}>
        <View style={styles.sectionHeaderContent}>
          {flagAsset ? (
            <Image 
              source={flagAsset}
              style={styles.sectionFlag}
            />
          ) : (
            <View style={[styles.sectionFlag, styles.flagPlaceholder]}>
              <Text style={styles.flagText}>{section.flag.toUpperCase()}</Text>
            </View>
          )}
          <Text style={styles.sectionTitle}>{section.title}</Text>
      </View>
        <Text style={styles.sectionCount}>
          {section.count} student{section.count !== 1 ? 's' : ''}
        </Text>
      </View>
    );
  };

  if (sections.length === 0) {
    return (
      <SafeAreaView style={styles.container} edges={['bottom']}>
        <StatusBar style="auto" />
        <View style={styles.emptyState}>
          <Ionicons name="school-outline" size={48} color="#9FA8DA" />
          <Text style={styles.emptyStateTitle}>No students found</Text>
          <Text style={styles.emptyStateMessage}>
            There are currently no {studentType} exchange students.
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
        keyExtractor={(item) => item.name}
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
  sectionHeaderContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  sectionFlag: {
    width: 24,
    height: 16,
    marginRight: 12,
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

  studentInfo: {
    flex: 1,
    marginLeft: 16,
  },
  studentName: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  studentSubtitle: {
    fontSize: 14,
    color: '#666',
    fontWeight: '400',
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