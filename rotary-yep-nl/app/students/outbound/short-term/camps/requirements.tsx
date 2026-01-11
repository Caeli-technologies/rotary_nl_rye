/**
 * Zomerkampen Requirements/For whom screen
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const ELIGIBILITY = [
  {
    title: "Rotarian Families",
    description: "Kinderen en kleinkinderen van Rotary leden",
    icon: "ribbon-outline",
  },
  {
    title: "Non-Rotarian Youth",
    description: "Alle gemotiveerde jongeren uit de gemeenschap",
    icon: "people-outline",
  },
];

const EXPECTATIONS = [
  {
    title: "Internationale Ervaring",
    description: "Ontdek nieuwe culturen en maak vrienden over de hele wereld",
    icon: "globe-outline",
  },
  {
    title: "Persoonlijke Ontwikkeling",
    description: "Ontwikkel zelfvertrouwen en leiderschapsvaardigheden",
    icon: "trending-up-outline",
  },
  {
    title: "Onvergetelijke Herinneringen",
    description: "Creëer levenslange herinneringen en verhalen om te delen",
    icon: "heart-outline",
  },
];

export default function CampsRequirementsScreen() {
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
            <Ionicons name="people" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Voor wie?</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Leeftijd en deelname informatie voor Zomerkampen
          </Text>
        </View>

        {/* Age Requirements Card */}
        <View
          style={[
            styles.ageCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.ageHeader}>
            <Ionicons name="calendar" size={28} color={colors.primary} />
            <View style={styles.ageNumbers}>
              <Text style={[styles.ageRange, { color: colors.primary }]}>15 - 21 jaar</Text>
              <Text style={[styles.ageLabel, { color: colors.textSecondary }]}>
                Leeftijdsvereisten
              </Text>
            </View>
          </View>
          <View style={[styles.ageDivider, { backgroundColor: `${colors.primary}20` }]} />
          <Text style={[styles.ageNote, { color: colors.textSecondary }]}>
            Perfecte leeftijd voor internationale ervaringen en persoonlijke groei
          </Text>
        </View>

        {/* Eligibility Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="checkmark-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wie kan deelnemen?</Text>
          </View>

          <View style={styles.itemsList}>
            {ELIGIBILITY.map((item, index) => (
              <View
                key={index}
                style={[styles.itemRow, { backgroundColor: `${colors.success}08` }]}
              >
                <View style={[styles.itemIcon, { backgroundColor: `${colors.success}15` }]}>
                  <Ionicons name={item.icon as any} size={22} color={colors.success} />
                </View>
                <View style={styles.itemContent}>
                  <Text style={[styles.itemTitle, { color: colors.text }]}>{item.title}</Text>
                  <Text style={[styles.itemDescription, { color: colors.textSecondary }]}>
                    {item.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Expectations Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="star" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wat kun je verwachten?</Text>
          </View>

          <View style={styles.itemsList}>
            {EXPECTATIONS.map((item, index) => (
              <View
                key={index}
                style={[styles.itemRow, { backgroundColor: `${colors.primary}08` }]}
              >
                <View style={[styles.itemIcon, { backgroundColor: `${colors.primary}15` }]}>
                  <Ionicons name={item.icon as any} size={22} color={colors.primary} />
                </View>
                <View style={styles.itemContent}>
                  <Text style={[styles.itemTitle, { color: colors.text }]}>{item.title}</Text>
                  <Text style={[styles.itemDescription, { color: colors.textSecondary }]}>
                    {item.description}
                  </Text>
                </View>
              </View>
            ))}
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
  ageCard: {
    borderRadius: 16,
    padding: spacing.lg,
    marginBottom: spacing.md,
    borderWidth: 1,
  },
  ageHeader: {
    flexDirection: "row",
    alignItems: "center",
  },
  ageNumbers: {
    marginLeft: spacing.md,
  },
  ageRange: {
    fontSize: 28,
    fontWeight: "700",
  },
  ageLabel: {
    fontSize: 14,
    marginTop: 2,
  },
  ageDivider: {
    height: 1,
    marginVertical: spacing.md,
  },
  ageNote: {
    fontSize: 14,
    lineHeight: 20,
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
  itemsList: {
    gap: spacing.sm,
  },
  itemRow: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  itemIcon: {
    width: 44,
    height: 44,
    borderRadius: 22,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  itemContent: {
    flex: 1,
  },
  itemTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  itemDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
});
