/**
 * Family-to-Family Countries/Preference screen
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const DESTINATIONS = [
  {
    region: "Europa",
    countries: ["Duitsland", "Frankrijk", "Spanje", "Italië", "Scandinavië"],
    icon: "globe-outline",
    description: "Ontdek de diversiteit van Europese culturen dichtbij huis",
  },
  {
    region: "Noord-Amerika",
    countries: ["Verenigde Staten", "Canada"],
    icon: "earth-outline",
    description: "Ervaar het leven in Noord-Amerikaanse gastgezinnen",
  },
  {
    region: "Azië & Oceanië",
    countries: ["Taiwan", "Japan", "Australië"],
    icon: "airplane-outline",
    description: "Verken fascinerende Aziatische en Oceanische culturen",
  },
  {
    region: "Zuid-Amerika",
    countries: ["Brazilië", "Argentinië"],
    icon: "leaf-outline",
    description: "Beleef de warmte van Latijns-Amerikaanse gastvrijheid",
  },
];

const SELECTION_TIPS = [
  {
    title: "Denk aan je interesses",
    description: "Kies een land dat past bij je hobby's en interesses",
    icon: "heart-outline",
  },
  {
    title: "Taal overwegingen",
    description: "Overweeg welke taal je wilt leren of verbeteren",
    icon: "chatbubbles-outline",
  },
  {
    title: "Culturele nieuwsgierigheid",
    description: "Sta open voor culturen die heel anders zijn dan de jouwe",
    icon: "sparkles-outline",
  },
  {
    title: "Bespreek met je gezin",
    description: "Je gezin zal ook een student ontvangen, betrek hen bij de keuze",
    icon: "people-outline",
  },
];

export default function FamilyToFamilyCountriesScreen() {
  const { colors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
      edges={["bottom"]}
    >
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.content}
        showsVerticalScrollIndicator={false}
      >
        {/* Header Section */}
        <View style={styles.headerSection}>
          <View style={[styles.headerIcon, { backgroundColor: `${colors.primary}15` }]}>
            <Ionicons name="globe" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Landen & Voorkeur</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Ontdek waar je heen kunt met Family-to-Family
          </Text>
        </View>

        {/* Destinations Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="location" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Beschikbare Regio&apos;s</Text>
          </View>

          <View style={styles.destinationsList}>
            {DESTINATIONS.map((destination) => (
              <View
                key={destination.region}
                style={[styles.destinationItem, { backgroundColor: `${colors.primary}08` }]}
              >
                <View style={[styles.destinationIcon, { backgroundColor: `${colors.primary}15` }]}>
                  <Ionicons name={destination.icon as any} size={24} color={colors.primary} />
                </View>
                <View style={styles.destinationContent}>
                  <Text style={[styles.destinationRegion, { color: colors.text }]}>
                    {destination.region}
                  </Text>
                  <Text style={[styles.destinationCountries, { color: colors.primary }]}>
                    {destination.countries.join(" • ")}
                  </Text>
                  <Text style={[styles.destinationDescription, { color: colors.textSecondary }]}>
                    {destination.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* How to Choose Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="bulb" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Hoe kies je?</Text>
          </View>

          <View style={styles.tipsList}>
            {SELECTION_TIPS.map((tip, index) => (
              <View key={index} style={[styles.tipItem, { borderBottomColor: colors.border }]}>
                <View style={[styles.tipIcon, { backgroundColor: `${colors.primary}10` }]}>
                  <Ionicons name={tip.icon as any} size={20} color={colors.primary} />
                </View>
                <View style={styles.tipContent}>
                  <Text style={[styles.tipTitle, { color: colors.text }]}>{tip.title}</Text>
                  <Text style={[styles.tipDescription, { color: colors.textSecondary }]}>
                    {tip.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Important Note Card */}
        <View
          style={[
            styles.noteCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.noteHeader}>
            <Ionicons name="information-circle" size={24} color={colors.primary} />
            <Text style={[styles.noteTitle, { color: colors.text }]}>Belangrijk</Text>
          </View>
          <Text style={[styles.noteText, { color: colors.textSecondary }]}>
            De beschikbaarheid van landen kan per jaar variëren. We proberen altijd je voorkeur te
            respecteren, maar kunnen dit niet garanderen. Heb je een tweede en derde keuze klaar!
          </Text>
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
    padding: spacing.md,
    paddingBottom: spacing.xl,
  },
  headerSection: {
    alignItems: "center",
    marginBottom: spacing.xl,
    paddingVertical: spacing.lg,
  },
  headerIcon: {
    width: 72,
    height: 72,
    borderRadius: 36,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: spacing.md,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: "700",
    textAlign: "center",
    marginBottom: spacing.sm,
  },
  headerSubtitle: {
    fontSize: 16,
    textAlign: "center",
    lineHeight: 24,
  },
  card: {
    borderRadius: 16,
    padding: spacing.lg,
    marginBottom: spacing.md,
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 12,
    elevation: 3,
  },
  cardHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.md,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  destinationsList: {
    gap: spacing.md,
  },
  destinationItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: spacing.md,
    borderRadius: 12,
  },
  destinationIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  destinationContent: {
    flex: 1,
  },
  destinationRegion: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  destinationCountries: {
    fontSize: 13,
    fontWeight: "500",
    marginBottom: 4,
  },
  destinationDescription: {
    fontSize: 13,
    lineHeight: 18,
  },
  tipsList: {
    gap: spacing.sm,
  },
  tipItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: spacing.sm,
  },
  tipIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  tipContent: {
    flex: 1,
  },
  tipTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  tipDescription: {
    fontSize: 13,
    lineHeight: 18,
  },
  noteCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
  },
  noteHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  noteTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  noteText: {
    fontSize: 14,
    lineHeight: 20,
  },
});
