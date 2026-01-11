/**
 * Family-to-Family Requirements screen
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const REQUIREMENTS = [
  {
    title: "Gastgezin bieden",
    description: "Jouw gezin moet ook een student uit het buitenland kunnen ontvangen",
    icon: "home-outline",
    important: true,
  },
  {
    title: "Schoolgaande jeugd",
    description: "Je moet nog op school zitten (voortgezet onderwijs of MBO)",
    icon: "school-outline",
    important: false,
  },
  {
    title: "Goede gezondheid",
    description: "Je moet in goede lichamelijke en geestelijke gezondheid verkeren",
    icon: "heart-outline",
    important: false,
  },
  {
    title: "Open houding",
    description: "Bereidheid om je aan te passen aan een nieuwe cultuur en gewoontes",
    icon: "globe-outline",
    important: false,
  },
  {
    title: "Zelfstandigheid",
    description: "Voldoende volwassenheid om 2-6 weken van huis te zijn",
    icon: "person-outline",
    important: false,
  },
];

const EXPECTATIONS = [
  {
    title: "Ambassadeur zijn",
    description: "Je vertegenwoordigt Nederland en Rotary tijdens je verblijf",
    icon: "flag-outline",
  },
  {
    title: "Respect tonen",
    description: "Respecteer de regels en gewoontes van je gastgezin",
    icon: "hand-right-outline",
  },
  {
    title: "Communiceren",
    description: "Houd contact met je eigen familie en je Rotary contactpersoon",
    icon: "chatbubble-outline",
  },
  {
    title: "Meedoen",
    description: "Neem actief deel aan familieactiviteiten en dagelijkse taken",
    icon: "people-outline",
  },
];

export default function FamilyToFamilyRequirementsScreen() {
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
            <Ionicons name="clipboard" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Vereisten</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Waar moet je aan voldoen voor Family-to-Family?
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
              <Text style={[styles.ageRange, { color: colors.primary }]}>15 - 25 jaar</Text>
              <Text style={[styles.ageLabel, { color: colors.textSecondary }]}>
                Leeftijdsvereisten
              </Text>
            </View>
          </View>
          <View style={[styles.ageDivider, { backgroundColor: `${colors.primary}20` }]} />
          <Text style={[styles.ageNote, { color: colors.textSecondary }]}>
            Afhankelijk van het land en programma kunnen specifieke leeftijdsgrenzen gelden
          </Text>
        </View>

        {/* Requirements Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="checkmark-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Toelatingseisen</Text>
          </View>

          <View style={styles.requirementsList}>
            {REQUIREMENTS.map((item, index) => (
              <View
                key={index}
                style={[
                  styles.requirementItem,
                  {
                    backgroundColor: item.important ? `${colors.primary}12` : `${colors.success}08`,
                  },
                ]}
              >
                <View
                  style={[
                    styles.requirementIcon,
                    {
                      backgroundColor: item.important
                        ? `${colors.primary}20`
                        : `${colors.success}15`,
                    },
                  ]}
                >
                  <Ionicons
                    name={item.icon as any}
                    size={22}
                    color={item.important ? colors.primary : colors.success}
                  />
                </View>
                <View style={styles.requirementContent}>
                  <View style={styles.requirementTitleRow}>
                    <Text style={[styles.requirementTitle, { color: colors.text }]}>
                      {item.title}
                    </Text>
                    {item.important && (
                      <View style={[styles.importantBadge, { backgroundColor: colors.primary }]}>
                        <Text style={styles.importantBadgeText}>Belangrijk</Text>
                      </View>
                    )}
                  </View>
                  <Text style={[styles.requirementDescription, { color: colors.textSecondary }]}>
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
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wat wordt er verwacht?</Text>
          </View>

          <View style={styles.expectationsList}>
            {EXPECTATIONS.map((item, index) => (
              <View
                key={index}
                style={[styles.expectationItem, { borderBottomColor: colors.border }]}
              >
                <View style={[styles.expectationIcon, { backgroundColor: `${colors.primary}10` }]}>
                  <Ionicons name={item.icon as any} size={20} color={colors.primary} />
                </View>
                <View style={styles.expectationContent}>
                  <Text style={[styles.expectationTitle, { color: colors.text }]}>
                    {item.title}
                  </Text>
                  <Text style={[styles.expectationDescription, { color: colors.textSecondary }]}>
                    {item.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Family Note Card */}
        <View
          style={[
            styles.noteCard,
            { backgroundColor: `${colors.success}10`, borderColor: `${colors.success}30` },
          ]}
        >
          <View style={styles.noteHeader}>
            <Ionicons name="people" size={24} color={colors.success} />
            <Text style={[styles.noteTitle, { color: colors.text }]}>Familie betrokkenheid</Text>
          </View>
          <Text style={[styles.noteText, { color: colors.textSecondary }]}>
            Family-to-Family is een wederkerige uitwisseling. Dit betekent dat je hele gezin
            betrokken is: terwijl jij in het buitenland bent, ontvangt je gezin een student uit dat
            land. Dit maakt het een bijzondere ervaring voor het hele gezin!
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
  requirementsList: {
    gap: spacing.sm,
  },
  requirementItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: spacing.md,
    borderRadius: 12,
  },
  requirementIcon: {
    width: 44,
    height: 44,
    borderRadius: 22,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  requirementContent: {
    flex: 1,
  },
  requirementTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    flexWrap: "wrap",
    gap: spacing.sm,
    marginBottom: 2,
  },
  requirementTitle: {
    fontSize: 15,
    fontWeight: "600",
  },
  importantBadge: {
    paddingHorizontal: 8,
    paddingVertical: 2,
    borderRadius: 4,
  },
  importantBadgeText: {
    color: "#FFFFFF",
    fontSize: 10,
    fontWeight: "600",
  },
  requirementDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  expectationsList: {
    gap: spacing.sm,
  },
  expectationItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: spacing.sm,
  },
  expectationIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  expectationContent: {
    flex: 1,
  },
  expectationTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  expectationDescription: {
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
