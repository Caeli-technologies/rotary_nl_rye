/**
 * Flight & Arrival information screen for inbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function FlightArrivalScreen() {
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
            <Ionicons name="airplane" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Flight & Arrival</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Important information about your flight and arrival in the Netherlands
          </Text>
        </View>

        {/* Flight Information */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="airplane-outline" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Flight</Text>
          </View>

          <View style={styles.infoItem}>
            <View style={[styles.bulletPoint, { backgroundColor: colors.primary }]} />
            <Text style={[styles.infoText, { color: colors.textSecondary }]}>
              You should obtain a changeable open return airline ticket
            </Text>
          </View>

          <View style={styles.infoItem}>
            <View style={[styles.bulletPoint, { backgroundColor: colors.primary }]} />
            <Text style={[styles.infoText, { color: colors.textSecondary }]}>
              Your arrival airport is Amsterdam (Schiphol) Airport
            </Text>
          </View>

          <View style={[styles.airportBadge, { backgroundColor: `${colors.primary}10` }]}>
            <Ionicons name="location" size={20} color={colors.primary} />
            <Text style={[styles.airportText, { color: colors.primary }]}>
              Amsterdam Schiphol Airport (AMS)
            </Text>
          </View>
        </View>

        {/* Arrival Information */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="flag-outline" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Arrival</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            More arrival information will be provided closer to your departure date.
          </Text>
        </View>

        {/* Important Notes */}
        <View
          style={[
            styles.noteCard,
            { backgroundColor: `${colors.warning}15`, borderColor: `${colors.warning}30` },
          ]}
        >
          <View style={styles.noteHeader}>
            <Ionicons name="information-circle" size={24} color={colors.warning} />
            <Text style={[styles.noteTitle, { color: colors.text }]}>Important Notes</Text>
          </View>
          <Text style={[styles.noteText, { color: colors.textSecondary }]}>
            Please ensure your ticket is flexible so you can change your return date if needed. Your
            host family or Rotary coordinator will meet you at the airport upon arrival.
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
  infoItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    marginBottom: spacing.sm,
  },
  bulletPoint: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginTop: 6,
    marginRight: spacing.sm,
  },
  infoText: {
    flex: 1,
    fontSize: 15,
    lineHeight: 22,
  },
  airportBadge: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
    marginTop: spacing.md,
  },
  airportText: {
    fontSize: 15,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  noteCard: {
    borderRadius: 16,
    padding: spacing.lg,
    marginTop: spacing.md,
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
    fontSize: 15,
    lineHeight: 22,
  },
});
