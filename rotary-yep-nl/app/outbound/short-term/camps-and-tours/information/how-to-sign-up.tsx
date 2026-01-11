import { useCallback } from "react";
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Platform,
  Pressable,
  Linking,
} from "react-native";
import * as Haptics from "expo-haptics";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/hooks/use-theme";
const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function CampsToursSignUpScreen() {
  const { colors: themeColors } = useTheme();

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      edges={["bottom"]}
    >
      <ScrollView
        style={[styles.scrollView, { backgroundColor: themeColors.background }]}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
      >
        <View style={styles.content}>
          {/* Header Section */}
          <View style={styles.headerSection}>
            <View
              style={[
                styles.headerIcon,
                { backgroundColor: `${themeColors.primary}15` },
              ]}
            >
              <Ionicons
                name="airplane-outline"
                size={32}
                color={themeColors.primary}
              />
            </View>
            <Text style={[styles.headerTitle, { color: themeColors.text }]}>
              Hoe schrijf ik mezelf in?
            </Text>
            <Text
              style={[
                styles.headerSubtitle,
                { color: themeColors.textSecondary },
              ]}
            >
              Eenvoudige stappen om je aan te melden voor Zomerkampen
            </Text>
          </View>

          {/* How to Apply */}
          <View style={styles.section}>
            <View style={styles.sectionHeader}>
              <Ionicons
                name="mail-outline"
                size={24}
                color={themeColors.primary}
              />
              <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                Aanmelden
              </Text>
            </View>

            <View
              style={[
                styles.emailCard,
                {
                  backgroundColor: themeColors.card,
                  borderColor: themeColors.border,
                },
              ]}
            >
              <Text style={[styles.emailTitle, { color: themeColors.text }]}>
                📧 Stuur een email
              </Text>
              <Text
                style={[
                  styles.emailDescription,
                  { color: themeColors.textSecondary },
                ]}
              >
                Je stuurt een gezellig email bericht naar:{" "}
                <Text style={[styles.emailLink, { color: themeColors.link }]}>
                  zomerkamp@rotaryyep.nl
                </Text>
              </Text>
              <Text
                style={[styles.emailNote, { color: themeColors.textTertiary }]}
              >
                Dan krijg je van ons een bevestiging dat we je mail hebben
                ontvangen.
              </Text>
            </View>

            <View style={styles.buttonContainer}>
              <Pressable
                style={({ pressed }) => [
                  styles.emailButton,
                  {
                    backgroundColor: themeColors.primary,
                    shadowColor: themeColors.shadow,
                  },
                  pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
                ]}
                onPress={useCallback(async () => {
                  try {
                    await Haptics.impactAsync(
                      Haptics.ImpactFeedbackStyle.Light,
                    );
                    const emailUrl =
                      "mailto:zomerkamp@rotaryyep.nl?subject=Interesse%20in%20Zomerkampen";
                    await Linking.openURL(emailUrl);
                  } catch (error) {
                    console.error("Error opening email:", error);
                  }
                }, [])}
                android_ripple={{
                  color: "rgba(255, 255, 255, 0.2)",
                  borderless: false,
                }}
                accessibilityRole="button"
                accessibilityLabel="Send email for summer camp interest"
                accessibilityHint="Opens email app to send inquiry"
                hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
              >
                <Ionicons
                  name="mail"
                  size={20}
                  color={themeColors.card}
                  style={{ marginRight: 8 }}
                />
                <Text
                  style={[styles.emailButtonText, { color: themeColors.card }]}
                >
                  Verstuur een Email
                </Text>
              </Pressable>
            </View>
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
    padding: Platform.OS === "ios" ? 16 : 12,
    paddingBottom: 30,
  },

  // Header Section
  headerSection: {
    alignItems: "center",
    paddingVertical: 24,
    marginBottom: 24,
  },
  headerIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: Platform.OS === "ios" ? 28 : 24,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    textAlign: "center",
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    textAlign: "center",
    lineHeight: 22,
    paddingHorizontal: 20,
  },

  // Section Styles
  section: {
    marginBottom: 32,
  },
  sectionHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: Platform.OS === "ios" ? 22 : 18,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    marginLeft: 12,
  },

  // Email Card Styles
  emailCard: {
    borderRadius: Platform.OS === "ios" ? 16 : 12,
    padding: 20,
    marginBottom: 24,
    ...(Platform.OS === "ios"
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  emailTitle: {
    fontSize: 20,
    fontWeight: "600",
    marginBottom: 12,
    textAlign: "center",
  },
  emailDescription: {
    fontSize: 16,
    lineHeight: 24,
    textAlign: "center",
    marginBottom: 12,
  },
  emailLink: {
    fontWeight: "600",
  },
  emailNote: {
    fontSize: 14,
    lineHeight: 20,
    textAlign: "center",
    fontStyle: "italic",
  },

  // Button Styles
  buttonContainer: {
    alignItems: "center",
    marginTop: 8,
  },
  emailButton: {
    borderRadius: Platform.OS === "ios" ? 12 : 8,
    paddingHorizontal: 24,
    paddingVertical: 16,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    minWidth: 200,
    ...(Platform.OS === "ios"
      ? {
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.3,
          shadowRadius: 4,
        }
      : {
          elevation: 3,
        }),
  },
  emailButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
