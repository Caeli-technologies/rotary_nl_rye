import React from 'react';
import { Platform, ScrollView, StyleSheet, View, Text } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useTheme } from '@/hooks/use-theme';

export default function AboutScreen() {
  const { colors: themeColors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.safeArea, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <ScrollView
        style={[styles.container, { backgroundColor: themeColors.background }]}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic">
        <View style={styles.content}>
          {/* Wie zijn wij Card */}
          <View
            style={[
              styles.card,
              {
                backgroundColor: themeColors.card,
                shadowColor: themeColors.shadow,
                borderColor: themeColors.border,
              },
            ]}>
            <View style={styles.cardHeader}>
              <View style={[styles.iconContainer, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="flag" size={22} color={themeColors.primary} />
              </View>
              <Text style={[styles.cardTitle, { color: themeColors.text }]}>Wie zijn wij</Text>
            </View>
            <Text style={[styles.cardSubtitle, { color: themeColors.accent }]}>
              Nederland MDJC - Multi district Jeugd Commissie
            </Text>
            <Text style={[styles.cardText, { color: themeColors.textSecondary }]}>
              Internationale jeugduitwisselingen met Rotary worden al 55 jaar met succes
              georganiseerd. Jeugduitwisselingen zit in het DNA van Rotary. De jeugd heeft de
              toekomst, niet alleen voor de Rotary, maar ook voor de wereld. In 2010 is Jeugdzaken
              met jeugduitwisseling de vijfde Avenue binnen Rotary geworden. Jaarlijks zijn er 7000
              Exchanges wereldwijd.
            </Text>
          </View>

          {/* Onze Missie Card */}
          <View
            style={[
              styles.card,
              {
                backgroundColor: themeColors.card,
                shadowColor: themeColors.shadow,
                borderColor: themeColors.border,
              },
            ]}>
            <View style={styles.cardHeader}>
              <View style={[styles.iconContainer, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="rocket" size={22} color={themeColors.primary} />
              </View>
              <Text style={[styles.cardTitle, { color: themeColors.text }]}>Onze Missie</Text>
            </View>
            <Text style={[styles.cardText, { color: themeColors.textSecondary }]}>
              Rotary Youth Exchange biedt jongeren de kans om een jaar (of kortere periode) in het
              buitenland te wonen, studeren en een nieuwe cultuur te ontdekken. Het programma
              stimuleert:
            </Text>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Internationaal begrip en vrede door jongeren wereldwijd met elkaar te verbinden
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Persoonlijke ontwikkeling door jongeren uit hun comfortzone te laten stappen,
                zelfstandig te worden en zich aan te passen aan een nieuwe omgeving
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Culturele uitwisseling door het leren van talen, gebruiken en gewoonten in een ander
                land
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Ambassadeurschap: deelnemers vertegenwoordigen hun eigen land en cultuur, en brengen
                deze in contact met hun gastland
              </Text>
            </View>
          </View>

          {/* Exchange Programs Card */}
          <View
            style={[
              styles.card,
              {
                backgroundColor: themeColors.card,
                shadowColor: themeColors.shadow,
                borderColor: themeColors.border,
              },
            ]}>
            <View style={styles.cardHeader}>
              <View style={[styles.iconContainer, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="airplane" size={22} color={themeColors.primary} />
              </View>
              <Text style={[styles.cardTitle, { color: themeColors.text }]}>Exchange Programs</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Longterm exchanges 10-11 maanden
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Short term 2x2 weken (Noordelijk Halfrond) of 4x4 weken (Zuidelijk Halfrond)
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Zomerkampen
              </Text>
            </View>
            <Text
              style={[
                styles.quote,
                { color: themeColors.text, borderTopColor: themeColors.border },
              ]}>
              &ldquo;To build peace one young person at a time.&rdquo;
            </Text>
          </View>

          {/* Values Card */}
          <View
            style={[
              styles.card,
              {
                backgroundColor: themeColors.card,
                shadowColor: themeColors.shadow,
                borderColor: themeColors.border,
              },
            ]}>
            <View style={styles.cardHeader}>
              <View style={[styles.iconContainer, { backgroundColor: themeColors.primary + '15' }]}>
                <Ionicons name="heart" size={22} color={themeColors.primary} />
              </View>
              <Text style={[styles.cardTitle, { color: themeColors.text }]}>Values</Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Cultural understanding and respect
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Personal growth and development
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Global friendship and peace
              </Text>
            </View>
            <View style={styles.listItemContainer}>
              <View style={[styles.bulletPoint, { backgroundColor: themeColors.primary }]} />
              <Text style={[styles.listItemText, { color: themeColors.textSecondary }]}>
                Service above self
              </Text>
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
  },
  container: {
    flex: 1,
  },
  content: {
    padding: 16,
    paddingBottom: Platform.OS === 'android' ? 80 : 30,
  },
  card: {
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
  },
  cardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  iconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
    marginRight: 12,
  },
  cardTitle: {
    fontSize: 20,
    fontWeight: '600',
    flex: 1,
  },
  cardSubtitle: {
    fontSize: 15,
    fontWeight: '500',
    marginBottom: 12,
    fontStyle: 'italic',
  },
  cardText: {
    fontSize: 15,
    lineHeight: 22,
    marginBottom: 12,
  },
  listItemContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 10,
  },
  bulletPoint: {
    width: 6,
    height: 6,
    borderRadius: 3,
    marginTop: 8,
    marginRight: 12,
    flexShrink: 0,
  },
  listItemText: {
    fontSize: 15,
    lineHeight: 22,
    flex: 1,
  },
  quote: {
    fontSize: 16,
    lineHeight: 24,
    fontWeight: '600',
    fontStyle: 'italic',
    textAlign: 'center',
    marginTop: 12,
    paddingTop: 12,
    borderTopWidth: 1,
  },
});
