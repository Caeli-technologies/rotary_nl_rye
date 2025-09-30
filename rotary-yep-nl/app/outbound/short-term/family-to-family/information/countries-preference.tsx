import React from 'react';
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
} from 'react-native';
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

export default function CountriesPreferenceScreen() {
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
              <Ionicons name="globe-outline" size={32} color="#FF6B35" />
            </View>
            <Text style={styles.headerTitle}>Landenvoorkeur</Text>
            <Text style={styles.headerSubtitle}>
              Kies je voorkeursbestemming voor de Family-to-Family ervaring
            </Text>
          </View>

          {/* Landenkeuze uitleg */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="help-circle-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Hoe kies je je voorkeur?</Text>
            </View>
            
            <View style={styles.infoCard}>
              <Text style={styles.infoText}>
                Als je mee wilt doen aan het Family to Family programma geef je op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de landenkeuze dien je drie landen op 2 continenten op te geven. Hierbij gelden de Verenigde Staten en Canada als één bestemming. De reden hiervoor is dat we niet alle kandidaten in de VS en Canada kunnen plaatsen. Daarbij komt dat als jij de juiste instelling hebt voor een Family to Family uitwisseling het uiteindelijk niet uitmaakt naar welk land je gaat.
              </Text>
            </View>
          </View>

          {/* Europa aanbeveling */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="star-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Kies voor Europa!</Text>
            </View>
            
            <View style={styles.europeCard}>
              <Text style={styles.europeText}>
                Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste uitwisselingen plaats en ontstaan de mooiste vriendschappen met het voordeel dat je deze vrienden makkelijker kunt herbezoeken. De reiskosten zijn veel lager.
              </Text>
            </View>
          </View>

          {/* Tips voor landenkeuze */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="bulb-outline" size={24} color="#FF6B35" />
              <Text style={styles.sectionTitle}>Tips voor je keuze</Text>
            </View>
            
            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="language-outline" size={20} color="#2196F3" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Taal</Text>
                <Text style={styles.tipDescription}>
                  Overweeg welke talen je spreekt of wilt leren. Basiskennis helpt bij de communicatie.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="globe-outline" size={20} color="#4CAF50" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Cultuur</Text>
                <Text style={styles.tipDescription}>
                  Kies landen waarvan de cultuur en geschiedenis je echt interesseren.
                </Text>
              </View>
            </View>

            <View style={styles.tipCard}>
              <View style={styles.tipIcon}>
                <Ionicons name="airplane-outline" size={20} color="#FF9800" />
              </View>
              <View style={styles.tipContent}>
                <Text style={styles.tipTitle}>Reiskosten</Text>
                <Text style={styles.tipDescription}>
                  Houd rekening met reiskosten en afstand, vooral bij kortere programma's.
                </Text>
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
  
  // Info Card
  infoCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
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

  
  // Europe Card Styles
  europeCard: {
    backgroundColor: '#E8F5E8',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    borderLeftWidth: 4,
    borderLeftColor: '#4CAF50',
    ...(Platform.OS === 'ios' ? {
      shadowColor: '#4CAF50',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
    } : {
      elevation: 1,
    }),
  },
  europeText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
  },
  
  // Logo Section
  logoSection: {
    alignItems: 'center',
    paddingVertical: 30,
    marginTop: 20,
  },
  logoText: {
    fontSize: 14,
    color: '#777777',
  },
  
  // Tip Card Styles
  tipCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
    ...(Platform.OS === 'ios' ? shadowStyle : {
      elevation: 1,
      borderWidth: StyleSheet.hairlineWidth,
      borderColor: '#E0E0E0',
    }),
  },
  tipIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  tipContent: {
    flex: 1,
  },
  tipTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1A237E',
    marginBottom: 4,
  },
  tipDescription: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
});