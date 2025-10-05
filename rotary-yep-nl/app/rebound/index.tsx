import React, { useMemo, useCallback } from 'react';
import { StyleSheet, View, Text, Pressable, FlatList, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router } from 'expo-router';
import * as Haptics from 'expo-haptics';

import { StudentsData } from '../../types/student';
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

interface CountryStats {
  country: string;
  flag: string;
  totalStudents: number;
  years: string[];
}

interface CountryCardProps {
  country: CountryStats;
  onPress: () => void;
  themeColors: typeof Colors.light;
  styles: any;
}

function CountryCard({ country, onPress, themeColors, styles }: CountryCardProps) {
  const flagAsset = getFlagAsset(country.flag);

  return (
    <Pressable
      style={({ pressed }) => [
        styles.countryCard,
        { backgroundColor: themeColors.card, borderColor: themeColors.border },
        pressed && styles.countryCardPressed,
      ]}
      onPress={onPress}
      android_ripple={{
        color: 'rgba(0, 122, 255, 0.2)',
        borderless: false,
      }}
      accessibilityRole="button"
      accessibilityLabel={`View students who went to ${country.country}`}
      accessibilityHint="Tap to view list of exchange students"
      hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}>
      <View style={styles.countryCardContent}>
        {flagAsset ? (
          <Image source={flagAsset} style={styles.flagImage} contentFit="contain" />
        ) : (
          <View
            style={[
              styles.flagImage,
              styles.flagPlaceholder,
              { backgroundColor: themeColors.backgroundElevated },
            ]}>
            <Text style={[styles.flagText, { color: themeColors.textTertiary }]}>
              {country.flag.toUpperCase()}
            </Text>
          </View>
        )}
        <View style={styles.countryInfo}>
          <Text style={[styles.countryName, { color: themeColors.text }]}>{country.country}</Text>
          <Text style={[styles.countryStudentCount, { color: themeColors.textSecondary }]}>
            {country.totalStudents} student
            {country.totalStudents !== 1 ? 's' : ''}
          </Text>
        </View>
        <Ionicons name="chevron-forward" size={20} color={themeColors.primary} />
      </View>
    </Pressable>
  );
}

export default function ReboundCountriesScreen() {
  const { colors: themeColors } = useTheme();

  const handleCountryPress = useCallback(async (country: CountryStats) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push({
        pathname: '/rebound/students' as any,
        params: {
          country: country.country,
          flag: country.flag,
        },
      });
    } catch (error) {
      console.error('Error navigating to students:', error);
      // Still navigate even if haptics fail
      router.push({
        pathname: '/rebound/students' as any,
        params: {
          country: country.country,
          flag: country.flag,
        },
      });
    }
  }, []);

  // Get all unique countries across all years with their statistics
  const countries = useMemo(() => {
    const countryMap = new Map<string, { flag: string; students: number; years: Set<string> }>();

    Object.entries(data.list).forEach(([year, students]) => {
      students.forEach((student) => {
        const existing = countryMap.get(student.to);
        if (existing) {
          existing.students++;
          existing.years.add(year);
        } else {
          countryMap.set(student.to, {
            flag: student.toFlag,
            students: 1,
            years: new Set([year]),
          });
        }
      });
    });

    return Array.from(countryMap.entries())
      .map(([country, stats]) => ({
        country,
        flag: stats.flag,
        totalStudents: stats.students,
        years: Array.from(stats.years).sort((a, b) => b.localeCompare(a)),
      }))
      .sort((a, b) => b.totalStudents - a.totalStudents); // Sort by most students first
  }, []);

  const renderCountry = useCallback(
    ({ item }: { item: CountryStats }) => (
      <CountryCard
        country={item}
        onPress={() => handleCountryPress(item)}
        themeColors={themeColors}
        styles={styles}
      />
    ),
    [handleCountryPress, themeColors],
  );

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={[]}>
      <FlatList
        data={countries}
        renderItem={renderCountry}
        keyExtractor={(item) => item.country}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.contentContainer}
        ItemSeparatorComponent={() => <View style={styles.separator} />}
        removeClippedSubviews={true}
        initialNumToRender={15}
        maxToRenderPerBatch={10}
        windowSize={10}
        getItemLayout={(data, index) => ({
          length: 76, // 64 (card min-height) + 12 (separator)
          offset: 76 * index,
          index,
        })}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  contentContainer: {
    paddingTop: 20,
    paddingBottom: 20,
  },
  countryCard: {
    borderRadius: 12,
    marginHorizontal: 16,
    ...shadowStyle,
  },
  countryCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  countryCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    minHeight: 64,
  },
  flagImage: {
    width: 48,
    height: 32,
    marginRight: 16,
  },
  countryInfo: {
    flex: 1,
  },
  countryName: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  countryStudentCount: {
    fontSize: 14,
  },
  separator: {
    height: 12,
  },
  flagPlaceholder: {
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 4,
  },
  flagText: {
    fontSize: 10,
    fontWeight: '600',
  },
});
