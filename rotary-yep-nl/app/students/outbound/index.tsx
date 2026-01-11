/**
 * Outbound students program selection screen
 * Thin wrapper using theme features
 */

import { useCallback, useMemo } from "react";
import { StyleSheet, View, Text, FlatList, Pressable, Platform } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons, FontAwesome5 } from "@expo/vector-icons";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

interface ProgramItem {
  title: string;
  subtitle: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  route: string;
  enabled?: boolean;
}

interface InfoItem {
  title: string;
  subtitle: string;
  icon: keyof typeof Ionicons.glyphMap;
  route: string;
}

export default function OutboundScreen() {
  const { colors } = useTheme();

  const handleProgramPress = useCallback(async (route: string, enabled: boolean = true) => {
    if (!enabled) return;

    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push(route as any);
    } catch {
      router.push(route as any);
    }
  }, []);

  const longTermPrograms: ProgramItem[] = useMemo(
    () => [
      {
        title: "Long Term Exchange Program",
        subtitle: "Year Exchange",
        icon: "calendar-alt",
        route: "/students/outbound/long-term",
        enabled: true,
      },
    ],
    [],
  );

  const shortTermPrograms: ProgramItem[] = useMemo(
    () => [
      {
        title: "Zomerkampen",
        subtitle: "Zomerkampen & Culturele Programmas",
        icon: "campground",
        route: "/camps-tours",
        enabled: true,
      },
      {
        title: "Family to Family",
        subtitle: "Exchange between families",
        icon: "home",
        route: "/students/outbound/short-term",
        enabled: true,
      },
    ],
    [],
  );

  const informationItems: InfoItem[] = useMemo(
    () => [
      {
        title: "Hoe meld ik me aan?",
        subtitle: "Volledige aanmeldprocedure en vereisten",
        icon: "mail",
        route: "/students/outbound/long-term/how-to-sign-up",
      },
      {
        title: "Selectie dag",
        subtitle: "Wat je kunt verwachten tijdens het selectieproces",
        icon: "calendar",
        route: "/students/outbound/long-term/selection-day",
      },
      {
        title: "Selectie weekend",
        subtitle: "Finale selectieweekend activiteiten en verwachtingen",
        icon: "calendar-outline",
        route: "/students/outbound/long-term/selection-weekend",
      },
      {
        title: "Goede top 3 van landen",
        subtitle: "Hoe kies je jouw voorkeursbestemmingen",
        icon: "earth",
        route: "/students/outbound/long-term/top-countries",
      },
      {
        title: "Waar moet ik aan voldoen?",
        subtitle: "Regels en richtlijnen voor uitwisselingsstudenten",
        icon: "clipboard",
        route: "/students/outbound/long-term/requirements",
      },
    ],
    [],
  );

  const renderProgramItem = useCallback(
    ({ item }: { item: ProgramItem }) => (
      <Pressable
        style={({ pressed }) => [
          styles.programItem,
          {
            backgroundColor: colors.card,
            borderColor: colors.border,
            shadowColor: colors.shadow,
          },
          pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
          !item.enabled && styles.programItemDisabled,
        ]}
        onPress={() => handleProgramPress(item.route, item.enabled)}
        android_ripple={{
          color: `${colors.primary}20`,
          borderless: false,
        }}
        disabled={!item.enabled}
      >
        <View style={styles.programContent}>
          <View style={[styles.iconContainer, { backgroundColor: `${colors.primary}15` }]}>
            <FontAwesome5
              name={item.icon}
              size={22}
              color={item.enabled ? colors.primary : colors.textTertiary}
            />
          </View>
          <View style={styles.textContainer}>
            <Text
              style={[
                styles.programTitle,
                { color: colors.text },
                !item.enabled && { color: colors.textTertiary },
              ]}
            >
              {item.title}
            </Text>
            <Text style={[styles.programSubtitle, { color: colors.textTertiary }]}>
              {item.subtitle}
            </Text>
          </View>
          <Ionicons
            name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
            size={20}
            color={item.enabled ? colors.textTertiary : colors.textDisabled}
          />
        </View>
      </Pressable>
    ),
    [colors, handleProgramPress],
  );

  const renderInfoItem = useCallback(
    ({ item }: { item: InfoItem }) => (
      <Pressable
        style={({ pressed }) => [
          styles.programItem,
          {
            backgroundColor: colors.card,
            borderColor: colors.border,
            shadowColor: colors.shadow,
          },
          pressed && { opacity: 0.7, transform: [{ scale: 0.98 }] },
        ]}
        onPress={() => handleProgramPress(item.route)}
        android_ripple={{
          color: `${colors.primary}20`,
          borderless: false,
        }}
      >
        <View style={styles.programContent}>
          <View style={[styles.iconContainer, { backgroundColor: `${colors.primary}15` }]}>
            <Ionicons name={item.icon} size={22} color={colors.primary} />
          </View>
          <View style={styles.textContainer}>
            <Text style={[styles.programTitle, { color: colors.text }]}>{item.title}</Text>
            <Text style={[styles.programSubtitle, { color: colors.textTertiary }]}>
              {item.subtitle}
            </Text>
          </View>
          <Ionicons
            name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
            size={20}
            color={colors.textTertiary}
          />
        </View>
      </Pressable>
    ),
    [colors, handleProgramPress],
  );

  const IntroSection = useCallback(
    () => (
      <View style={styles.introContainer}>
        <Text style={[styles.introTitle, { color: colors.primary }]}>Kandidaten</Text>
        <Text style={[styles.introText, { color: colors.textSecondary }]}>
          Wat leuk dat je ge&#239;nteresseerd in de mogelijkheden van Rotary voor uitwisseling.
          Wereldwijd gaan er jaarlijks zo&apos;n 8.000 studenten via Rotary op jaaruitwisseling, een
          hele organisatie.
        </Text>
      </View>
    ),
    [colors],
  );

  const SectionHeader = useCallback(
    ({ title }: { title: string }) => (
      <View style={styles.sectionHeaderContainer}>
        <Text style={[styles.sectionHeaderTitle, { color: colors.primary }]}>{title}</Text>
        <View style={[styles.sectionHeaderDivider, { backgroundColor: colors.border }]} />
      </View>
    ),
    [colors],
  );

  const listData = useMemo(
    () => [
      { type: "intro" },
      { type: "sectionHeader", title: "Long Term Exchange Program" },
      ...longTermPrograms.map((item) => ({ type: "program", item })),
      { type: "spacer" },
      { type: "sectionHeader", title: "Informatie" },
      ...informationItems.map((item) => ({ type: "info", item })),
      { type: "spacer" },
      { type: "sectionHeader", title: "Short Term Exchange Program" },
      ...shortTermPrograms.map((item) => ({ type: "program", item })),
    ],
    [longTermPrograms, informationItems, shortTermPrograms],
  );

  const renderItem = useCallback(
    ({ item }: { item: any }) => {
      switch (item.type) {
        case "intro":
          return <IntroSection />;
        case "sectionHeader":
          return <SectionHeader title={item.title} />;
        case "program":
          return renderProgramItem({ item: item.item });
        case "info":
          return renderInfoItem({ item: item.item });
        case "spacer":
          return <View style={styles.spacer} />;
        default:
          return null;
      }
    },
    [IntroSection, SectionHeader, renderProgramItem, renderInfoItem],
  );

  return (
    <SafeAreaView
      style={[styles.safeArea, { backgroundColor: colors.background }]}
      edges={["bottom"]}
    >
      <FlatList
        data={listData}
        renderItem={renderItem}
        keyExtractor={(item, index) => `${item.type}-${index}`}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.listContainer}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  listContainer: {
    padding: spacing.md,
    paddingBottom: spacing.xl,
  },
  introContainer: {
    marginBottom: spacing.xl,
  },
  introTitle: {
    fontSize: 24,
    fontWeight: "600",
    marginBottom: spacing.md,
  },
  introText: {
    fontSize: 15,
    lineHeight: 22,
  },
  sectionHeaderContainer: {
    marginBottom: spacing.md,
    marginTop: spacing.sm,
  },
  sectionHeaderTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: spacing.sm,
  },
  sectionHeaderDivider: {
    height: 2,
    borderRadius: 1,
  },
  programItem: {
    borderRadius: 12,
    marginBottom: spacing.sm,
    overflow: "hidden",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
  },
  programItemDisabled: {
    opacity: 0.6,
  },
  programContent: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    minHeight: 72,
  },
  iconContainer: {
    width: 44,
    height: 44,
    borderRadius: 22,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.md,
  },
  textContainer: {
    flex: 1,
    marginRight: spacing.sm,
  },
  programTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  programSubtitle: {
    fontSize: 13,
  },
  spacer: {
    height: spacing.sm,
  },
});
