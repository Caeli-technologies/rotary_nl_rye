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

export default function FamilyToFamilyScreen() {
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
              <Ionicons name="home-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Family To Family</Text>
            <Text style={styles.headerSubtitle}>
              Short Term Exchange Program (STEP) voor 2x3 of 2x4 weken
            </Text>
          </View>

          {/* What is it Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="help-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Wat is het?</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                De naam zegt het al, Short Term Exchange Program (STEP). Het is een uitwisseling met
                een leeftijdgenoot in het buitenland voor de korte duur van ongeveer 2x3 weken of
                2x4 weken tijdens de zomervakantie. Maar het is ook FAMILY TO FAMILY, wat betekent
                dat je bij een gezin in het buitenland woont, samen met jouw maatje, en dat jouw
                maatje samen met jou in Nederland komt wonen.
              </Text>
            </View>
          </View>

          {/* Age Card */}
          <View style={styles.ageCard}>
            <View style={styles.ageIconContainer}>
              <Ionicons name="people" size={28} color="#9C27B0" />
            </View>
            <View style={styles.ageContent}>
              <Text style={styles.ageTitle}>15 - 19 jaar</Text>
              <Text style={styles.ageSubtitle}>Voor wie?</Text>
              <Text style={styles.ageNote}>Open minded jongeren die willen leren van anderen</Text>
            </View>
          </View>

          {/* Mission Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Waarom doen we dit?</Text>
            </View>

            <View style={styles.missionCard}>
              <View style={styles.missionHeader}>
                <Ionicons name="star" size={20} color="#FFD700" />
                <Text style={styles.missionTitle}>Onze Missie</Text>
              </View>
              <Text style={styles.missionText}>
                "Jeugd in staat stellen om persoonlijk leiderschap te ontwikkelen"
              </Text>
              <Text style={styles.missionSubtext}>
                Wij geloven dat leiderschap begint met leiding geven aan jezelf om uiteindelijk
                anderen in staat te stellen zichzelf te ontwikkelen.
              </Text>
            </View>
          </View>

          {/* Requirements Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="checkmark-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Geschikt voor dit programma?</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>Je bent geschikt als je:</Text>
              <View style={styles.bulletContainer}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Open staat voor anderen</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Van anderen wilt leren</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Ervaringen wilt uitwisselen</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Uit je vertrouwde omgeving wilt stappen</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Anderen zonder vooroordelen wilt ontmoeten</Text>
                </View>
              </View>
            </View>
          </View>

          {/* Costs Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="card-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Kosten</Text>
            </View>

            <View style={styles.costCard}>
              <Text style={styles.costTitle}>€181,50 incl. BTW</Text>
              <Text style={styles.costSubtitle}>
                Exclusief verzekering, ticket, zakgeld en ziektekosten
              </Text>
            </View>
          </View>

          {/* Registration Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="mail-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Aanmelden</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                De aanmelding voor Short Term Exchange loopt via email.
              </Text>
            </View>

            <TouchableOpacity
              style={styles.emailButton}
              onPress={() => Linking.openURL('mailto:interesse@rotaryyep.nl')}>
              <Ionicons name="mail-outline" size={24} color="#FFFFFF" />
              <Text style={styles.emailButtonText}>interesse@rotaryyep.nl</Text>
            </TouchableOpacity>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
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
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 20,
    marginBottom: 20,
    alignItems: 'center',
    ...shadowStyle,
  },
  headerIcon: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: '#FFF4F1',
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
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
    paddingHorizontal: 4,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 20 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 12,
  },

  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  infoText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },

  // Age Card Styles
  ageCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#9C27B0',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  ageIconContainer: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: '#F3E5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  ageContent: {
    flex: 1,
  },
  ageTitle: {
    fontSize: 20,
    fontWeight: '700',
    color: '#9C27B0',
    marginBottom: 2,
  },
  ageSubtitle: {
    fontSize: 14,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  ageNote: {
    fontSize: 12,
    color: '#666',
    fontStyle: 'italic',
  },

  // Mission Card
  missionCard: {
    backgroundColor: '#FFF9C4',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#FFD700',
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FFD700',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 1,
        }),
  },
  missionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  missionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#F57C00',
    marginLeft: 8,
  },
  missionText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 8,
    fontStyle: 'italic',
  },
  missionSubtext: {
    fontSize: 14,
    lineHeight: 20,
    color: '#666',
  },

  // Cost Card
  costCard: {
    backgroundColor: '#E3F2FD',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 16,
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#2196F3',
  },
  costTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: '#1976D2',
    marginBottom: 4,
  },
  costSubtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
  },

  // Email Button
  emailButton: {
    backgroundColor: '#FF6B35',
    borderRadius: Platform.OS === 'ios' ? 25 : 8,
    paddingVertical: Platform.OS === 'ios' ? 16 : 14,
    paddingHorizontal: 32,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 8,
    ...(Platform.OS === 'ios'
      ? {
          shadowColor: '#FF6B35',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.2,
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
    marginLeft: 8,
  },

  // Bullet Styles
  bulletContainer: {
    marginTop: 12,
  },
  bulletItem: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 8,
  },
  bulletDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: '#FF6B35',
    marginTop: 8,
    marginRight: 12,
  },
  bulletText: {
    fontSize: 16,
    lineHeight: 22,
    color: '#333',
    flex: 1,
  },
});
