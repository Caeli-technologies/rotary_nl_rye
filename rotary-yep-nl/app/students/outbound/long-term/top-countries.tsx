/**
 * Top 3 Countries selection tips screen for outbound students
 */

import { useCallback, useState } from "react";
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Image,
  Pressable,
  Linking,
  Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";

const TIPS = [
  {
    icon: "book-outline",
    text: "Lees in deze app de verhalen van exchange studenten",
  },
  {
    icon: "logo-youtube",
    text: "Kijk op YouTube en google 'Rotary Youth Exchange' dan kom je ook heel veel te weten.",
  },
  {
    icon: "chatbubbles-outline",
    text: "Praat met voormalige uitwisselingsstudenten over hun ervaringen in verschillende landen.",
  },
];

const VIDEO_URL = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"; // Replace with actual Rotary YEP Europe video

export default function TopCountriesScreen() {
  const { colors } = useTheme();
  const [imageLoaded, setImageLoaded] = useState(false);

  const handleWatchVideo = useCallback(async () => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      await Linking.openURL(VIDEO_URL);
    } catch {
      // Silently fail if video can't be opened
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
          <Text style={[styles.headerTitle, { color: colors.primary }]}>
            Goede top 3 van landen
          </Text>
          <Text style={[styles.headerSubtitle, { color: colors.textSecondary }]}>
            Tips voor het kiezen van jouw voorkeursbestemmingen
          </Text>
        </View>

        {/* Tips Card */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="bulb" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>
              Tips voor een goede keuze
            </Text>
          </View>

          <View style={styles.tipsList}>
            {TIPS.map((tip, index) => (
              <View
                key={index}
                style={[styles.tipItem, { backgroundColor: `${colors.primary}08` }]}
              >
                <View style={[styles.tipIcon, { backgroundColor: `${colors.primary}15` }]}>
                  <Ionicons name={tip.icon as any} size={22} color={colors.primary} />
                </View>
                <Text style={[styles.tipText, { color: colors.text }]}>{tip.text}</Text>
              </View>
            ))}
          </View>
        </View>

        {/* Video Section */}
        <View style={[styles.card, { backgroundColor: colors.card, shadowColor: colors.shadow }]}>
          <View style={styles.cardHeader}>
            <Ionicons name="play-circle" size={24} color={colors.primary} />
            <Text style={[styles.cardTitle, { color: colors.text }]}>Inspiratie Video</Text>
          </View>

          <Pressable
            style={({ pressed }) => [
              styles.videoContainer,
              { backgroundColor: colors.background },
              pressed && styles.videoPressed,
            ]}
            onPress={handleWatchVideo}
          >
            <View style={[styles.videoPlaceholder, { backgroundColor: `${colors.primary}10` }]}>
              <View style={[styles.playButton, { backgroundColor: colors.primary }]}>
                <Ionicons name="play" size={32} color="#FFFFFF" />
              </View>
            </View>
          </Pressable>

          <View style={styles.videoInfo}>
            <Text style={[styles.videoTitle, { color: colors.text }]}>Proud to be European</Text>
            <Text style={[styles.videoDescription, { color: colors.textSecondary }]}>
              Ontdek wat het betekent om een Europese uitwisselingsstudent te zijn en laat je
              inspireren door de verhalen van anderen.
            </Text>
          </View>
        </View>

        {/* Advice Card */}
        <View
          style={[
            styles.adviceCard,
            { backgroundColor: `${colors.success}10`, borderColor: `${colors.success}30` },
          ]}
        >
          <View style={styles.adviceHeader}>
            <Ionicons name="flag" size={24} color={colors.success} />
            <Text style={[styles.adviceTitle, { color: colors.text }]}>Advies</Text>
          </View>
          <Text style={[styles.adviceText, { color: colors.textSecondary }]}>
            Denk goed na over je keuze. Kies landen waar je écht naartoe wilt, niet alleen populaire
            bestemmingen. Elke ervaring is uniek!
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
  tipsList: {
    gap: spacing.sm,
  },
  tipItem: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: spacing.md,
    borderRadius: 12,
  },
  tipIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: spacing.sm,
  },
  tipText: {
    flex: 1,
    fontSize: 15,
    lineHeight: 22,
  },
  videoContainer: {
    borderRadius: 12,
    overflow: "hidden",
    marginBottom: spacing.md,
  },
  videoPressed: {
    opacity: 0.9,
  },
  videoPlaceholder: {
    width: "100%",
    aspectRatio: 16 / 9,
    justifyContent: "center",
    alignItems: "center",
  },
  playButton: {
    width: 64,
    height: 64,
    borderRadius: 32,
    justifyContent: "center",
    alignItems: "center",
    paddingLeft: 4,
  },
  videoInfo: {
    marginTop: spacing.xs,
  },
  videoTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  videoDescription: {
    fontSize: 14,
    lineHeight: 20,
  },
  adviceCard: {
    borderRadius: 16,
    padding: spacing.lg,
    borderWidth: 1,
    marginTop: spacing.sm,
  },
  adviceHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: spacing.sm,
  },
  adviceTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: spacing.sm,
  },
  adviceText: {
    fontSize: 15,
    lineHeight: 22,
  },
});
