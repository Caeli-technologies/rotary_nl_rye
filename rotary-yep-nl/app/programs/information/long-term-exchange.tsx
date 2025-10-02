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

export default function LongTermExchangeScreen() {
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
              <Ionicons name="school-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Long Term Exchange</Text>
            <Text style={styles.headerSubtitle}>
              Een jaar High School in het buitenland via Rotary International
            </Text>
          </View>

          {/* What is it Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="help-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Wat houdt dat in?</Text>
            </View>

            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Dit programma van Rotary International is bestemd voor alle hierin geïnteresseerde
                scholieren uit het Voortgezet Onderwijs. Het is de bedoeling dat je in het
                buitenland een jaar High School volgt.
              </Text>
            </View>
          </View>

          {/* Age Section */}
          <View style={styles.section}>
            <View style={styles.ageCard}>
              <View style={styles.ageIconContainer}>
                <Ionicons name="calendar" size={28} color="#673AB7" />
              </View>
              <View style={styles.ageContent}>
                <Text style={styles.ageTitle}>15,5 - 18,5 jaar</Text>
                <Text style={styles.ageSubtitle}>Indicatieve leeftijdsgrenzen</Text>
                <Text style={styles.ageNote}>
                  Selectiedag in oktober + selectieweekend in november
                </Text>
              </View>
            </View>
          </View>

          {/* Countries Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="earth-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Met welke landen?</Text>
            </View>

            <View style={styles.countryCard}>
              <View style={styles.hemisphereSection}>
                <View style={styles.hemisphereHeader}>
                  <Text style={styles.hemisphereTitle}>Noordelijk halfrond</Text>
                </View>
                <Text style={styles.countryText}>
                  USA, Canada, Mexico, India, Indonesië, Japan, Thailand, Taiwan en diverse Europese
                  landen
                </Text>
              </View>

              <View style={styles.hemisphereSection}>
                <View style={styles.hemisphereHeader}>
                  <Text style={styles.hemisphereTitle}>Zuidelijk halfrond</Text>
                </View>
                <Text style={styles.countryText}>Brazilië, Chili, Argentinië, Ecuador, Peru</Text>
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
              <Text style={styles.costTitle}>Vanaf €2.400</Text>
              <Text style={styles.costSubtitle}>
                Exclusief BTW, verzekering, ticket kosten etc.
              </Text>
            </View>
          </View>

          {/* Registration Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="person-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Aanmelden</Text>
            </View>

            <View style={styles.buttonContainer}>
              <TouchableOpacity
                style={styles.emailButton}
                onPress={() => Linking.openURL('mailto:interesse@rotaryyep.nl')}>
                <Ionicons name="mail-outline" size={24} color="#FFFFFF" />
                <Text style={styles.emailButtonText}>interesse@rotaryyep.nl</Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* Why Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="heart-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Waarom Rotary Youth Exchange?</Text>
            </View>

            {/* Internationale ervaring */}
            <View style={styles.whyCard}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>1</Text>
                </View>
                <Text style={styles.whyTitle}>Internationale ervaring</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Jongeren leren een nieuwe cultuur, taal en manier van leven kennen
                  </Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Het vergroot hun wereldbeeld en respect voor diversiteit
                  </Text>
                </View>
              </View>
            </View>

            {/* Persoonlijke ontwikkeling */}
            <View style={styles.whyCard}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>2</Text>
                </View>
                <Text style={styles.whyTitle}>Persoonlijke ontwikkeling</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Zelfstandigheid, zelfvertrouwen en verantwoordelijkheid nemen
                  </Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Aanpassen aan nieuwe situaties en omgaan met uitdagingen
                  </Text>
                </View>
              </View>
            </View>

            {/* Taalontwikkeling */}
            <View style={styles.whyCard}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>3</Text>
                </View>
                <Text style={styles.whyTitle}>Taalontwikkeling</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Door dagelijks contact met de taal van het gastland, leren jongeren snel en
                    effectief communiceren
                  </Text>
                </View>
              </View>
            </View>

            {/* Onderwijs en culturele verrijking */}
            <View style={styles.whyCard}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>4</Text>
                </View>
                <Text style={styles.whyTitle}>Onderwijs en culturele verrijking</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Scholing in het gastland én vaak ook het geven van presentaties over de eigen
                    cultuur
                  </Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Wederzijdse uitwisseling van kennis en gebruiken
                  </Text>
                </View>
              </View>
            </View>

            {/* Rotary netwerk */}
            <View style={styles.whyCard}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>5</Text>
                </View>
                <Text style={styles.whyTitle}>Rotary netwerk</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Betrouwbare begeleiding: jongeren verblijven bij gastgezinnen die door Rotary
                    zorgvuldig zijn geselecteerd
                  </Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Ondersteuning van lokale Rotaryclubs en toegang tot een wereldwijd netwerk van
                    contacten
                  </Text>
                </View>
              </View>
            </View>

            {/* Vriendschappen voor het leven */}
            <View style={[styles.whyCard, { marginBottom: 0 }]}>
              <View style={styles.whyHeader}>
                <View style={styles.whyNumber}>
                  <Text style={styles.whyNumberText}>6</Text>
                </View>
                <Text style={styles.whyTitle}>Vriendschappen voor het leven</Text>
              </View>
              <View style={styles.whyBullets}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Contacten met mensen uit het gastland én met andere uitwisselingsstudenten van
                    over de hele wereld
                  </Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>
                    Kortom: Rotary Youth Exchange draait om vrede, begrip en vriendschap tussen
                    culturen, en geeft jongeren een kans om zich persoonlijk én internationaal te
                    ontwikkelen
                  </Text>
                </View>
              </View>
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
    flexDirection: 'row',
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#673AB7',
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
    backgroundColor: '#EDE7F6',
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
    color: '#673AB7',
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

  // Country Card
  countryCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  hemisphereSection: {
    marginBottom: 16,
  },
  hemisphereHeader: {
    marginBottom: 8,
  },
  hemisphereTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
  },
  countryText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#666',
  },

  // Cost Card
  costCard: {
    backgroundColor: '#E8F5E8',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },
  costTitle: {
    fontSize: 24,
    fontWeight: '700',
    color: '#2E7D32',
    marginBottom: 4,
  },
  costSubtitle: {
    fontSize: 14,
    color: '#666',
    textAlign: 'center',
  },

  // Button Container
  buttonContainer: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
  },

  // Email Button
  emailButton: {
    backgroundColor: '#FF6B35',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    paddingVertical: 16,
    paddingHorizontal: 24,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
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

  // Why Section Styles
  whyCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 12,
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
  whyHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  whyNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#FF6B35',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  whyNumberText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '700',
  },
  whyTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#1A237E',
    flex: 1,
  },
  whyBullets: {
    marginLeft: 0,
    paddingLeft: 44,
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
