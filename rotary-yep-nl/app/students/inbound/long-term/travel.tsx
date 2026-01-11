/**
 * Travel rules and guidelines screen for inbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function TravelScreen() {
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
            <Ionicons name="map" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Travel</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Exploring the Netherlands during your exchange year
          </Text>
        </View>

        {/* Travel Guidelines */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="navigate" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Travel Guidelines</Text>
          </View>

          <Text style={[styles.sectionLabel, { color: colors.text }]}>Allowed Travel</Text>

          <View style={styles.allowedList}>
            <View style={[styles.allowedItem, { backgroundColor: `${colors.success}10` }]}>
              <Ionicons name="checkmark-circle" size={20} color={colors.success} />
              <Text style={[styles.allowedText, { color: colors.text }]}>
                With your host family
              </Text>
            </View>

            <View style={[styles.allowedItem, { backgroundColor: `${colors.success}10` }]}>
              <Ionicons name="checkmark-circle" size={20} color={colors.success} />
              <Text style={[styles.allowedText, { color: colors.text }]}>
                With Rotary club members
              </Text>
            </View>

            <View style={[styles.allowedItem, { backgroundColor: `${colors.success}10` }]}>
              <Ionicons name="checkmark-circle" size={20} color={colors.success} />
              <Text style={[styles.allowedText, { color: colors.text }]}>
                On authorized school trips
              </Text>
            </View>
          </View>

          <View
            style={[
              styles.noteBox,
              { backgroundColor: `${colors.primary}08`, borderColor: `${colors.primary}20` },
            ]}
          >
            <Ionicons name="information-circle" size={20} color={colors.primary} />
            <Text style={[styles.noteText, { color: colors.textSecondary }]}>
              Travel rules apply both inside the Netherlands and abroad
            </Text>
          </View>
        </View>

        {/* Strictly Prohibited */}
        <View
          style={[
            styles.warningCard,
            { backgroundColor: `${colors.error}08`, borderColor: `${colors.error}30` },
          ]}
        >
          <View style={styles.cardHeader}>
            <Ionicons name="warning" size={24} color={colors.error} />
            <Text style={[styles.cardTitle, { color: colors.error }]}>Strictly Prohibited</Text>
          </View>
          <Text style={[styles.warningText, { color: colors.text }]}>
            Visits to family or friends abroad are not permitted!
          </Text>
        </View>

        {/* Host Family Holidays */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="sunny" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Host Family Holidays</Text>
          </View>
          <View style={[styles.badge, { backgroundColor: `${colors.warning}15` }]}>
            <Ionicons name="document-text" size={16} color={colors.warning} />
            <Text style={[styles.badgeText, { color: colors.warning }]}>
              Parental Approval Required
            </Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            One of your host families might suggest to participate in a holiday somewhere abroad.
            This is usually OK when you will have a written approval from your parents.
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
  warningCard: {
    borderRadius: 16,
    padding: spacing.lg,
    marginBottom: spacing.md,
    borderWidth: 1,
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
  sectionLabel: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: spacing.sm,
  },
  allowedList: {
    gap: spacing.sm,
    marginBottom: spacing.md,
  },
  allowedItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  allowedText: {
    flex: 1,
    fontSize: 15,
    marginLeft: spacing.sm,
  },
  noteBox: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: spacing.md,
    borderRadius: 12,
    borderWidth: 1,
  },
  noteText: {
    flex: 1,
    fontSize: 14,
    lineHeight: 20,
    marginLeft: spacing.sm,
  },
  warningText: {
    fontSize: 16,
    fontWeight: "600",
    lineHeight: 24,
  },
  badge: {
    flexDirection: "row",
    alignItems: "center",
    alignSelf: "flex-start",
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
    borderRadius: 8,
    marginBottom: spacing.md,
  },
  badgeText: {
    fontSize: 13,
    fontWeight: "600",
    marginLeft: spacing.xs,
  },
});
