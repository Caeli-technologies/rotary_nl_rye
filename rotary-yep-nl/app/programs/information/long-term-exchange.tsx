import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform, TouchableOpacity, Linking } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { StatusBar } from 'expo-status-bar';

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
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
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
                Dit programma van Rotary International is bestemd voor alle hierin geïnteresseerde scholieren uit het Voortgezet Onderwijs. Het is de bedoeling dat je in het buitenland een jaar High School volgt.
              </Text>
            </View>
          </View>

          {/* Age Card */}
          <View style={styles.ageCard}>
            <View style={styles.ageIconContainer}>
              <Ionicons name="calendar" size={28} color="#673AB7" />
            </View>
            <View style={styles.ageContent}>
              <Text style={styles.ageTitle}>15,5 - 18,5 jaar</Text>
              <Text style={styles.ageSubtitle}>Indicatieve leeftijdsgrenzen</Text>
              <Text style={styles.ageNote}>Selectiedag in oktober + selectieweekend in november</Text>
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
                  <Ionicons name="sunny" size={20} color="#FF9800" />
                  <Text style={styles.hemisphereTitle}>Noordelijk halfrond</Text>
                </View>
                <Text style={styles.countryText}>
                  USA, Canada, India, Indonesië, Japan, Thailand, Taiwan en diverse Europese landen
                </Text>
              </View>
              
              <View style={styles.hemisphereSection}>
                <View style={styles.hemisphereHeader}>
                  <Ionicons name="partly-sunny" size={20} color="#00BCD4" />
                  <Text style={styles.hemisphereTitle}>Zuidelijk halfrond</Text>
                </View>
                <Text style={styles.countryText}>
                  Brazilië, Chili, Argentinië, Mexico, Ecuador, Peru, Australië, Nieuw-Zeeland, Zuid-Afrika
                </Text>
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
              <Text style={styles.costSubtitle}>Exclusief BTW, zakgeld, ticket en andere onkosten</Text>
            </View>
          </View>

          {/* Registration Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="person-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Aanmelden</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Inlichtingen bij de coördinator van het programma Barbara Tusveld:
              </Text>
            </View>

            <TouchableOpacity 
              style={styles.emailButton}
              onPress={() => Linking.openURL('mailto:longtermchair@rotaryyep.nl')}
            >
              <Ionicons name="mail-outline" size={24} color="#FFFFFF" />
              <Text style={styles.emailButtonText}>longtermchair@rotaryyep.nl</Text>
            </TouchableOpacity>
          </View>

          {/* Why Section */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="heart-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Waarom doen we dit?</Text>
            </View>
            
            <View style={styles.infoCard}>
              <View style={styles.bulletContainer}>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Het opbouwen van goede relaties met andere landen</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>Het houdt de club jong</Text>
                </View>
                <View style={styles.bulletItem}>
                  <View style={styles.bulletDot} />
                  <Text style={styles.bulletText}>De jongere ontwikkelt zichzelf en zijn/haar omgeving</Text>
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
    marginBottom: 32,
  },
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
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
    ...(Platform.OS === 'ios' ? shadowStyle : {
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
    borderLeftColor: '#673AB7',
    ...(Platform.OS === 'ios' ? shadowStyle : {
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
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 2,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  hemisphereSection: {
    marginBottom: 16,
  },
  hemisphereHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  hemisphereTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  countryText: {
    fontSize: 14,
    lineHeight: 20,
    color: '#666',
  },
  
  // Cost Card
  costCard: {
    backgroundColor: '#E8F5E8',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 16,
    alignItems: 'center',
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
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
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#FF6B35',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.2,
      shadowRadius: 4,
    } : {
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
