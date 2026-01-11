/**
 * Zomerkampen Countries/Destinations screen
 */

import { useCallback } from "react";
import { StyleSheet, View, Text, ScrollView, Pressable, Platform, Linking } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const DESTINATIONS = [
  {
    name: "Europa",
    description: "Verschillende Europese landen met rijke cultuur en geschiedenis",
    icon: "globe-outline",
  },
  {
    name: "Canada",
    description: "Prachtige natuur en vriendelijke cultuur in Noord-Amerika",
    icon: "leaf-outline",
  },
  {
    name: "Verenigde Staten",
    description: "Diverse staten met verschillende ervaringen en culturen",
    icon: "flag-outline",
  },
  {
    name: "Taiwan",
    description: "Fascinierende Aziatische cultuur en moderne technologie",
    icon: "sparkles-outline",
  },
];

const PROGRAM_TYPES = [
  {
    title: "Educatieve Tours",
    description: "Leren over geschiedenis, cultuur en taal",
    icon: "school-outline",
  },
  {
    title: "Avontuur Kampen",
    description: "Buitenactiviteiten en natuurverkenning",
    icon: "compass-outline",
  },
  {
    title: "Culturele Uitwisseling",
    description: "Onderdompeling in lokale gewoonten en tradities",
    icon: "people-outline",
  },
];

export default function CampsCountriesScreen() {
  const { colors } = useTheme();

  const handleContact = useCallback(async () => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      await Linking.openURL("mailto:interesse@rotaryyep.nl?subject=Interesse%20in%20Zomerkampen");
    } catch {
      // Silently fail
    }
  }, []);

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
            <Ionicons name="earth" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Met welke landen?</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Ontdek de bestemmingen beschikbaar voor Zomerkampen
          </Text>
        </View>

        {/* Destinations Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="location" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>
              Internationale Bestemmingen
            </Text>
          </View>

          <View style={styles.destinationsList}>
            {DESTINATIONS.map((destination, index) => (
              <View
                key={index}
                style={[styles.destinationItem, { backgroundColor: `${colors.primary}08` }]}
              >
                <View style={[styles.destinationIcon, { backgroundColor: `${colors.primary}15` }]}>
                  <Ionicons name={destination.icon as any} size={24} color={colors.primary} />
                </View>
                <View style={styles.destinationContent}>
                  <Text style={[styles.destinationName, { color: colors.text }]}>
                    {destination.name}
                  </Text>
                  <Text style={[styles.destinationDescription, { color: colors.textSecondary }]}>
                    {destination.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Program Types Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="layers" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Soorten Programma&apos;s</Text>
          </View>

          <View style={styles.programsList}>
            {PROGRAM_TYPES.map((program, index) => (
              <View key={index} style={[styles.programItem, { borderBottomColor: colors.border }]}>
                <View style={[styles.programIcon, { backgroundColor: `${colors.primary}10` }]}>
                  <Ionicons name={program.icon as any} size={22} color={colors.primary} />
                </View>
                <View style={styles.programContent}>
                  <Text style={[styles.programTitle, { color: colors.text }]}>{program.title}</Text>
                  <Text style={[styles.programDescription, { color: colors.textSecondary }]}>
                    {program.description}
                  </Text>
                </View>
              </View>
            ))}
          </View>
        </View>

        {/* Contact Card */}
        <View
          style={[
            styles.contactCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.contactHeader}>
            <Ionicons name="mail" size={24} color={colors.primary} />
            <Text style={[styles.contactTitle, { color: colors.text }]}>Aanmelden</Text>
          </View>
          <Text style={[styles.contactText, { color: colors.textSecondary }]}>
            Aanmelden via het emailadres interesse@rotaryyep.nl
          </Text>
          <Pressable
            style={({ pressed }) => [
              styles.contactButton,
              { backgroundColor: colors.primary },
              pressed && styles.buttonPressed,
            ]}
            onPress={handleContact}
          >
            <Text style={styles.contactButtonText}>Contact Opnemen</Text>
          </Pressable>
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
  destinationsList: {
    gap: spacing.sm,
  },
  destinationItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  destinationIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  destinationContent: {
    flex: 1,
  },
  destinationName: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 2,
  },
  destinationDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  programsList: {
    gap: spacing.sm,
  },
  programItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: spacing.sm,
  },
  programIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  programContent: {
    flex: 1,
  },
  programTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  programDescription: {
    fontSize: 13,
    lineHeight: 18,
  },
  contactCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
    marginTop: spacing.sm,
  },
  contactHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  contactTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  contactText: {
    fontSize: 14,
    lineHeight: 20,
    marginBottom: spacing.md,
  },
  contactButton: {
    padding: spacing.md,
    borderRadius: 10,
    alignItems: "center",
  },
  buttonPressed: {
    opacity: 0.9,
  },
  contactButtonText: {
    color: "#FFFFFF",
    fontSize: 15,
    fontWeight: "600",
  },
});
