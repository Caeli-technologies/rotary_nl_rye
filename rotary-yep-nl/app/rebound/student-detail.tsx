import React, { useMemo } from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  Dimensions,
  Linking,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useLocalSearchParams } from 'expo-router';
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

interface ActionButtonProps {
  icon: keyof typeof Ionicons.glyphMap;
  title: string;
  subtitle?: string;
  onPress: () => void;
  disabled?: boolean;
}

function ActionButton({ icon, title, subtitle, onPress, disabled = false }: ActionButtonProps) {
  return (
    <TouchableOpacity 
      style={[styles.actionButton, disabled && styles.actionButtonDisabled]} 
      onPress={onPress} 
      activeOpacity={disabled ? 1 : 0.7}
      disabled={disabled}
    >
      <View style={styles.actionButtonContent}>
        <View style={[styles.actionIconContainer, disabled && styles.actionIconDisabled]}>
          <Ionicons name={icon} size={24} color={disabled ? "#999" : "#9FA8DA"} />
        </View>
        <View style={styles.actionTextContainer}>
          <Text style={[styles.actionTitle, disabled && styles.actionTitleDisabled]}>{title}</Text>
          {subtitle && (
            <Text style={[styles.actionSubtitle, disabled && styles.actionSubtitleDisabled]}>
              {subtitle}
            </Text>
          )}
        </View>
        {!disabled && <Ionicons name="chevron-forward" size={20} color="#9FA8DA" />}
      </View>
    </TouchableOpacity>
  );
}

export default function StudentDetailScreen() {
  const params = useLocalSearchParams<{
    year: string;
    country: string;
    studentName: string;
  }>();

  const student = useMemo(() => {
    if (!params.year || !params.studentName) return null;
    
    const studentsForYear = data.list[params.year] || [];
    return studentsForYear.find(s => s.name === params.studentName) || null;
  }, [params.year, params.studentName]);

  const fromFlagAsset = student ? getFlagAsset(student.fromFlag) : null;
  const toFlagAsset = student ? getFlagAsset(student.toFlag) : null;

  const handleVideoPress = () => {
    if (student?.videoUrl) {
      Linking.openURL(student.videoUrl);
    }
  };

  const handleEmailPress = () => {
    // This could be extended to include actual email functionality
    // For now, we'll show it as disabled since emails aren't in the data
  };

  if (!student) {
    return (
      <SafeAreaView style={styles.container}>
        <StatusBar style="auto" />
        
        <View style={styles.errorContainer}>
          <Ionicons name="person-outline" size={64} color="#9FA8DA" />
          <Text style={styles.errorTitle}>Student Not Found</Text>
          <Text style={styles.errorMessage}>
            The student information could not be loaded. Please try again.
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        {/* Hero Section */}
        <View style={styles.heroSection}>
          <NetworkImage
            imageUrl={student.imageUrl}
            name={student.name}
            size={120}
            expandable={true}
          />
          
          <Text style={styles.studentName}>{student.name}</Text>
          <Text style={styles.studentDescription}>{student.description}</Text>
        </View>

        {/* Exchange Info Card */}
        <View style={styles.exchangeCard}>
          <View style={styles.exchangeHeader}>
            <Ionicons name="airplane-outline" size={24} color="#9FA8DA" />
            <Text style={styles.exchangeTitle}>Exchange Details</Text>
          </View>
          
          <View style={styles.exchangeRoute}>
            <View style={styles.exchangeCountry}>
              <View style={styles.exchangeCountryHeader}>
                {fromFlagAsset ? (
                  <Image
                    source={fromFlagAsset}
                    style={styles.exchangeFlag}
                    contentFit="contain"
                  />
                ) : (
                  <View style={[styles.exchangeFlag, styles.flagPlaceholder]}>
                    <Text style={styles.flagText}>{student.fromFlag.toUpperCase()}</Text>
                  </View>
                )}
                <Text style={styles.exchangeLabel}>From</Text>
              </View>
              <Text style={styles.exchangeCountryName}>{student.from}</Text>
            </View>

            <View style={styles.exchangeArrow}>
              <Ionicons name="arrow-forward" size={24} color="#9FA8DA" />
            </View>

            <View style={styles.exchangeCountry}>
              <View style={styles.exchangeCountryHeader}>
                {toFlagAsset ? (
                  <Image
                    source={toFlagAsset}
                    style={styles.exchangeFlag}
                    contentFit="contain"
                  />
                ) : (
                  <View style={[styles.exchangeFlag, styles.flagPlaceholder]}>
                    <Text style={styles.flagText}>{student.toFlag.toUpperCase()}</Text>
                  </View>
                )}
                <Text style={styles.exchangeLabel}>To</Text>
              </View>
              <Text style={styles.exchangeCountryName}>{student.to}</Text>
            </View>
          </View>

          <View style={styles.yearBadge}>
            <Text style={styles.yearText}>{params.year}</Text>
          </View>
        </View>

        {/* Bio Section */}
        {student.bio && student.bio.trim() !== '' && (
          <View style={styles.bioCard}>
            <View style={styles.bioHeader}>
              <Ionicons name="document-text-outline" size={24} color="#9FA8DA" />
              <Text style={styles.bioTitle}>Biography</Text>
            </View>
            <Text style={styles.bioText}>{student.bio}</Text>
          </View>
        )}

        {/* Actions */}
        <View style={styles.actionsSection}>
          <Text style={styles.sectionTitle}>Actions</Text>
          
          <ActionButton
            icon="play-circle-outline"
            title="Watch Video"
            subtitle={student.videoUrl ? "View exchange experience" : "Video not available"}
            onPress={handleVideoPress}
            disabled={!student.videoUrl}
          />
          
          <ActionButton
            icon="mail-outline"
            title="Contact Student"
            subtitle="Send an email"
            onPress={handleEmailPress}
            disabled={true} // Disabled since email info is not in the data
          />
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
  heroSection: {
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingTop: 32,
    paddingBottom: 32,
  },

  studentName: {
    fontSize: 28,
    fontWeight: '700',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  studentDescription: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
  },
  exchangeCard: {
    backgroundColor: '#F5F5F5',
    borderRadius: 16,
    margin: 16,
    padding: 20,
    ...shadowStyle,
  },
  exchangeHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  exchangeTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 12,
  },
  exchangeRoute: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginBottom: 20,
  },
  exchangeCountry: {
    flex: 1,
    alignItems: 'center',
  },
  exchangeCountryHeader: {
    alignItems: 'center',
    marginBottom: 8,
  },
  exchangeFlag: {
    width: 40,
    height: 27,
    marginBottom: 8,
  },
  exchangeLabel: {
    fontSize: 12,
    color: '#666',
    fontWeight: '500',
    textTransform: 'uppercase',
    letterSpacing: 0.5,
  },
  exchangeCountryName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    textAlign: 'center',
  },
  exchangeArrow: {
    marginHorizontal: 20,
  },
  yearBadge: {
    backgroundColor: '#E8EAF6',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    alignSelf: 'center',
  },
  yearText: {
    fontSize: 14,
    fontWeight: '600',
    color: '#1A237E',
  },
  bioCard: {
    backgroundColor: '#F5F5F5',
    borderRadius: 16,
    margin: 16,
    padding: 20,
    ...shadowStyle,
  },
  bioHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  bioTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 12,
  },
  bioText: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
  },
  actionsSection: {
    paddingHorizontal: 16,
    paddingBottom: 32,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 16,
  },
  actionButton: {
    backgroundColor: '#F5F5F5',
    borderRadius: 12,
    marginBottom: 12,
    ...shadowStyle,
  },
  actionButtonDisabled: {
    backgroundColor: '#F9F9F9',
    opacity: 0.6,
  },
  actionButtonContent: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
  },
  actionIconContainer: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: '#E8EAF6',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  actionIconDisabled: {
    backgroundColor: '#F0F0F0',
  },
  actionTextContainer: {
    flex: 1,
  },
  actionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 2,
  },
  actionTitleDisabled: {
    color: '#999',
  },
  actionSubtitle: {
    fontSize: 14,
    color: '#666',
  },
  actionSubtitleDisabled: {
    color: '#999',
  },
  flagPlaceholder: {
    backgroundColor: '#E0E0E0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  flagText: {
    fontSize: 10,
    color: '#666',
    fontWeight: '600',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: 32,
  },
  errorTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: '#1A237E',
    marginTop: 16,
    marginBottom: 8,
  },
  errorMessage: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
  },
});