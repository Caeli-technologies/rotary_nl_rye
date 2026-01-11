/**
 * Outbound Short Term programs screen
 * Shows Zomerkampen and Family to Family exchange info
 */

import { useCallback, useMemo } from "react";
import { StyleSheet, View, Text, ScrollView, Pressable, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

interface InfoItem {
  title: string;
  subtitle: string;
  icon: keyof typeof Ionicons.glyphMap;
  route: string;
}

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export default function OutboundShortTermScreen() {
  const { colors } = useTheme();

  const handleNavigation = useCallback(async (route: string) => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push(route as any);
    } catch {
      router.push(route as any);
    }
  }, []);

  const zomerkampenInfo: InfoItem[] = useMemo(
    () => [
      {
        title: "Hoe schrijf ik mezelf in?",
        subtitle: "Aanmeldproces voor zomerkampen",
        icon: "mail",
        route: "/students/outbound/short-term/camps/signup",
      },
      {
        title: "Met welke landen?",
        subtitle: "Beschikbare bestemmingen en programma's",
        icon: "earth",
        route: "/students/outbound/short-term/camps/countries",
      },
      {
        title: "Voor wie?",
        subtitle: "Leeftijd en deelname informatie",
        icon: "people",
        route: "/students/outbound/short-term/camps/requirements",
      },
    ],
    [],
  );

  const familyToFamilyInfo: InfoItem[] = useMemo(
    () => [
      {
        title: "Hoe aanmelden",
        subtitle: "Stap-voor-stap aanmeldingsproces",
        icon: "mail",
        route: "/students/outbound/short-term/family-to-family/signup",
      },
      {
        title: "Landen & Voorkeur",
        subtitle: "Beschikbare bestemmingen en hoe te kiezen",
        icon: "globe",
        route: "/students/outbound/short-term/family-to-family/countries",
      },
      {
        title: "Vereisten",
        subtitle: "Regels en richtlijnen om te volgen",
        icon: "clipboard",
        route: "/students/outbound/short-term/family-to-family/requirements",
      },
    ],
    [],
  );

  const renderInfoItem = useCallback(
    (item: InfoItem) => (
      <Pressable
        key={item.route}
        style={({ pressed }) => [
          styles.infoItem,
          {
            backgroundColor: colors.card,
            borderColor: colors.border,
            shadowColor: colors.shadow,
          },
          pressed && styles.itemPressed,
        ]}
        onPress={() => handleNavigation(item.route)}
        android_ripple={{ color: `${colors.primary}20`, borderless: false }}
      >
        <View style={styles.infoItemContent}>
          <View style={[styles.infoIconContainer, { backgroundColor: `${colors.primary}15` }]}>
            <Ionicons name={item.icon} size={20} color={colors.primary} />
          </View>
          <View style={styles.infoTextContainer}>
            <Text style={[styles.infoItemTitle, { color: colors.text }]}>{item.title}</Text>
            <Text style={[styles.infoItemSubtitle, { color: colors.textSecondary }]}>
              {item.subtitle}
            </Text>
          </View>
          <Ionicons
            name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
            size={18}
            color={colors.textTertiary}
          />
        </View>
      </Pressable>
    ),
    [colors, handleNavigation],
  );

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
        {/* Intro */}
        <Text style={[styles.introText, { color: colors.textSecondary }]}>
          Rotary short-term programs offer young people the opportunity to experience different
          cultures through shorter exchange periods. These programs are perfect for students who
          want to gain international experience but cannot commit to a full year abroad.
        </Text>

        {/* Zomerkampen Section */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={[styles.sectionTitle, { color: colors.primary }]}>
              Wat zijn Zomerkampen?
            </Text>
            <View style={[styles.sectionDivider, { backgroundColor: colors.border }]} />
          </View>

          <Text style={[styles.sectionText, { color: colors.textSecondary }]}>
            Rotary Zomerkampen zijn kortdurende uitwisselingsprogramma&apos;s die meestal 2-6 weken
            duren tijdens schoolvakanties. Deze programma&apos;s bieden jongeren de mogelijkheid om
            verschillende culturen te ervaren, internationale vriendschappen te sluiten en deel te
            nemen aan spannende activiteiten terwijl ze verblijven bij gastgezinnen of in
            georganiseerde accommodaties.
          </Text>

          {/* Highlight Cards */}
          <View style={styles.highlightRow}>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="time" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>2-6 weken</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Duur</Text>
            </View>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="people" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>15-21 jaar</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Leeftijd</Text>
            </View>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="sunny" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>Vakanties</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Timing</Text>
            </View>
          </View>

          {/* View Camps Button */}
          <Pressable
            style={({ pressed }) => [
              styles.primaryButton,
              { backgroundColor: colors.primary },
              pressed && styles.buttonPressed,
            ]}
            onPress={() => handleNavigation("/camps-tours")}
          >
            <Ionicons name="earth" size={20} color="#FFFFFF" />
            <Text style={styles.primaryButtonText}>Bekijk Zomerkampen</Text>
          </Pressable>

          {/* Zomerkampen Info Items */}
          <Text style={[styles.infoSectionTitle, { color: colors.text }]}>
            Informatie & Richtlijnen
          </Text>
          {zomerkampenInfo.map(renderInfoItem)}
        </View>

        {/* Family to Family Section */}
        <View style={styles.sectionContainer}>
          <View style={styles.sectionHeader}>
            <Text style={[styles.sectionTitle, { color: colors.primary }]}>
              Wat is Family-to-Family?
            </Text>
            <View style={[styles.sectionDivider, { backgroundColor: colors.border }]} />
          </View>

          <Text style={[styles.sectionText, { color: colors.textSecondary }]}>
            Het Family-to-Family programma biedt jongeren de mogelijkheid om het leven in een andere
            cultuur te ervaren door 2-6 weken bij een gastgezin te verblijven. Dit is een
            authentieke culturele uitwisseling waarbij je ondergedompeld wordt in het dagelijks
            leven, lokale gewoonten en familietradities.
          </Text>

          {/* Highlight Cards */}
          <View style={styles.highlightRow}>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="time" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>2-6 weken</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Duur</Text>
            </View>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="people" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>15-25 jaar</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Leeftijd</Text>
            </View>
            <View style={[styles.highlightCard, { backgroundColor: `${colors.primary}10` }]}>
              <Ionicons name="home" size={24} color={colors.primary} />
              <Text style={[styles.highlightValue, { color: colors.primary }]}>Gastgezin</Text>
              <Text style={[styles.highlightLabel, { color: colors.textSecondary }]}>Verblijf</Text>
            </View>
          </View>

          {/* Family to Family Info Items */}
          <Text style={[styles.infoSectionTitle, { color: colors.text }]}>
            Informatie & Richtlijnen
          </Text>
          {familyToFamilyInfo.map(renderInfoItem)}
        </View>

        {/* How it works card */}
        <View
          style={[
            styles.infoCard,
            {
              backgroundColor: `${colors.primary}10`,
              borderColor: colors.border,
            },
          ]}
        >
          <View style={styles.infoHeader}>
            <Ionicons name="information-circle" size={24} color={colors.primary} />
            <Text style={[styles.infoTitle, { color: colors.text }]}>Hoe werkt het?</Text>
          </View>
          <Text style={[styles.infoCardText, { color: colors.textSecondary }]}>
            Short term exchanges typically last 2-6 weeks. Families agree to host a student from
            another country while their own child travels to that country to stay with the exchange
            family.
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
  introText: {
    fontSize: 15,
    lineHeight: 22,
    marginBottom: spacing.lg,
  },
  sectionContainer: {
    marginBottom: spacing.xl,
  },
  sectionHeader: {
    marginBottom: spacing.md,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "700",
    marginBottom: spacing.sm,
  },
  sectionDivider: {
    height: 2,
    borderRadius: 1,
  },
  sectionText: {
    fontSize: 15,
    lineHeight: 22,
    marginBottom: spacing.md,
  },
  highlightRow: {
    flexDirection: "row",
    gap: spacing.sm,
    marginBottom: spacing.lg,
  },
  highlightCard: {
    flex: 1,
    alignItems: "center",
    padding: spacing.md,
    borderRadius: 12,
  },
  highlightValue: {
    fontSize: 14,
    fontWeight: "700",
    marginTop: spacing.xs,
  },
  highlightLabel: {
    fontSize: 12,
    marginTop: 2,
  },
  primaryButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: spacing.md,
    borderRadius: 12,
    marginBottom: spacing.lg,
  },
  buttonPressed: {
    opacity: 0.9,
    transform: [{ scale: 0.98 }],
  },
  primaryButtonText: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  infoSectionTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: spacing.sm,
  },
  infoItem: {
    borderRadius: 12,
    marginBottom: spacing.sm,
    ...shadowStyle,
    ...(Platform.OS === "android" && {
      borderWidth: StyleSheet.hairlineWidth,
    }),
  },
  itemPressed: {
    opacity: 0.8,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  infoItemContent: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    minHeight: 64,
  },
  infoIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  infoTextContainer: {
    flex: 1,
    marginRight: spacing.sm,
  },
  infoItemTitle: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: 2,
  },
  infoItemSubtitle: {
    fontSize: 13,
  },
  infoCard: {
    borderRadius: 12,
    padding: spacing.md,
    marginTop: spacing.md,
    borderWidth: StyleSheet.hairlineWidth,
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
  infoCardText: {
    fontSize: 15,
    lineHeight: 22,
  },
});
