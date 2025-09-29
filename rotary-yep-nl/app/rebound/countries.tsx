import React, { useMemo } from 'react';
import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  FlatList,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { StudentsData } from '../../types/student';
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

interface CountryStats {
  country: string;
  flag: string;
  totalStudents: number;
  years: string[];
}

interface CountryCardProps {
  country: CountryStats;
  onPress: () => void;
}

function CountryCard({ country, onPress }: CountryCardProps) {
  const flagAsset = getFlagAsset(country.flag);

  return (
    <TouchableOpacity style={styles.countryCard} onPress={onPress} activeOpacity={0.7}>
      <View style={styles.countryCardContent}>
        {flagAsset ? (
          <Image
            source={flagAsset}
            style={styles.flagImage}
            contentFit="contain"
          />
        ) : (
          <View style={[styles.flagImage, styles.flagPlaceholder]}>
            <Text style={styles.flagText}>{country.flag.toUpperCase()}</Text>
          </View>
        )}
        <View style={styles.countryInfo}>
          <Text style={styles.countryName}>{country.country}</Text>
          <Text style={styles.countryStudentCount}>
            {country.totalStudents} student{country.totalStudents !== 1 ? 's' : ''}
          </Text>
        </View>
        <Ionicons name="chevron-forward" size={20} color="#9FA8DA" />
      </View>
    </TouchableOpacity>
  );
}

export default function ReboundCountriesScreen() {
  // Get all unique countries across all years with their statistics
  const countries = useMemo(() => {
    const countryMap = new Map<string, { flag: string; students: number; years: Set<string> }>();
    
    Object.entries(data.list).forEach(([year, students]) => {
      students.forEach(student => {
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

  const handleCountryPress = (country: CountryStats) => {
    router.push({
      pathname: '/rebound/students' as any,
      params: {
        country: country.country,
        flag: country.flag,
      },
    });
  };

  const renderCountry = ({ item }: { item: CountryStats }) => (
    <CountryCard country={item} onPress={() => handleCountryPress(item)} />
  );

  return (
    <SafeAreaView style={styles.container} edges={[]}>
      <StatusBar style="auto" />
      
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
    backgroundColor: '#F2F2F7',
  },
  contentContainer: {
    paddingTop: 20,
    paddingBottom: 20,
  },
  countryCard: {
    backgroundColor: '#F5F5F5',
    borderRadius: 12,
    marginHorizontal: 16,
    ...shadowStyle,
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
    color: '#1A237E',
    marginBottom: 4,
  },
  countryStudentCount: {
    fontSize: 14,
    color: '#666',
  },
  separator: {
    height: 12,
  },
  flagPlaceholder: {
    backgroundColor: '#E0E0E0',
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 4,
  },
  flagText: {
    fontSize: 10,
    color: '#666',
    fontWeight: '600',
  },
});