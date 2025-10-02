import React from 'react';
import { Platform, ScrollView, StyleSheet, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

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
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="flag" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Wie zijn wij</Text>
            </View>
            <Text style={styles.sectionSubtitle}>
              Nederland MDJC - Multi district Jeugd Commissie
            </Text>
            <Text style={styles.text}>
              Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes
              georganiseerd. Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de
              toekomst, niet alleen voor de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken
              met jeugduitwisseling de vijfde Avenue binnen Rotary geworden. Jaarlijks zijn er 7000
              Exchanges wereldwijd.
            </Text>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="rocket" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Onze Missie</Text>
            </View>
            <Text style={styles.text}>
              Rotary Youth Exchange biedt jongeren de kans om een jaar (of kortere periode) in het
              buitenland te wonen, studeren en een nieuwe cultuur te ontdekken. Het programma
              stimuleert:
            </Text>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>
                Internationaal begrip en vrede door jongeren wereldwijd met elkaar te verbinden
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>
                Persoonlijke ontwikkeling door jongeren uit hun comfortzone te laten stappen,
                zelfstandig te worden en zich aan te passen aan een nieuwe omgeving
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>
                Culturele uitwisseling door het leren van talen, gebruiken en gewoonten in een ander
                land
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>
                Ambassadeurschap: deelnemers vertegenwoordigen hun eigen land en cultuur, en brengen
                deze in contact met hun gastland
              </Text>
            </View>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="airplane" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Exchange Programs</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Longterm exchanges 10-11 maanden</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>
                Short term 2x2 weken (Noordelijk Halfrond) of 4x4 weken (Zuidelijk Halfrond)
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Zomerkampen</Text>
            </View>
            <Text style={styles.quote}>
              &ldquo;To build peace one young person at a time.&rdquo;
            </Text>
          </View>

          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons name="heart" size={20} color="#1A237E" />
              <Text style={styles.sectionTitle}>Values</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Cultural understanding and respect</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Personal growth and development</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Global friendship and peace</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={styles.bulletPoint} />
              <Text style={styles.listItemText}>Service above self</Text>
            </View>
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
  listItemContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 12,
    paddingLeft: 8,
  },
  bulletPoint: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: '#1A237E',
    marginTop: 8,
    marginRight: 12,
    flexShrink: 0,
  },
  listItemText: {
    fontSize: 16,
    lineHeight: 24,
    color: '#333',
    flex: 1,
  },
  quote: {
    fontSize: 18,
    lineHeight: 26,
    color: '#1A237E',
    fontWeight: '600',
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: 16,
    marginBottom: 8,
  },
});
