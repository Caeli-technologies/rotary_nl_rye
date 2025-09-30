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

export default function ComplyWithScreen() {
  return (
    <SafeAreaView style={styles.container} edges={['bottom']}>
      <StatusBar style="auto" />
      
      <ScrollView 
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          <View style={styles.textContainer}>
            <Text style={styles.text}>
              Zit je op het VMBO, HAVO of VWO dan kun je na selectie voor deze uitwisseling in aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een Sponsorclub. Dat betekent niet dat de club jouw kosten betaalt, maar de club is verantwoordelijk voor de terug ontvangst van een jaarkind uit het buitenland. Als jij weggaat komt er ook een buitenlandse scholier terug. Een diploma is geen vereiste om je op te geven; je kunt nl ook je schoolprogramma onderbreken. Soms is dat zelfs een voordeel. In het buitenland worden namelijk vaak strenge leeftijdsgrenzen gesteld om tot een school te worden toegelaten. En om deel te kunnen nemen aan de schoolsporten is het soms beter om nog geen diploma te hebben.
            </Text>
          </View>
          
          <View style={styles.ageCard}>
            <View style={styles.ageIconContainer}>
              <Ionicons name="calendar" size={28} color="#9C27B0" />
            </View>
            <View style={styles.ageContent}>
              <Text style={styles.ageTitle}>15 - 18 jaar</Text>
              <Text style={styles.ageSubtitle}>Indicatieve leeftijdsgrenzen</Text>
              <Text style={styles.ageNote}>Voor overheidsscholen, soms enige flexibiliteit mogelijk</Text>
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
    backgroundColor: '#F8F9FA',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  textContainer: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 20,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  text: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333333',
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
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
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
});