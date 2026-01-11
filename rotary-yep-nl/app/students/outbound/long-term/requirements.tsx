/**
 * Requirements/Comply-with screen for outbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function RequirementsScreen() {
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
            <Ionicons name="clipboard-outline" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>
            Waar moet ik aan voldoen?
          </Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Regels en richtlijnen voor uitwisselingsstudenten
          </Text>
        </View>

        {/* Education Requirements */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="school" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Opleiding</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Zit je op het VMBO, HAVO of VWO dan kun je na selectie voor deze uitwisseling in
            aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een support
            club.
          </Text>
          <Text style={[styles.cardText, { color: colors.textSecondary, marginTop: spacing.sm }]}>
            Je hoeft nog geen diploma te hebben. Soms is het zelfs handig om je schoolcarrière even
            te onderbreken vanwege leeftijdsgrenzen in het buitenland.
          </Text>
        </View>

        {/* Age Card */}
        <View
          style={[
            styles.ageCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.ageHeader}>
            <Ionicons name="calendar" size={28} color={colors.primary} />
            <View style={styles.ageNumbers}>
              <Text style={[styles.ageRange, { color: colors.primary }]}>15 - 18 jaar</Text>
              <Text style={[styles.ageLabel, { color: colors.textSecondary }]}>
                Indicatieve leeftijdsgrenzen
              </Text>
            </View>
          </View>
          <View style={[styles.ageDivider, { backgroundColor: `${colors.primary}20` }]} />
          <Text style={[styles.ageNote, { color: colors.textSecondary }]}>
            Voor overheidsscholen, soms enige flexibiliteit mogelijk
          </Text>
        </View>

        {/* Support Club */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="people" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Support Club</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Je hebt een Rotaryclub nodig die jou wil voordragen als uitwisselingskandidaat. Dit
            wordt je support club. Zij zullen je begeleiden tijdens het hele proces.
          </Text>
        </View>

        {/* Important Notes */}
        <View
          style={[
            styles.noteCard,
            { backgroundColor: `${colors.warning}10`, borderColor: `${colors.warning}30` },
          ]}
        >
          <View style={styles.noteHeader}>
            <Ionicons name="information-circle" size={24} color={colors.warning} />
            <Text style={[styles.noteTitle, { color: colors.text }]}>Goed om te weten</Text>
          </View>
          <Text style={[styles.noteText, { color: colors.textSecondary }]}>
            De exacte leeftijdsgrenzen kunnen per land verschillen. Tijdens het selectieproces zal
            dit verder worden toegelicht.
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
  cardText: {
    fontSize: 15,
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
  noteCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
    marginTop: spacing.sm,
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
    fontSize: 15,
    lineHeight: 22,
  },
});
