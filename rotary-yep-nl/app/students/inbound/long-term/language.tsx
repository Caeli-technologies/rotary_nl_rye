/**
 * Language learning information screen for inbound students
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function LanguageScreen() {
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
            <Ionicons name="chatbubbles" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Language</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Learning Dutch for a successful exchange experience
          </Text>
        </View>

        {/* The Challenge */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="trending-up" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>The Challenge</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            There&apos;s no hiding it: Dutch is a very difficult language to learn. However, we do
            expect you to master the language and that within months after your arrival you will be
            fluent in our language.
          </Text>
        </View>

        {/* Dutch Orientation Course (DOC) */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="school" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>
              Dutch Orientation Course (DOC)
            </Text>
          </View>

          <View style={styles.docFeatures}>
            <View style={[styles.featureItem, { backgroundColor: `${colors.primary}08` }]}>
              <Ionicons name="calendar-outline" size={20} color={colors.primary} />
              <Text style={[styles.featureText, { color: colors.text }]}>
                September (August group) & February (new arrivals)
              </Text>
            </View>

            <View style={[styles.featureItem, { backgroundColor: `${colors.primary}08` }]}>
              <Ionicons name="time-outline" size={20} color={colors.primary} />
              <Text style={[styles.featureText, { color: colors.text }]}>
                6 days intensive course
              </Text>
            </View>

            <View style={[styles.featureItem, { backgroundColor: `${colors.primary}08` }]}>
              <Ionicons name="people-outline" size={20} color={colors.primary} />
              <Text style={[styles.featureText, { color: colors.text }]}>
                Small groups with fellow exchange students
              </Text>
            </View>

            <View style={[styles.featureItem, { backgroundColor: `${colors.primary}08` }]}>
              <Ionicons name="globe-outline" size={20} color={colors.primary} />
              <Text style={[styles.featureText, { color: colors.text }]}>
                Language learning + cultural insights
              </Text>
            </View>

            <View style={[styles.featureItem, { backgroundColor: `${colors.primary}08` }]}>
              <Ionicons name="happy-outline" size={20} color={colors.primary} />
              <Text style={[styles.featureText, { color: colors.text }]}>
                Lots of fun included with students from around the world!
              </Text>
            </View>
          </View>
        </View>

        {/* Host Family Support */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="home" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Host Family Support</Text>
          </View>
          <View style={[styles.badge, { backgroundColor: `${colors.primary}15` }]}>
            <Ionicons name="heart" size={16} color={colors.primary} />
            <Text style={[styles.badgeText, { color: colors.primary }]}>
              Your Learning Partners
            </Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Your first host family will also help you to learn Dutch and you will receive books to
            start learning the language as soon as you are in the Netherlands.
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
  docFeatures: {
    gap: spacing.sm,
  },
  featureItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  featureText: {
    flex: 1,
    fontSize: 14,
    lineHeight: 20,
    marginLeft: spacing.sm,
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
