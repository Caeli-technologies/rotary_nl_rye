import React, { useState, useEffect, useCallback } from 'react';
import {
  StyleSheet,
  View,
  Text,
  FlatList,
  Pressable,
  ActivityIndicator,
  Platform,
  Alert,
  RefreshControl,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons, FontAwesome5 } from '@expo/vector-icons';
import { router } from 'expo-router';
import { Image } from 'expo-image';
import { readString } from 'react-native-csv';
import { StatusBar } from 'expo-status-bar';

interface CampTourData {
  startDate: string;
  endDate: string;
  title: string;
  hostCountryCode: string;
  hostCountry: string;
  hostDistrict: string;
  ageMin: string;
  ageMax: string;
  contribution: string;
  invitation: string;
  full: string;
}

interface TravelCardProps extends CampTourData {}

function TravelCard({
  startDate,
  endDate,
  title,
  hostCountryCode,
  hostCountry,
  hostDistrict,
  ageMin,
  ageMax,
  contribution,
  invitation,
  full,
}: TravelCardProps) {
  const hostCountries = hostCountry.split('/');
  const hostCountryCodes = hostCountryCode.split('/');
  const isFull = full && full.trim() !== '';

  const handlePress = () => {
    if (invitation && invitation.trim() !== '') {
      router.push({
        pathname: '/pdf-viewer' as any,
        params: {
          url: invitation,
          title: title,
        },
      });
    }
  };

  return (
    <Pressable
      style={({ pressed }) => [
        styles.card, 
        isFull && styles.cardFull,
        pressed && styles.cardPressed
      ]}
      onPress={handlePress}
      android_ripple={{
        color: 'rgba(0, 122, 255, 0.2)',
        borderless: false
      }}
    >
      <View style={styles.cardHeader}>
        <View style={styles.titleContainer}>
          <Text style={styles.title} numberOfLines={2}>
            {title}
          </Text>
          {isFull && (
            <View style={styles.fullBadge}>
              <Ionicons name="warning" size={14} color="#fff" />
              <Text style={styles.fullBadgeText}>FULL</Text>
            </View>
          )}
        </View>
        {invitation && invitation.trim() !== '' && (
          <View style={styles.actionIndicator}>
            <Ionicons name="document-text-outline" size={18} color="#666" />
          </View>
        )}
      </View>

      <View style={styles.cardBody}>
        <View style={styles.dateContainer}>
          <Ionicons name="calendar-outline" size={16} color="#007AFF" />
          <Text style={styles.dateText}>
            {startDate} - {endDate}
          </Text>
        </View>

        <View style={styles.detailsGrid}>
          <View style={styles.detailItem}>
            <View style={styles.detailHeader}>
              <Ionicons name="location-outline" size={14} color="#666" />
              <Text style={styles.detailLabel}>Country</Text>
            </View>
            <View style={styles.countryContainer}>
              {hostCountries.map((country, index) => (
                <View key={index} style={styles.countryItem}>
                  {hostCountryCodes[index] && (
                    <Image
                      source={{
                        uri: `https://flagcdn.com/w20/${hostCountryCodes[index].toLowerCase()}.png`,
                      }}
                      style={styles.flag}
                    />
                  )}
                  <Text style={styles.countryText}>{country.trim()}</Text>
                </View>
              ))}
            </View>
          </View>

          <View style={styles.detailItem}>
            <View style={styles.detailHeader}>
              <Ionicons name="business-outline" size={14} color="#666" />
              <Text style={styles.detailLabel}>District</Text>
            </View>
            <Text style={styles.detailValue}>{hostDistrict}</Text>
          </View>

          <View style={styles.detailRow}>
            <View style={styles.detailItem}>
              <View style={styles.detailHeader}>
                <Ionicons name="people-outline" size={14} color="#666" />
                <Text style={styles.detailLabel}>Age</Text>
              </View>
              <Text style={styles.detailValue}>{ageMin}-{ageMax} yrs</Text>
            </View>

            <View style={styles.detailItem}>
              <View style={styles.detailHeader}>
                <Ionicons name="card-outline" size={14} color="#666" />
                <Text style={styles.detailLabel}>Cost</Text>
              </View>
              <Text style={styles.detailValue}>{contribution}</Text>
            </View>
          </View>
        </View>
      </View>
    </Pressable>
  );
}

export default function CampsToursScreen() {
  const [data, setData] = useState<CampTourData[]>([]);
  const [filteredData, setFilteredData] = useState<CampTourData[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    hideFullCamps: false,
    maxAge: '',
    minAge: '',
    country: '',
  });
  const [availableCountries, setAvailableCountries] = useState<string[]>([]);
  const [availableAges, setAvailableAges] = useState<{ min: number[]; max: number[] }>({ min: [], max: [] });

  const fetchCsvData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const response = await fetch(
        'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv'
      );

      if (!response.ok) {
        throw new Error('Failed to load CSV data');
      }

      const csvText = await response.text();
      
      // Parse CSV with semicolon delimiter using react-native-csv
      const parsedData = readString(csvText, {
        delimiter: ';',
        skipEmptyLines: true,
      });

      // Skip header row and convert to objects
      const formattedData: CampTourData[] = parsedData.data.slice(1).map((row: unknown) => {
        const rowArray = row as any[];
        return {
          startDate: rowArray[0]?.toString() || '',
          endDate: rowArray[1]?.toString() || '',
          title: rowArray[2]?.toString() || '',
          hostCountryCode: rowArray[3]?.toString() || '',
          hostCountry: rowArray[4]?.toString() || '',
          hostDistrict: rowArray[5]?.toString() || '',
          ageMin: rowArray[6]?.toString() || '',
          ageMax: rowArray[7]?.toString() || '',
          contribution: rowArray[8]?.toString() || '',
          invitation: rowArray[9]?.toString() || '',
          full: rowArray[10]?.toString() || '',
        };
      });

      setData(formattedData);
      setFilteredData(formattedData);
      
      // Extract unique countries for filter
      const countries = new Set<string>();
      const minAges = new Set<number>();
      const maxAges = new Set<number>();
      
      formattedData.forEach(item => {
        // Extract countries
        const countryList = item.hostCountry.split('/');
        countryList.forEach(country => {
          if (country.trim()) {
            countries.add(country.trim());
          }
        });
        
        // Extract age ranges
        const minAge = parseInt(item.ageMin);
        const maxAge = parseInt(item.ageMax);
        if (!isNaN(minAge)) {
          minAges.add(minAge);
        }
        if (!isNaN(maxAge)) {
          maxAges.add(maxAge);
        }
      });
      
      setAvailableCountries(Array.from(countries).sort());
      setAvailableAges({
        min: Array.from(minAges).sort((a, b) => a - b),
        max: Array.from(maxAges).sort((a, b) => a - b)
      });
    } catch (err) {
      console.error('Error fetching CSV data:', err);
      setError('Failed to load camps and tours data. Please try again.');
    } finally {
      setLoading(false);
    }
  }, []);

  const applyFilters = () => {
    let filtered = [...data];

    // Hide full camps
    if (filters.hideFullCamps) {
      filtered = filtered.filter(item => !item.full || item.full.trim() === '');
    }

    // Age filter
    if (filters.minAge || filters.maxAge) {
      filtered = filtered.filter(item => {
        const minAge = parseInt(filters.minAge) || 0;
        const maxAge = parseInt(filters.maxAge) || 999;
        const itemMinAge = parseInt(item.ageMin) || 0;
        const itemMaxAge = parseInt(item.ageMax) || 999;
        
        return itemMinAge >= minAge && itemMaxAge <= maxAge;
      });
    }

    // Country filter
    if (filters.country) {
      filtered = filtered.filter(item => 
        item.hostCountry.toLowerCase().includes(filters.country.toLowerCase())
      );
    }

    setFilteredData(filtered);
  };

  const clearFilters = () => {
    setFilters({
      hideFullCamps: false,
      maxAge: '',
      minAge: '',
      country: '',
    });
    setFilteredData(data);
  };

  const hasActiveFilters = filters.hideFullCamps || filters.minAge || filters.maxAge || filters.country;

  useEffect(() => {
    fetchCsvData();
  }, []);

  useEffect(() => {
    applyFilters();
  }, [filters, data]);

  return (
    <SafeAreaView style={styles.safeArea} edges={['top']}>
      <StatusBar style="auto" />
      {/* Header */}
      <View style={styles.header}>
        <Pressable
          style={({ pressed }) => [
            styles.headerButton,
            pressed && styles.headerButtonPressed
          ]}
          onPress={() => router.back()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons name="chevron-back" size={28} color="#007AFF" />
        </Pressable>
        
        <View style={styles.headerTitleContainer}>
          <Text style={styles.headerTitle}>Camps & Tours</Text>
          <Text style={styles.headerSubtitle}>
            {loading ? 'Loading...' : `${filteredData.length} of ${data.length} camps`}
          </Text>
        </View>
        
        <Pressable
          style={({ pressed }) => [
            styles.headerButton, 
            hasActiveFilters && styles.headerButtonActive,
            pressed && styles.headerButtonPressed
          ]}
          onPress={() => setShowFilters(!showFilters)}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          {hasActiveFilters && !showFilters && (
            <View style={styles.filterBadge}>
              <Text style={styles.filterBadgeText}>●</Text>
            </View>
          )}
          <Ionicons 
            name={showFilters ? "close" : (hasActiveFilters ? "funnel" : "funnel-outline")} 
            size={24} 
            color="#007AFF" 
          />
        </Pressable>
      </View>

      {/* Filter Panel */}
      {showFilters && (
        <View style={styles.filterPanel}>
          <View style={styles.filterHeader}>
            <Text style={styles.filterTitle}>Filter Camps</Text>
            {hasActiveFilters && (
              <Pressable onPress={clearFilters}>
                <Text style={styles.clearFiltersText}>Clear All</Text>
              </Pressable>
            )}
          </View>
          
          <View style={styles.filterContent}>
            <Pressable
              style={({ pressed }) => [
                styles.filterOption,
                pressed && styles.filterOptionPressed
              ]}
              onPress={() => setFilters(prev => ({ ...prev, hideFullCamps: !prev.hideFullCamps }))}
            >
              <View style={styles.filterOptionLeft}>
                <Ionicons 
                  name={filters.hideFullCamps ? "checkbox" : "square-outline"} 
                  size={20} 
                  color={filters.hideFullCamps ? "#007AFF" : "#C7C7CC"} 
                />
                <Text style={styles.filterOptionText}>Hide full camps</Text>
              </View>
            </Pressable>

            <View style={styles.filterRow}>
              <View style={styles.filterInputContainer}>
                <Text style={styles.filterLabel}>Min Age</Text>
                <Pressable 
                  style={({ pressed }) => [
                    styles.textInput,
                    pressed && styles.textInputPressed
                  ]}
                  onPress={() => {
                    if (Platform.OS === 'ios') {
                      Alert.prompt(
                        'Minimum Age',
                        'Enter minimum age (numbers only):',
                        [
                          {
                            text: 'Cancel',
                            style: 'cancel',
                          },
                          {
                            text: 'OK',
                            onPress: (text?: string) => {
                              if (text && /^\d+$/.test(text)) {
                                setFilters(prev => ({ ...prev, minAge: text }));
                              } else if (text && !/^\d+$/.test(text)) {
                                Alert.alert('Invalid Input', 'Please enter numbers only.');
                              }
                            },
                          },
                        ],
                        'plain-text',
                        filters.minAge,
                        'number-pad'
                      );
                    } else {
                      // Android fallback - show selection of ages from CSV data
                      const ageOptions = availableAges.min.map(age => age.toString());
                      Alert.alert(
                        'Select Minimum Age',
                        'Choose minimum age:',
                        [
                          { text: 'Clear', onPress: () => setFilters(prev => ({ ...prev, minAge: '' })) },
                          ...ageOptions.map(age => ({
                            text: age,
                            onPress: () => setFilters(prev => ({ ...prev, minAge: age }))
                          })),
                          { text: 'Cancel', style: 'cancel' }
                        ],
                        { cancelable: true }
                      );
                    }
                  }}
                >
                  <Text style={styles.textInputText}>
                    {filters.minAge || 'Any'}
                  </Text>
                </Pressable>
              </View>
              
              <View style={styles.filterInputContainer}>
                <Text style={styles.filterLabel}>Max Age</Text>
                <Pressable 
                  style={({ pressed }) => [
                    styles.textInput,
                    pressed && styles.textInputPressed
                  ]}
                  onPress={() => {
                    if (Platform.OS === 'ios') {
                      Alert.prompt(
                        'Maximum Age',
                        'Enter maximum age (numbers only):',
                        [
                          {
                            text: 'Cancel',
                            style: 'cancel',
                          },
                          {
                            text: 'OK',
                            onPress: (text?: string) => {
                              if (text && /^\d+$/.test(text)) {
                                setFilters(prev => ({ ...prev, maxAge: text }));
                              } else if (text && !/^\d+$/.test(text)) {
                                Alert.alert('Invalid Input', 'Please enter numbers only.');
                              }
                            },
                          },
                        ],
                        'plain-text',
                        filters.maxAge,
                        'number-pad'
                      );
                    } else {
                      // Android fallback - show selection of ages from CSV data
                      const ageOptions = availableAges.max.map(age => age.toString());
                      Alert.alert(
                        'Select Maximum Age',
                        'Choose maximum age:',
                        [
                          { text: 'Clear', onPress: () => setFilters(prev => ({ ...prev, maxAge: '' })) },
                          ...ageOptions.map(age => ({
                            text: age,
                            onPress: () => setFilters(prev => ({ ...prev, maxAge: age }))
                          })),
                          { text: 'Cancel', style: 'cancel' }
                        ],
                        { cancelable: true }
                      );
                    }
                  }}
                >
                  <Text style={styles.textInputText}>
                    {filters.maxAge || 'Any'}
                  </Text>
                </Pressable>
              </View>
            </View>

            <View style={styles.filterInputContainer}>
              <Text style={styles.filterLabel}>Country</Text>
              <Pressable 
                style={({ pressed }) => [
                  styles.textInput,
                  pressed && styles.textInputPressed
                ]}
                onPress={() => {
                  // Show all available countries
                  Alert.alert(
                    'Select Country',
                    'Choose a country to filter by:',
                    [
                      { 
                        text: 'All countries', 
                        onPress: () => setFilters(prev => ({ ...prev, country: '' })),
                        style: 'default'
                      },
                      ...availableCountries.map((country) => ({
                        text: country,
                        onPress: () => setFilters(prev => ({ ...prev, country })),
                        style: 'default' as const
                      })),
                      { 
                        text: 'Cancel', 
                        style: 'cancel'
                      }
                    ],
                    { 
                      cancelable: true,
                      onDismiss: () => {}
                    }
                  );
                }}
              >
                <Text style={styles.textInputText}>
                  {filters.country || 'All countries'}
                </Text>
                <View style={styles.dropdownIcon}>
                  <Ionicons name="chevron-down" size={16} color="#8E8E93" />
                </View>
              </Pressable>
            </View>
          </View>
        </View>
      )}

      {/* Content */}
      <View style={styles.container}>
        {loading ? (
          <View style={styles.centerContainer}>
            <ActivityIndicator size="large" color="#007AFF" />
            <Text style={styles.loadingText}>Loading camps and tours...</Text>
          </View>
        ) : error ? (
          <View style={styles.centerContainer}>
            <View style={styles.errorIcon}>
              <Ionicons name="warning-outline" size={64} color="#FF3B30" />
            </View>
            <Text style={styles.errorTitle}>Oops! Something went wrong</Text>
            <Text style={styles.errorText}>{error}</Text>
            <Pressable 
              style={({ pressed }) => [
                styles.retryButton,
                pressed && styles.retryButtonPressed
              ]} 
              onPress={fetchCsvData}
            >
              <Text style={styles.retryButtonText}>Try Again</Text>
            </Pressable>
          </View>
        ) : (
          <FlatList
            data={filteredData}
            renderItem={({ item }) => <TravelCard {...item} />}
            keyExtractor={(item, index) => `${item.title}-${index}`}
            style={styles.flatList}
            contentContainerStyle={[
              styles.listContent,
              filteredData.length === 0 && styles.emptyContent
            ]}
            showsVerticalScrollIndicator={false}
            contentInsetAdjustmentBehavior="automatic"
            refreshControl={
              <RefreshControl
                refreshing={loading}
                onRefresh={fetchCsvData}
                colors={['#007AFF']}
                tintColor="#007AFF"
              />
            }
            ListEmptyComponent={() => {
              if (data.length > 0) {
                return (
                  <View style={styles.emptyContainer}>
                    <View style={styles.emptyIcon}>
                      <Ionicons name="search-outline" size={64} color="#C7C7CC" />
                    </View>
                    <Text style={styles.emptyTitle}>No Matching Camps</Text>
                    <Text style={styles.emptyText}>
                      Try adjusting your filters to see more results.
                    </Text>
                  </View>
                );
              } else {
                return (
                  <View style={styles.emptyContainer}>
                    <View style={styles.emptyIcon}>
                      <Ionicons name="calendar-outline" size={64} color="#C7C7CC" />
                    </View>
                    <Text style={styles.emptyTitle}>No Camps Available</Text>
                    <Text style={styles.emptyText}>
                      There are currently no camps or tours available. Check back later!
                    </Text>
                  </View>
                );
              }
            }}
            ItemSeparatorComponent={() => <View style={styles.itemSeparator} />}
          />
        )}
      </View>


    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'android' ? 16 : 8,
    paddingBottom: 16,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
  },
  headerButton: {
    width: 44,
    height: 44,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 22,
  },
  headerButtonDisabled: {
    opacity: 0.5,
  },
  headerTitleContainer: {
    flex: 1,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 17,
    fontWeight: '600',
    color: '#000000',
    letterSpacing: -0.41,
  },
  headerSubtitle: {
    fontSize: 13,
    fontWeight: '400',
    color: '#8E8E93',
    marginTop: 2,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 34,
  },
  card: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    marginBottom: 12,
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
    overflow: 'hidden',
  },
  cardFull: {
    borderLeftWidth: 4,
    borderLeftColor: '#FF3B30',
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 16,
    paddingBottom: 8,
  },
  titleContainer: {
    flex: 1,
    marginRight: 12,
  },
  title: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    lineHeight: 22,
    marginBottom: 4,
  },
  fullBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FF3B30',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: 'flex-start',
  },
  fullBadgeText: {
    color: '#FFFFFF',
    fontSize: 11,
    fontWeight: '600',
    marginLeft: 4,
    letterSpacing: 0.5,
  },
  actionIndicator: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#F2F2F7',
    justifyContent: 'center',
    alignItems: 'center',
  },
  cardBody: {
    paddingHorizontal: 16,
    paddingBottom: 16,
  },
  dateContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F2F2F7',
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 8,
    marginBottom: 16,
  },
  dateText: {
    fontSize: 14,
    fontWeight: '500',
    color: '#007AFF',
    marginLeft: 8,
  },
  detailsGrid: {
    gap: 16,
  },
  detailRow: {
    flexDirection: 'row',
    gap: 16,
  },
  detailItem: {
    flex: 1,
  },
  detailHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 6,
  },
  detailLabel: {
    fontSize: 13,
    fontWeight: '500',
    color: '#8E8E93',
    marginLeft: 6,
  },
  detailValue: {
    fontSize: 15,
    fontWeight: '500',
    color: '#000000',
  },
  countryContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  countryItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F2F2F7',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
  },
  countryText: {
    fontSize: 14,
    fontWeight: '500',
    color: '#000000',
  },
  flag: {
    width: 16,
    height: 12,
    marginRight: 6,
    borderRadius: 2,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 32,
  },
  loadingText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    marginTop: 16,
    textAlign: 'center',
  },
  errorIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#FFEBEE',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  errorTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#000000',
    textAlign: 'center',
    marginBottom: 8,
  },
  errorText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    textAlign: 'center',
    lineHeight: 22,
    marginBottom: 32,
    paddingHorizontal: 20,
  },
  retryButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 32,
    paddingVertical: 14,
    borderRadius: 8,
    minWidth: 120,
  },
  retryButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
  },
  emptyContainer: {
    alignItems: 'center',
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#F2F2F7',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#000000',
    textAlign: 'center',
    marginBottom: 8,
  },
  emptyText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    textAlign: 'center',
    lineHeight: 22,
  },
  headerButtonActive: {
    backgroundColor: 'transparent',
  },
  filterPanel: {
    backgroundColor: '#FFFFFF',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
    paddingHorizontal: 20,
    paddingTop: 16,
    paddingBottom: 60,
  },
  filterHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  filterTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
  },
  clearFiltersText: {
    fontSize: 14,
    fontWeight: '500',
    color: '#007AFF',
  },
  filterContent: {
    gap: 16,
  },
  filterOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 8,
  },
  filterOptionLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  filterOptionText: {
    fontSize: 15,
    fontWeight: '400',
    color: '#000000',
    marginLeft: 12,
  },
  filterRow: {
    flexDirection: 'row',
    gap: 16,
  },
  filterInputContainer: {
    flex: 1,
  },
  filterLabel: {
    fontSize: 13,
    fontWeight: '500',
    color: '#8E8E93',
    marginBottom: 6,
  },
  textInput: {
    backgroundColor: '#F2F2F7',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    minHeight: 40,
    justifyContent: 'center',
    flexDirection: 'row',
    alignItems: 'center',
  },
  textInputText: {
    fontSize: 15,
    fontWeight: '400',
    color: '#000000',
    flex: 1,
  },
  dropdownIcon: {
    marginLeft: 8,
  },
  filterBadge: {
    position: 'absolute',
    top: 4,
    right: 4,
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#FF3B30',
    zIndex: 1,
  },
  filterBadgeText: {
    fontSize: 8,
    color: '#FF3B30',
    fontWeight: 'bold',
  },
  // Native component pressed states
  cardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 1,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  headerButtonPressed: {
    opacity: Platform.OS === 'ios' ? 0.6 : 0.8,
    backgroundColor: Platform.OS === 'ios' ? 'rgba(0, 122, 255, 0.1)' : '#E0E0E0',
  },
  filterOptionPressed: {
    backgroundColor: Platform.OS === 'ios' ? 'rgba(0, 122, 255, 0.05)' : '#F5F5F5',
  },
  textInputPressed: {
    backgroundColor: Platform.OS === 'ios' ? '#E8E8ED' : '#E0E0E0',
  },
  retryButtonPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.9,
    backgroundColor: Platform.OS === 'ios' ? '#0056CC' : '#005BB5',
  },
  // FlatList styles
  flatList: {
    flex: 1,
  },
  listContent: {
    padding: 16,
    paddingBottom: 34,
  },
  emptyContent: {
    flexGrow: 1,
    justifyContent: 'center',
  },
  itemSeparator: {
    height: 0, // No separator needed since cards have margin
  },
});