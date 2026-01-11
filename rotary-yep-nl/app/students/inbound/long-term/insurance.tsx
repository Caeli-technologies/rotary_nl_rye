/**
 * Insurance information screen for inbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function InsuranceScreen() {
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
            <Ionicons name="shield-checkmark" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Insurance</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Comprehensive insurance coverage for your exchange year
          </Text>
        </View>

        {/* Compulsory Coverage */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="checkmark-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Compulsory Coverage</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            The insurance policy from the Netherlands is compulsory. We will pre-insure you, so you
            will be fully insured as soon as you will land at Amsterdam Schiphol airport up until
            you are leaving at the airport again.
          </Text>
        </View>

        {/* Coverage Timeline */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="time" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Coverage Timeline</Text>
          </View>

          <View style={styles.timelineContainer}>
            {/* Arrival */}
            <View style={styles.timelineItem}>
              <View style={[styles.timelineDot, { backgroundColor: colors.success }]} />
              <View style={[styles.timelineLine, { backgroundColor: colors.border }]} />
              <View style={styles.timelineContent}>
                <Text style={[styles.timelineTitle, { color: colors.text }]}>
                  Arrival at Schiphol
                </Text>
                <Text style={[styles.timelineText, { color: colors.textSecondary }]}>
                  Coverage begins immediately upon landing
                </Text>
              </View>
            </View>

            {/* During Exchange */}
            <View style={styles.timelineItem}>
              <View style={[styles.timelineDot, { backgroundColor: colors.primary }]} />
              <View style={[styles.timelineLine, { backgroundColor: colors.border }]} />
              <View style={styles.timelineContent}>
                <Text style={[styles.timelineTitle, { color: colors.text }]}>During Exchange</Text>
                <Text style={[styles.timelineText, { color: colors.textSecondary }]}>
                  Full coverage throughout your stay
                </Text>
              </View>
            </View>

            {/* Departure */}
            <View style={styles.timelineItem}>
              <View style={[styles.timelineDot, { backgroundColor: colors.warning }]} />
              <View style={styles.timelineContent}>
                <Text style={[styles.timelineTitle, { color: colors.text }]}>Departure</Text>
                <Text style={[styles.timelineText, { color: colors.textSecondary }]}>
                  Coverage ends when you leave the airport
                </Text>
              </View>
            </View>
          </View>
        </View>

        {/* Policy Documents */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="document-text" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Policy Documents</Text>
          </View>
          <View style={[styles.documentBadge, { backgroundColor: `${colors.primary}10` }]}>
            <Ionicons name="mail" size={20} color={colors.primary} />
            <Text style={[styles.documentLabel, { color: colors.primary }]}>Document Delivery</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            A copy of the Insurance Policy will be sent to you a few days before you leave your home
            country.
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
  timelineContainer: {
    marginTop: spacing.sm,
  },
  timelineItem: {
    flexDirection: "row",
    marginBottom: spacing.md,
  },
  timelineDot: {
    width: 16,
    height: 16,
    borderRadius: 8,
    marginRight: spacing.md,
    marginTop: 2,
  },
  timelineLine: {
    position: "absolute",
    left: 7,
    top: 18,
    width: 2,
    height: 40,
  },
  timelineContent: {
    flex: 1,
  },
  timelineTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  timelineText: {
    fontSize: 14,
    lineHeight: 20,
  },
  documentBadge: {
    flexDirection: "row",
    alignItems: "center",
    alignSelf: "flex-start",
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
    borderRadius: 8,
    marginBottom: spacing.md,
  },
  documentLabel: {
    fontSize: 13,
    fontWeight: "600",
    marginLeft: spacing.xs,
  },
});
