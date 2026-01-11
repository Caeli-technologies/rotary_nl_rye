/**
 * Zomerkampen Sign-up information screen
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

const EMAIL_ADDRESS = "zomerkamp@rotaryyep.nl";
const EMAIL_SUBJECT = "Interesse in Zomerkampen";

export default function CampsSignupScreen() {
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
            <Ionicons name="mail" size={32} color={colors.primary} />
          </View>
          <Text style={[styles.headerTitle, { color: colors.primary }]}>
            Hoe schrijf ik mezelf in?
          </Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Eenvoudige stappen om je aan te melden voor Zomerkampen
          </Text>
        </View>

        {/* Instructions Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="send" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Aanmelden</Text>
          </View>
          <View style={styles.stepContainer}>
            <View style={[styles.stepIcon, { backgroundColor: colors.primary }]}>
              <Ionicons name="mail-outline" size={20} color="#FFFFFF" />
            </View>
            <Text style={[styles.cardText, { color: colors.textSecondary }]}>
              Je stuurt een gezellig email bericht naar:{" "}
              <Text style={[styles.emailHighlight, { color: colors.primary }]}>
                {EMAIL_ADDRESS}
              </Text>
            </Text>
          </View>
          <Text style={[styles.confirmText, { color: colors.textSecondary }]}>
            Dan krijg je van ons een bevestiging dat we je mail hebben ontvangen.
          </Text>
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
          <Text style={styles.buttonText}>Verstuur een Email</Text>
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
  stepContainer: {
    flexDirection: "row",
    alignItems: "flex-start",
    marginBottom: spacing.md,
  },
  stepIcon: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  cardText: {
    flex: 1,
    fontSize: 15,
    lineHeight: 24,
  },
  emailHighlight: {
    fontWeight: "600",
  },
  confirmText: {
    fontSize: 14,
    lineHeight: 20,
    marginLeft: 52,
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
