/**
 * Selection Day information screen for outbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const EXAMPLE_QUESTIONS = [
  "Wat betekent volgens jou het zijn van Ambassadeur voor Rotary",
  "Wie is je rolmodel, voor wie heb je bewondering",
  "Wat was de gelukkigste/mooiste dag in je leven",
  "Op welke eigenschap ben je het meest trots",
  "Wat denk je dat het moeilijkste is als je een jaar in het buitenland bent",
];

export default function SelectionDayScreen() {
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
            <Ionicons name="calendar" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Selectie dag</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Wat je kunt verwachten tijdens de selectiedag voor Rotary Youth Exchange
          </Text>
        </View>

        {/* What to Do */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="bulb" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wat moet ik doen?</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Ik zou gewoon je best doen en jezelf zijn.
          </Text>
        </View>

        {/* What to Expect */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="eye" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wat kun je verwachten</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Je krijgt een interview, een groepsgesprek, een discussie en een test over je kennis van
            Nederland.
          </Text>
          <Text style={[styles.cardText, { color: colors.textSecondary, marginTop: spacing.sm }]}>
            Dit zijn een paar voorbeeld vragen uit het interview tijdens de selectie dag. We gaan je
            niet alles vertellen, maar zo krijg je een beetje een idee.
          </Text>
        </View>

        {/* Example Questions */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="help-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Voorbeeld vragen</Text>
          </View>

          <View style={styles.questionsList}>
            {EXAMPLE_QUESTIONS.map((question, index) => (
              <View
                key={index}
                style={[styles.questionItem, { backgroundColor: `${colors.primary}08` }]}
              >
                <View style={[styles.questionNumber, { backgroundColor: colors.primary }]}>
                  <Text style={styles.questionNumberText}>{index + 1}</Text>
                </View>
                <Text style={[styles.questionText, { color: colors.text }]}>{question}</Text>
              </View>
            ))}
          </View>
        </View>

        {/* Tip Card */}
        <View
          style={[
            styles.tipCard,
            { backgroundColor: `${colors.success}10`, borderColor: `${colors.success}30` },
          ]}
        >
          <View style={styles.tipHeader}>
            <Ionicons name="sparkles" size={24} color={colors.success} />
            <Text style={[styles.tipTitle, { color: colors.text }]}>Tip</Text>
          </View>
          <Text style={[styles.tipText, { color: colors.textSecondary }]}>
            Wees eerlijk en authentiek. De selectiecommissie wil jou leren kennen zoals je werkelijk
            bent!
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
  questionsList: {
    gap: spacing.sm,
  },
  questionItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: spacing.md,
    borderRadius: 12,
  },
  questionNumber: {
    width: 28,
    height: 28,
    borderRadius: 14,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.sm,
  },
  questionNumberText: {
    color: "#FFFFFF",
    fontSize: 14,
    fontWeight: "700",
  },
  questionText: {
    flex: 1,
    fontSize: 15,
    lineHeight: 22,
  },
  tipCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
    marginTop: spacing.sm,
  },
  tipHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  tipTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  tipText: {
    fontSize: 15,
    lineHeight: 22,
  },
});
