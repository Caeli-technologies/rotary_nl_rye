/**
 * Welcome to the Netherlands screen for inbound students
 * Comprehensive welcome information and expectations
 */

import { StyleSheet, View, Text, ScrollView } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

export default function WelcomeScreen() {
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
            <Ionicons name="heart" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>
            Welcome to the Netherlands!
          </Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            We are excited to have you join our Rotary Youth Exchange family
          </Text>
        </View>

        {/* Community Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="people" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Our Community</Text>
          </View>
          <Text
            style={[
              styles.cardBadge,
              { color: colors.primary, backgroundColor: `${colors.primary}15` },
            ]}
          >
            35-50 exchange students annually
          </Text>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            We are very excited about your upcoming stay with us and looking forward to meeting you.
            We hope and believe that you will enjoy your stay with us. We have an exciting and
            active Rotary International Youth Exchange Program with students from around the world.
          </Text>
          <Text style={[styles.cardText, { color: colors.textSecondary, marginTop: spacing.sm }]}>
            You will make friends from all over the world, in addition to making many Dutch friends
            in your school and Rotary.
          </Text>
        </View>

        {/* Exchange Experience Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="star" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Your Exchange Experience</Text>
          </View>
          <Text
            style={[
              styles.cardBadge,
              { color: colors.primary, backgroundColor: `${colors.primary}15` },
            ]}
          >
            One of the best years of your life
          </Text>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            A wonderful experience in a new culture, with a new language but also with some rules to
            make sure that your stay will be both enjoyable for you and us alike. These rules are
            consistent with the International Rotary rules.
          </Text>
        </View>

        {/* Ambassador Role Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="flag" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Ambassador Role</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Please remember that under all circumstances you are an ambassador of Rotary and will
            have to behave accordingly. Also you will be an ambassador of your country. Both
            functions will be with you at all times and you will be regarded and judged as such at
            all times during your exchange!
          </Text>
        </View>

        {/* Motto Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="ribbon" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Our Motto</Text>
          </View>
          <Text style={[styles.cardSubheading, { color: colors.textSecondary }]}>
            Live by these values during your exchange:
          </Text>
          <View style={styles.mottoGrid}>
            {[
              { icon: "heart-outline", text: "Be grateful" },
              { icon: "compass-outline", text: "Be on purpose" },
              { icon: "hand-left-outline", text: "Be of service" },
              { icon: "location-outline", text: "Be here now" },
              { icon: "trophy-outline", text: "Be first" },
              { icon: "search-outline", text: "Be curious" },
            ].map((item, index) => (
              <View
                key={index}
                style={[styles.mottoItem, { backgroundColor: `${colors.primary}08` }]}
              >
                <Ionicons name={item.icon as any} size={20} color={colors.primary} />
                <Text style={[styles.mottoText, { color: colors.text }]}>{item.text}</Text>
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
  cardBadge: {
    alignSelf: "flex-start",
    fontSize: 13,
    fontWeight: "600",
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.xs,
    borderRadius: 8,
    marginBottom: spacing.md,
    overflow: "hidden",
  },
  cardText: {
    fontSize: 15,
    lineHeight: 24,
  },
  cardSubheading: {
    fontSize: 15,
    marginBottom: spacing.md,
  },
  mottoGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    marginHorizontal: -spacing.xs,
  },
  mottoItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: spacing.sm,
    paddingVertical: spacing.sm,
    borderRadius: 10,
    margin: spacing.xs,
    minWidth: "45%",
  },
  mottoText: {
    fontSize: 14,
    fontWeight: "500",
    marginLeft: spacing.sm,
  },
});
