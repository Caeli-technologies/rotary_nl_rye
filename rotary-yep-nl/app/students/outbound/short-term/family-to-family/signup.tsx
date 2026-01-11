/**
 * Family-to-Family Sign-up information screen
 */

import { useCallback } from "react";
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Pressable,
  Platform,
  Linking,
  Alert,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const EMAIL_ADDRESS = "interesse@rotaryyep.nl";
const EMAIL_SUBJECT = "Interesse in Family-to-Family uitwisseling";

const STEPS = [
  {
    number: 1,
    title: "Contact opnemen",
    description: "Stuur een email met je interesse en gegevens",
    icon: "mail-outline",
  },
  {
    number: 2,
    title: "Gesprek plannen",
    description: "We nemen contact op voor een kennismakingsgesprek",
    icon: "chatbubbles-outline",
  },
  {
    number: 3,
    title: "Gastgezin matchen",
    description: "We zoeken een passend gastgezin in het buitenland",
    icon: "people-outline",
  },
  {
    number: 4,
    title: "Voorbereiden",
    description: "Voorbereiding op je uitwisseling met tips en richtlijnen",
    icon: "book-outline",
  },
];

export default function FamilyToFamilySignupScreen() {
  const { colors } = useTheme();

  const handleSendEmail = useCallback(async () => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }

      const mailtoUrl = `mailto:${EMAIL_ADDRESS}?subject=${encodeURIComponent(EMAIL_SUBJECT)}`;
      const canOpen = await Linking.canOpenURL(mailtoUrl);

      if (canOpen) {
        await Linking.openURL(mailtoUrl);
      } else {
        Alert.alert(
          "Fout",
          `Kan e-mail app niet openen. Stuur handmatig een email naar ${EMAIL_ADDRESS}`,
        );
      }
    } catch {
      Alert.alert("Fout", "Er is iets misgegaan bij het openen van de e-mail app.");
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
            <Ionicons name="home" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>Hoe aanmelden?</Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Stappen om je aan te melden voor Family-to-Family
          </Text>
        </View>

        {/* Intro Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="information-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Wat is Family-to-Family?</Text>
          </View>
          <Text style={[styles.cardText, { color: colors.textSecondary }]}>
            Bij Family-to-Family verblijf je 2-6 weken bij een gastgezin in het buitenland, terwijl
            een jongere uit dat land bij jouw gezin verblijft. Een unieke manier om een andere
            cultuur van binnenuit te ervaren!
          </Text>
        </View>

        {/* Steps Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="list" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Aanmeldstappen</Text>
          </View>

          <View style={styles.stepsList}>
            {STEPS.map((step, index) => (
              <View key={step.number} style={styles.stepItem}>
                <View style={[styles.stepNumber, { backgroundColor: colors.primary }]}>
                  <Text style={styles.stepNumberText}>{step.number}</Text>
                </View>
                <View style={styles.stepContent}>
                  <Text style={[styles.stepTitle, { color: colors.text }]}>{step.title}</Text>
                  <Text style={[styles.stepDescription, { color: colors.textSecondary }]}>
                    {step.description}
                  </Text>
                </View>
                {index < STEPS.length - 1 && (
                  <View
                    style={[styles.stepConnector, { backgroundColor: `${colors.primary}30` }]}
                  />
                )}
              </View>
            ))}
          </View>
        </View>

        {/* Email Info Card */}
        <View
          style={[
            styles.emailCard,
            { backgroundColor: `${colors.primary}10`, borderColor: `${colors.primary}30` },
          ]}
        >
          <View style={styles.emailInfo}>
            <Ionicons name="at" size={24} color={colors.primary} />
            <View style={styles.emailDetails}>
              <Text style={[styles.emailLabel, { color: colors.textSecondary }]}>Email adres</Text>
              <Text style={[styles.emailAddress, { color: colors.primary }]}>{EMAIL_ADDRESS}</Text>
            </View>
          </View>
          <View style={[styles.divider, { backgroundColor: `${colors.primary}20` }]} />
          <View style={styles.emailInfo}>
            <Ionicons name="mail-outline" size={24} color={colors.primary} />
            <View style={styles.emailDetails}>
              <Text style={[styles.emailLabel, { color: colors.textSecondary }]}>Onderwerp</Text>
              <Text style={[styles.emailSubject, { color: colors.text }]}>{EMAIL_SUBJECT}</Text>
            </View>
          </View>
        </View>

        {/* Send Email Button */}
        <Pressable
          style={({ pressed }) => [
            styles.button,
            { backgroundColor: colors.primary },
            pressed && styles.buttonPressed,
          ]}
          onPress={handleSendEmail}
          android_ripple={{ color: "rgba(255,255,255,0.2)" }}
          accessibilityLabel="Verstuur een Email"
          accessibilityHint="Opent je email app voor het versturen van een email"
        >
          <Ionicons name="send" size={20} color="#FFFFFF" />
          <Text style={styles.buttonText}>Meld je aan</Text>
        </Pressable>
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
    lineHeight: 22,
  },
  stepsList: {
    gap: spacing.md,
  },
  stepItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    position: "relative",
  },
  stepNumber: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  stepNumberText: {
    color: "#FFFFFF",
    fontSize: 14,
    fontWeight: "700",
  },
  stepContent: {
    flex: 1,
    paddingBottom: spacing.md,
  },
  stepTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  stepDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  stepConnector: {
    position: "absolute",
    left: 15,
    top: 36,
    width: 2,
    height: 20,
    borderRadius: 1,
  },
  emailCard: {
    borderRadius: 16,
    padding: spacing.lg,
    marginBottom: spacing.lg,
    borderWidth: 1,
  },
  emailInfo: {
    flexDirection: "row",
    alignItems: "center",
  },
  emailDetails: {
    marginLeft: spacing.md,
    flex: 1,
  },
  emailLabel: {
    fontSize: 13,
    marginBottom: 2,
  },
  emailAddress: {
    fontSize: 16,
    fontWeight: "600",
  },
  emailSubject: {
    fontSize: 15,
    fontWeight: "500",
  },
  divider: {
    height: 1,
    marginVertical: spacing.md,
  },
  button: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  buttonPressed: {
    opacity: 0.9,
    transform: [{ scale: 0.98 }],
  },
  buttonText: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
});
