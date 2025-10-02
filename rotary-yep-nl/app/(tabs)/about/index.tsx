import React from 'react';
import { Platform, ScrollView, StyleSheet, View, Text } from 'react-native';
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

export default function AboutScreen() {
  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      
      <ScrollView
        style={styles.container}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Nederland MDJC</Text>
            </View>
            <Text style={styles.sectionSubtitle}>
              Multi district Jeugd Commissie
            </Text>
            <Text style={styles.text}>
              Internationale jeugduitwisselingen met Rotary worden al 55 jaar
              met succes georganiseerd. Jeugduitwisselingen zit in het DNA van
              Rotary. De jeugd heeft de toekomst, niet alleen voor de Rotary,
              maar ook voor de wereld. In 2010 is Jeugdzaken met
              jeugduitwisseling de vijfde Avenue binnen Rotary geworden.
              Jaarlijks zijn er 7000 Exchanges wereldwijd.
            </Text>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="rocket" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Our Mission</Text>
            </View>
            <Text style={styles.text}>
              To provide young people with opportunities for international
              cultural exchange, fostering understanding, friendship, and peace
              among nations through Rotary's global network.
            </Text>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="airplane" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Exchange Programs</Text>
            </View>
            <Text style={styles.text}>
              We offer various exchange programs including:
            </Text>
            <Text style={styles.listItem}>
              • Long-term exchanges (6-12 months)
            </Text>
            <Text style={styles.listItem}>
              • Short-term family-to-family programs
            </Text>
            <Text style={styles.listItem}>• Summer camps and tours</Text>
            <Text style={styles.listItem}>
              • New Generations Service Exchange
            </Text>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="heart" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Values</Text>
            </View>
            <Text style={styles.listItem}>
              • Cultural understanding and respect
            </Text>
            <Text style={styles.listItem}>
              • Personal growth and development
            </Text>
            <Text style={styles.listItem}>• Global friendship and peace</Text>
            <Text style={styles.listItem}>• Service above self</Text>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  container: {
    flex: 1,
    backgroundColor: Platform.OS === 'ios' ? '#F2F2F7' : '#FFFFFF',
  },
  content: {
    padding: Platform.OS === 'ios' ? 16 : 12,
    paddingBottom: Platform.OS === 'android' ? 80 : 30,
  },
  section: {
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
  sectionHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  sectionTitle: {
    fontSize: Platform.OS === 'ios' ? 22 : 18,
    fontWeight: Platform.OS === 'ios' ? '700' : '600',
    color: '#1A237E',
    marginLeft: 8,
  },
  sectionSubtitle: {
    fontSize: 16,
    fontWeight: '500',
    color: '#666',
    marginBottom: 16,
    fontStyle: 'italic',
  },
  text: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    marginBottom: 12,
  },
  listItem: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    marginBottom: 8,
    paddingLeft: 16,
  },
});
