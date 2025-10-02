import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
  TouchableOpacity,
  Linking,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function WhichCountriesScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View style={styles.headerIcon}>
              <Ionicons name="globe-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Met welke landen?</Text>
            <Text style={styles.headerSubtitle}>
              Ontdek de bestemmingen beschikbaar voor Zomerkampen
            </Text>
          </View>

          {/* Main Content */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="globe-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Internationale Bestemmingen</Text>
            </View>

            <View style={styles.regionCard}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇪🇺</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={styles.regionTitle}>Europa</Text>
                <Text style={styles.regionDescription}>
                  Verschillende Europese landen met rijke cultuur en geschiedenis
                </Text>
              </View>
            </View>

            <View style={styles.regionCard}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇨🇦</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={styles.regionTitle}>Canada</Text>
                <Text style={styles.regionDescription}>
                  Prachtige natuur en vriendelijke cultuur in Noord-Amerika
                </Text>
              </View>
            </View>

            <View style={styles.regionCard}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇺🇸</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={styles.regionTitle}>Verenigde Staten</Text>
                <Text style={styles.regionDescription}>
                  Diverse staten met verschillende ervaringen en culturen
                </Text>
              </View>
            </View>

            <View style={styles.regionCard}>
              <View style={styles.regionIcon}>
                <Text style={styles.regionEmoji}>🇹🇼</Text>
              </View>
              <View style={styles.regionContent}>
                <Text style={styles.regionTitle}>Taiwan</Text>
                <Text style={styles.regionDescription}>
                  Fascinierende Aziatische cultuur en moderne technologie
                </Text>
              </View>
            </View>
          </View>

          {/* Program Types */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Soorten Programma&apos;s</Text>
            </View>

            <View style={styles.programCard}>
              <View style={styles.programIcon}>
                <Ionicons name="school-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.programContent}>
                <Text style={styles.programTitle}>Educatieve Tours</Text>
                <Text style={styles.programDescription}>
                  Leren over geschiedenis, cultuur en taal
                </Text>
              </View>
            </View>

            <View style={styles.programCard}>
              <View style={styles.programIcon}>
                <Ionicons name="trail-sign-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.programContent}>
                <Text style={styles.programTitle}>Avontuur Kampen</Text>
                <Text style={styles.programDescription}>
                  Buitenactiviteiten en natuurverkenning
                </Text>
              </View>
            </View>

            <View style={styles.programCard}>
              <View style={styles.programIcon}>
                <Ionicons name="people-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.programContent}>
                <Text style={styles.programTitle}>Culturele Uitwisseling</Text>
                <Text style={styles.programDescription}>
                  Onderdompeling in lokale gewoonten en tradities
                </Text>
              </View>
            </View>
          </View>

          {/* Contact Information */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="mail-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Aanmelden</Text>
            </View>

            <View style={styles.emailCard}>
              <Text style={styles.emailDescription}>
                Aanmelden via het emailadres{' '}
                <Text style={styles.emailLink}>interesse@rotaryyep.nl</Text>
              </Text>
            </View>

            <View style={styles.buttonContainer}>
              <TouchableOpacity
                style={styles.emailButton}
                onPress={() => {
                  const emailUrl =
                    'mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20Zomerkampen';
                  Linking.openURL(emailUrl);
                }}>
                <Ionicons name="mail" size={20} color="#FFFFFF" style={{ marginRight: 8 }} />
                <Text style={styles.emailButtonText}>Contact Opnemen</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: 30,
  },

  // Header Section
  headerSection: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 24,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#FFF3F0',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === 'ios' ? 28 : 24,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    textAlign: 'center',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
    paddingHorizontal: 20,
  },

  // Section Styles
  section: {
    marginBottom: 32,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 12,
  },

  // Destination Header
  destinationHeader: {
    alignItems: 'center',
    marginBottom: 24,
    paddingHorizontal: 16,
  },
  destinationTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: '#1A237E',
    marginBottom: 8,
  },
  destinationSubtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
    fontStyle: 'italic',
  },
  regionCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  regionIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#FFFFFF',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 1 },
          shadowOpacity: 0.1,
          shadowRadius: 2,
        }
      : {
          elevation: 2,
        }),
  },
  regionEmoji: {
    fontSize: 24,
  },
  regionContent: {
    flex: 1,
  },
  regionTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  regionDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },

  // Program Card Styles
  programCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 1,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  programIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  programContent: {
    flex: 1,
  },
  programTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  programDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },

  // Email Card Styles
  emailCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 24,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  emailDescription: {
    fontSize: 16,
    color: '#333',
    lineHeight: 24,
    textAlign: 'center',
  },
  emailLink: {
    color: '#2196F3',
    fontWeight: '600',
  },

  // Button Styles
  buttonContainer: {
    alignItems: 'center',
    marginTop: 8,
  },
  emailButton: {
    backgroundColor: '#FF6B35',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    paddingHorizontal: 24,
    paddingVertical: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    minWidth: 200,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF6B35',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.3,
          shadowRadius: 4,
        }
      : {
          elevation: 3,
        }),
  },
  emailButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '600',
  },
});
