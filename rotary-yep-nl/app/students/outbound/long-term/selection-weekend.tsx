/**
 * Selection Weekend information screen for outbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const GOALS = [
  {
    icon: "people",
    title: "Elkaar beter leren kennen",
    description:
      "Wij kunnen zó beter inschatten waar jullie als toekomstige Outbounds naar toe zouden kunnen gaan.",
  },
  {
    icon: "person",
    title: "Jezelf presenteren",
    description: "Laat zien wie je bent en wat je te bieden hebt als uitwisselingsstudent.",
  },
  {
    icon: "globe",
    title: "Je oriënteren op een top-drie van landen",
    description:
      "waarnaar je het liefst wilt worden uitgezonden. Zowel Internationaal als Europees.",
  },
  {
    icon: "trophy",
    title: "Selectie",
    description:
      "Je kunt laten zien dat je uit het goede 'uitwisselingshout' bent gesneden. Aanwezigheid is verplicht. Het weekend is dan ook onderdeel van de uiteindelijke selectie.",
  },
];

export default function SelectionWeekendScreen() {
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
            <Ionicons name="calendar-outline" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Selectie weekend</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Het selectieweekend als onderdeel van het uitwisselingsproces
          </Text>
        </View>

        {/* Goals Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="flag" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>
              Het weekend dient een aantal doelen:
            </Text>
          </View>

          <View style={styles.goalsList}>
            {GOALS.map((goal, index) => (
              <View
                key={index}
                style={[styles.goalItem, { backgroundColor: `${colors.primary}05` }]}
              >
                <View style={[styles.goalIcon, { backgroundColor: `${colors.primary}15` }]}>
                  <Ionicons name={goal.icon as any} size={24} color={colors.primary} />
                </View>
                <View style={styles.goalContent}>
                  <Text style={[styles.goalTitle, { color: colors.text }]}>{goal.title}</Text>
                  <Text style={[styles.goalDescription, { color: colors.textSecondary }]}>
                    {goal.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Important Info Card */}
        <View
          style={[
            styles.infoCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.infoHeader}>
            <Ionicons name="information-circle" size={24} color={colors.primary} />
            <Text style={[styles.infoTitle, { color: colors.text }]}>Belangrijk om te weten</Text>
          </View>
          <Text style={[styles.infoText, { color: colors.textSecondary }]}>
            Je krijgt een mail van ons voor het weekend waarin staat wat je moet meenemen, en wat je
            moet voorbereiden. Het is altijd een topweekend.
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
    marginBottom: spacing.lg,
  },
  cardTitle: {
    flex: 1,
    fontSize: 17,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  goalsList: {
    gap: spacing.md,
  },
  goalItem: {
    flexDirection: "row",
    padding: spacing.md,
    borderRadius: 12,
  },
  goalIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  goalContent: {
    flex: 1,
  },
  goalTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  goalDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  infoCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
    marginTop: spacing.sm,
  },
  infoHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  infoText: {
    fontSize: 15,
    lineHeight: 22,
  },
});
