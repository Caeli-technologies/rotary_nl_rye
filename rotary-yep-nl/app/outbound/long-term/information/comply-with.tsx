import React from 'react';
import { StyleSheet, View, Text, ScrollView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
export default function ComplyWithScreen() {
  const { colors: themeColors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          <View
            style={[
              styles.textContainer,
              { backgroundColor: themeColors.card, borderColor: themeColors.border },
            ]}>
            <Text style={[styles.text, { color: themeColors.text }]}>
              Zit je op het VMBO, HAVO of VWO dan kun je na selectie voor deze uitwisseling in
              aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een
              Sponsorclub. Dat betekent niet dat de club jouw kosten betaalt, maar de club is
              verantwoordelijk voor de terug ontvangst van een jaarkind uit het buitenland. Als jij
              weggaat komt er ook een buitenlandse scholier terug. Een diploma is geen vereiste om
              je op te geven; je kunt nl ook je schoolprogramma onderbreken. Soms is dat zelfs een
              voordeel. In het buitenland worden namelijk vaak strenge leeftijdsgrenzen gesteld om
              tot een school te worden toegelaten. En om deel te kunnen nemen aan de schoolsporten
              is het soms beter om nog geen diploma te hebben.
            </Text>
          </View>

          <View
            style={[
              styles.ageCard,
              {
                backgroundColor: themeColors.card,
                borderColor: themeColors.border,
                borderLeftColor: themeColors.primary,
              },
            ]}>
            <View
              style={[styles.ageIconContainer, { backgroundColor: themeColors.primary + '20' }]}>
              <Ionicons name="calendar" size={28} color={themeColors.primary} />
            </View>
            <View style={styles.ageContent}>
              <Text style={[styles.ageTitle, { color: themeColors.primary }]}>15 - 18 jaar</Text>
              <Text style={[styles.ageSubtitle, { color: themeColors.text }]}>
                Indicatieve leeftijdsgrenzen
              </Text>
              <Text style={[styles.ageNote, { color: themeColors.textSecondary }]}>
                Voor overheidsscholen, soms enige flexibiliteit mogelijk
              </Text>
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
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  textContainer: {
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    padding: 20,
    marginBottom: 16,
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  text: {
    fontSize: 16,
    lineHeight: 24,
  },

  // Age Card Styles
  ageCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    padding: 20,
    marginBottom: 16,
    flexDirection: 'row',
    alignItems: 'center',
    borderLeftWidth: 4,
    borderWidth: Platform.OS === 'android' ? StyleSheet.hairlineWidth : 0,
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
    marginBottom: 2,
  },
  ageSubtitle: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: 4,
  },
  ageNote: {
    fontSize: 12,
    fontStyle: 'italic',
  },
});
