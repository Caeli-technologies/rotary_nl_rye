import React, { useMemo, useLayoutEffect, useCallback } from 'react';
import { StyleSheet, View, Text, Pressable, SectionList, Platform } from 'react-native';
import * as Haptics from 'expo-haptics';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useLocalSearchParams, useNavigation } from 'expo-router';
import { NetworkImage } from '../../components/network-image';

import { StudentsData, Student } from '../../types/student';
import studentsData from '../../assets/students/list.json';
import { getFlagAsset } from '../../utils/flags';
import { Colors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
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
  themeColors: typeof Colors.light;
}

function StudentCard({ student, onPress, themeColors }: StudentCardProps) {
  return (
    <Pressable
      style={({ pressed }) => [
        styles.studentCard,
        { backgroundColor: themeColors.card, borderColor: themeColors.border },
        pressed && styles.studentCardPressed,
      ]}
      onPress={onPress}
      android_ripple={{
        color: 'rgba(0, 122, 255, 0.2)',
        borderless: false,
      }}
      accessibilityRole="button"
      accessibilityLabel={`View details for ${student.name}`}
      accessibilityHint="Tap to view student exchange details"
      hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
      <View style={styles.studentCardContent}>
        <NetworkImage
          imageUrl={student.imageUrl}
          name={student.name}
          size={60}
          expandable={false}
          style={styles.studentImageStyle}
        />

        <View style={styles.studentInfo}>
          <Text style={[styles.studentName, { color: themeColors.text }]}>{student.name}</Text>
          <Text style={[styles.studentDescription, { color: themeColors.textSecondary }]}>
            {student.description}
          </Text>
        </View>

        <Ionicons
          name={Platform.OS === 'ios' ? 'chevron-forward' : 'chevron-forward-outline'}
          size={Platform.OS === 'ios' ? 20 : 24}
          color={themeColors.textTertiary}
        />
      </View>
    </Pressable>
  );
}

interface StudentWithYear extends Student {
  year: string;
}

export default function ReboundStudentsScreen() {
  const { colors: themeColors } = useTheme();

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
        .filter((student) => student.to === params.country)
        .forEach((student) => {
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

    studentsWithYears.forEach((student) => {
      const existing = groups.get(student.year) || [];
      existing.push(student);
      groups.set(student.year, existing);
    });

    return Array.from(groups.entries()).sort(([a], [b]) => b.localeCompare(a)); // Sort years descending
  }, [studentsWithYears]);

  const handleStudentPress = useCallback(
    async (student: StudentWithYear) => {
      try {
        if (Platform.OS === 'ios') {
          await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
        }
        router.push({
          pathname: '/rebound/student-detail' as any,
          params: {
            year: student.year,
            country: params.country,
            studentName: student.name,
          },
        });
      } catch (error) {
        console.error('Error navigating to student detail:', error);
        // Still navigate even if haptics fail
        router.push({
          pathname: '/rebound/student-detail' as any,
          params: {
            year: student.year,
            country: params.country,
            studentName: student.name,
          },
        });
      }
    },
    [params.country],
  );

  const headerFlagAsset = getFlagAsset(params.flag || '');

  // Configure navigation header with country name and student count
  useLayoutEffect(() => {
    navigation.setOptions({
      title: params.country || 'Students',
      headerTitle: () => (
        <View
          style={{
            alignItems: Platform.OS === 'ios' ? 'center' : 'flex-start',
          }}>
          <View style={{ flexDirection: 'row', alignItems: 'center' }}>
            {headerFlagAsset ? (
              <Image
                source={headerFlagAsset}
                style={{ width: 24, height: 16, marginRight: 8 }}
                contentFit="contain"
              />
            ) : (
              <View
                style={{
                  width: 24,
                  height: 16,
                  justifyContent: 'center',
                  alignItems: 'center',
                  marginRight: 8,
                  borderRadius: 2,
                  backgroundColor: themeColors.backgroundElevated,
                }}>
                <Text
                  style={{
                    fontSize: 10,
                    color: themeColors.textTertiary,
                  }}>
                  {(params.flag || '').toUpperCase()}
                </Text>
              </View>
            )}
            <Text
              style={{
                fontSize: Platform.OS === 'ios' ? 18 : 20,
                fontWeight: '600',
                color: themeColors.text,
              }}>
              {params.country}
            </Text>
          </View>
          {studentsWithYears.length > 0 && (
            <Text
              style={{
                fontSize: 13,
                fontWeight: '400',
                marginTop: 2,
                color: themeColors.textSecondary,
              }}>
              {studentsWithYears.length} student
              {studentsWithYears.length !== 1 ? 's' : ''}
            </Text>
          )}
        </View>
      ),
    });
  }, [
    navigation,
    params.country,
    params.flag,
    headerFlagAsset,
    studentsWithYears.length,
    themeColors,
  ]);

  // Convert yearGroups to sections format for SectionList
  const sections = useMemo(() => {
    return yearGroups.map(([year, students]) => ({
      title: year,
      count: students.length,
      data: students,
    }));
  }, [yearGroups]);

  const renderStudent = useCallback(
    ({ item }: { item: StudentWithYear }) => (
      <StudentCard
        student={item}
        onPress={() => handleStudentPress(item)}
        themeColors={themeColors}
      />
    ),
    [handleStudentPress, themeColors],
  );

  const renderSectionHeader = useCallback(
    ({ section }: { section: { title: string; count: number } }) => (
      <View
        style={[
          styles.sectionHeader,
          { backgroundColor: themeColors.background, borderBottomColor: themeColors.divider },
        ]}>
        <Text style={[styles.sectionTitle, { color: themeColors.primary }]}>{section.title}</Text>
        <Text style={[styles.sectionCount, { color: themeColors.textSecondary }]}>
          {section.count} student{section.count !== 1 ? 's' : ''}
        </Text>
      </View>
    ),
    [themeColors],
  );

  if (sections.length === 0) {
    return (
      <SafeAreaView
        style={[styles.container, { backgroundColor: themeColors.background }]}
        edges={['bottom']}>
        <View style={styles.emptyState}>
          <Ionicons name="school-outline" size={48} color={themeColors.primary} />
          <Text style={[styles.emptyStateTitle, { color: themeColors.primary }]}>
            No students found
          </Text>
          <Text style={[styles.emptyStateMessage, { color: themeColors.textSecondary }]}>
            There are no exchange students who went to {params.country}.
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
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
    borderBottomWidth: Platform.OS === 'ios' ? 0 : StyleSheet.hairlineWidth,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '500',
    letterSpacing: Platform.OS === 'ios' ? 0.35 : 0,
  },
  sectionCount: {
    fontSize: 14,
    fontWeight: '400',
  },
  studentCard: {
    marginHorizontal: Platform.OS === 'ios' ? 16 : 0,
    borderRadius: Platform.OS === 'ios' ? 12 : 0,
    borderBottomWidth: Platform.OS === 'ios' ? 0 : StyleSheet.hairlineWidth,
    ...(Platform.OS === 'ios' ? shadowStyle : {}),
  },
  studentCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
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
    marginBottom: 4,
  },
  studentDescription: {
    fontSize: 14,
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
    marginTop: 16,
    marginBottom: 8,
  },
  emptyStateMessage: {
    fontSize: 16,
    textAlign: 'center',
    lineHeight: 22,
  },
  flagPlaceholder: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  flagText: {
    fontSize: 8,
    fontWeight: '600',
  },
});
