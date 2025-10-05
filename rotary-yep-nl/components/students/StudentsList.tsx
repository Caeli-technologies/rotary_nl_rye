import React, { useMemo, useLayoutEffect } from 'react';
import { StyleSheet, View, Text, Pressable, SectionList, Platform } from 'react-native';
import { Colors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { Image } from 'expo-image';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { router, useNavigation } from 'expo-router';
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
  styles: any;
  themeColors: typeof Colors.light;
}

function StudentCard({ student, onPress, studentType, styles, themeColors }: StudentCardProps) {
  const handlePress = async () => {
    if (Platform.OS === 'ios') {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
    }
    onPress();
  };

  return (
    <Pressable
      style={({ pressed }) => [
        styles.studentCard,
        {
          backgroundColor: themeColors.card,
          borderBottomColor: themeColors.border,
          shadowColor: themeColors.shadow,
        },
        pressed && styles.studentCardPressed,
      ]}
      onPress={handlePress}
      android_ripple={{ color: themeColors.primary + '20', borderless: false }}
      accessibilityRole="button"
      accessibilityLabel={`View details for ${student.name}`}
      accessibilityHint={`Opens ${student.name}'s profile page`}>
      <View style={styles.studentCardContent}>
        <NetworkImage
          imageUrl={student.imageUrl || undefined}
          name={student.name}
          size={60}
          expandable={false}
          showInitials={true}
        />

        <View style={styles.studentInfo}>
          <Text style={[styles.studentName, { color: themeColors.text }]}>{student.name}</Text>
          <Text style={[styles.studentSubtitle, { color: themeColors.textSecondary }]}>
            Current {studentType === 'outbound' ? 'Outbound' : 'Inbound'} Student
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
  groupByCountryKey = 'to',
}: StudentsListProps) {
  const { colors: themeColors } = useTheme();
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
          studentName: student.name,
        },
      });
    } catch (error) {
      console.error('Error navigating to student detail:', error);
      router.push({
        pathname: `${basePath}/student-detail` as any,
        params: {
          student: JSON.stringify(student),
          country: country,
          studentName: student.name,
        },
      });
    }
  };

  // Configure navigation header with student count
  useLayoutEffect(() => {
    navigation.setOptions({
      title: title,
      headerTitle: () => (
        <View
          style={{
            alignItems: Platform.OS === 'ios' ? 'center' : 'flex-start',
          }}>
          <Text
            style={{
              fontSize: Platform.OS === 'ios' ? 18 : 20,
              fontWeight: '600',
              color: themeColors.text,
            }}>
            {title}
          </Text>
          {students.length > 0 && (
            <Text
              style={{
                fontSize: 13,
                fontWeight: '400',
                marginTop: 2,
                color: themeColors.textSecondary,
              }}>
              {students.length} student{students.length !== 1 ? 's' : ''} • {countryGroups.length}{' '}
              countr
              {countryGroups.length !== 1 ? 'ies' : 'y'}
            </Text>
          )}
        </View>
      ),
    });
  }, [navigation, students.length, countryGroups.length, title, themeColors]);

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
      styles={styles}
      themeColors={themeColors}
    />
  );

  const renderSectionHeader = ({
    section,
  }: {
    section: { title: string; flag: string; count: number };
  }) => {
    const flagAsset = getFlagAsset(section.flag);

    return (
      <View
        style={[
          styles.sectionHeader,
          { backgroundColor: themeColors.background, borderBottomColor: themeColors.border },
        ]}>
        <View style={styles.sectionHeaderContent}>
          {flagAsset ? (
            <Image source={flagAsset} style={styles.sectionFlag} />
          ) : (
            <View
              style={[
                styles.sectionFlag,
                styles.flagPlaceholder,
                { backgroundColor: themeColors.border },
              ]}>
              <Text style={[styles.flagText, { color: themeColors.textSecondary }]}>
                {section.flag.toUpperCase()}
              </Text>
            </View>
          )}
          <Text style={[styles.sectionTitle, { color: themeColors.text }]}>{section.title}</Text>
        </View>
        <Text style={[styles.sectionCount, { color: themeColors.textSecondary }]}>
          {section.count} student{section.count !== 1 ? 's' : ''}
        </Text>
      </View>
    );
  };

  if (sections.length === 0) {
    return (
      <SafeAreaView
        style={[styles.container, { backgroundColor: themeColors.background }]}
        edges={['bottom']}>
        <View style={styles.emptyState}>
          <Ionicons name="school-outline" size={48} color={themeColors.primary} />
          <Text style={[styles.emptyStateTitle, { color: themeColors.text }]}>
            No students found
          </Text>
          <Text style={[styles.emptyStateMessage, { color: themeColors.textSecondary }]}>
            There are currently no {studentType} exchange students.
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
    ...(Platform.OS === 'ios'
      ? {
          shadowOffset: { width: 0, height: 4 },
          shadowOpacity: 0.08,
          shadowRadius: 20,
          elevation: 4,
        }
      : {}),
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

  studentInfo: {
    flex: 1,
    marginLeft: 16,
  },
  studentName: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 4,
  },
  studentSubtitle: {
    fontSize: 14,
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
