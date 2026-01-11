import {
  ScrollView,
  StyleSheet,
  View,
  Text,
  Platform,
  Pressable,
} from "react-native";
import { Image } from "expo-image";
import { Ionicons } from "@expo/vector-icons";
import { makePhoneCall, sendEmail } from "@/utils/communications";

import * as Haptics from "expo-haptics";
import { useTheme } from "@/hooks/use-theme";

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface EmergencyContact {
  name: string;
  function: string;
  phone: string;
  email?: string;
}

const EmergencyContactCard = ({ contact }: { contact: EmergencyContact }) => {
  const { colors: themeColors } = useTheme();

  const handleCall = async (phone: string, name: string) => {
    if (Platform.OS === "ios") {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    }
    makePhoneCall(phone, name);
  };

  const handleEmail = async (email: string, name: string) => {
    if (Platform.OS === "ios") {
      await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
    }
    sendEmail(email, name);
  };

  return (
    <View
      style={[
        styles.contactCard,
        {
          backgroundColor: themeColors.card,
          shadowColor: themeColors.shadow,
          borderColor: themeColors.border,
        },
      ]}
    >
      <View style={styles.contactInfo}>
        <Text style={[styles.contactName, { color: themeColors.text }]}>
          {contact.name}
        </Text>
        <Text
          style={[styles.contactFunction, { color: themeColors.textSecondary }]}
        >
          {contact.function}
        </Text>
        <Text style={[styles.contactPhone, { color: themeColors.accent }]}>
          {contact.phone}
        </Text>
      </View>
      <View style={styles.contactActions}>
        <Pressable
          style={({ pressed }) => [
            styles.actionButton,
            { backgroundColor: `${themeColors.primary}15` },
            pressed && styles.actionButtonPressed,
          ]}
          onPress={() => handleCall(contact.phone, contact.name)}
        >
          <Ionicons name="call" size={20} color={themeColors.primary} />
        </Pressable>
        {contact.email && (
          <Pressable
            style={({ pressed }) => [
              styles.actionButton,
              { backgroundColor: `${themeColors.primary}15` },
              pressed && styles.actionButtonPressed,
            ]}
            onPress={() =>
              contact.email && handleEmail(contact.email, contact.name)
            }
          >
            <Ionicons name="mail" size={20} color={themeColors.primary} />
          </Pressable>
        )}
      </View>
    </View>
  );
};

export default function EmergencyScreen() {
  const { colors: themeColors } = useTheme();
  const rotaryYouthExchange: EmergencyContact[] = [
    {
      name: "Barbara Tusveld",
      function: "Voorzitter Rotary Youth Exchange",
      phone: "+31655128529",
    },
    {
      name: "Marga Oosterveld",
      function: "Voorzitter Longterm",
      phone: "+31629586813",
    },
    {
      name: "Clasine Scheepers",
      function: "Secretaris",
      phone: "+31652710977",
    },
    {
      name: "Hilleke van der Veer",
      function: "Landelijke Counselor",
      phone: "+31638300427",
    },
  ];

  const confidants: EmergencyContact[] = [
    {
      name: "Pauline Memelink",
      function: "Lawyer",
      phone: "+31624235624",
      email: "p.memelink@t-mobilethuis.nl",
    },
    {
      name: "Reinout Vriesendorp",
      function: "Doctor's office",
      phone: "+31182612676",
      email: "info@medischcentrumwest.org",
    },
  ];

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: themeColors.background }]}
      showsVerticalScrollIndicator={false}
      contentInsetAdjustmentBehavior="automatic"
      automaticallyAdjustContentInsets={true}
    >
      <View style={styles.content}>
        {/* Emergency 112 Section */}
        <View
          style={[
            styles.emergencySection,
            {
              backgroundColor: `${themeColors.error}10`,
              shadowColor: themeColors.shadow,
              borderColor: themeColors.border,
            },
          ]}
        >
          <View style={styles.emergencyHeader}>
            <Ionicons name="warning" size={24} color={themeColors.error} />
            <Text style={[styles.emergencyTitle, { color: themeColors.text }]}>
              Emergency Services
            </Text>
          </View>
          <Text
            style={[
              styles.emergencySubtitle,
              { color: themeColors.textSecondary },
            ]}
          >
            112 for ambulance, fire brigade or police
          </Text>
          <Image
            source={require("@/assets/emergency/112_logo.png")}
            style={styles.emergencyImage}
            contentFit="contain"
          />
        </View>

        {/* Rotary Youth Exchange */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Ionicons
              name="shield-checkmark"
              size={20}
              color={themeColors.primary}
            />
            <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
              Rotary Youth Exchange
            </Text>
          </View>
          {rotaryYouthExchange.map((contact) => (
            <EmergencyContactCard key={contact.phone} contact={contact} />
          ))}
        </View>

        {/* Confidants */}
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <Ionicons name="heart" size={20} color={themeColors.primary} />
            <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
              Independent Confidants
            </Text>
          </View>
          <Text
            style={[
              styles.sectionDescription,
              { color: themeColors.textSecondary },
            ]}
          >
            Not connected to Rotary - In case of f.e. sexual harassment
          </Text>
          {confidants.map((contact) => (
            <EmergencyContactCard key={contact.phone} contact={contact} />
          ))}
        </View>

        {/* Important Note */}
        <View
          style={[
            styles.noteCard,
            {
              backgroundColor: `${themeColors.warning}10`,
              shadowColor: themeColors.shadow,
              borderLeftColor: themeColors.warning,
            },
          ]}
        >
          <View style={styles.noteHeader}>
            <Ionicons
              name="information-circle"
              size={24}
              color={themeColors.warning}
            />
            <Text style={[styles.noteTitle, { color: themeColors.text }]}>
              Important Reminder
            </Text>
          </View>
          <Text style={[styles.noteText, { color: themeColors.textSecondary }]}>
            Always keep your host family&apos;s contact information and home
            address accessible.
          </Text>
          <Text style={[styles.noteText, { color: themeColors.textSecondary }]}>
            Your host parents can assist you with medical appointments, hospital
            visits, or dental care.
          </Text>
        </View>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    padding: Platform.OS === "ios" ? 16 : 12,
    paddingTop: Platform.OS === "ios" ? 8 : 12,
    paddingBottom: Platform.OS === "android" ? 100 : 40,
  },

  // Emergency Section
  emergencySection: {
    borderRadius: Platform.OS === "ios" ? 16 : 12,
    padding: 24,
    marginBottom: 20,
    alignItems: "center",
    ...(Platform.OS === "ios"
      ? shadowStyle
      : {
          elevation: 3,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  emergencyHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 8,
  },
  emergencyTitle: {
    fontSize: Platform.OS === "ios" ? 20 : 18,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    marginLeft: 8,
  },
  emergencySubtitle: {
    fontSize: 16,
    textAlign: "center",
    marginBottom: 16,
  },
  emergencyImage: {
    width: "100%",
    height: 100,
    maxWidth: 200,
  },

  // Section Styles
  section: {
    marginBottom: 24,
  },
  sectionHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 8,
  },
  sectionTitle: {
    fontSize: Platform.OS === "ios" ? 22 : 18,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    marginLeft: 8,
  },
  sectionDescription: {
    fontSize: 14,
    marginBottom: 16,
    lineHeight: 20,
  },

  // Contact Card Styles
  contactCard: {
    borderRadius: Platform.OS === "ios" ? 12 : 8,
    padding: 16,
    marginBottom: 12,
    flexDirection: "row",
    alignItems: "center",
    ...(Platform.OS === "ios"
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
  },
  contactInfo: {
    flex: 1,
  },
  contactName: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 4,
  },
  contactFunction: {
    fontSize: 14,
    marginBottom: 2,
  },
  contactPhone: {
    fontSize: 14,
    fontWeight: "500",
  },
  contactActions: {
    flexDirection: "row",
    gap: 8,
  },
  actionButton: {
    width: Platform.OS === "ios" ? 44 : 48,
    height: Platform.OS === "ios" ? 44 : 48,
    borderRadius: Platform.OS === "ios" ? 22 : 24,
    justifyContent: "center",
    alignItems: "center",
  },
  actionButtonPressed: {
    opacity: 0.8,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },

  // Note Card Styles
  noteCard: {
    borderRadius: Platform.OS === "ios" ? 16 : 12,
    padding: 20,
    marginTop: 8,
    borderLeftWidth: 4,
    ...(Platform.OS === "ios"
      ? {
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 4,
        }
      : {
          elevation: 1,
        }),
  },
  noteHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 12,
  },
  noteTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginLeft: 8,
  },
  noteText: {
    fontSize: 16,
    lineHeight: 24,
    marginBottom: 8,
  },
});
