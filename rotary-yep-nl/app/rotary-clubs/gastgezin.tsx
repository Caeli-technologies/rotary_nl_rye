import React, { useCallback } from "react";
import {
  StyleSheet,
  View,
  Text,
  ScrollView,
  Pressable,
  Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons, FontAwesome5 } from "@expo/vector-icons";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/hooks/use-theme";
interface DocumentItemProps {
  title: string;
  icon: keyof typeof FontAwesome5.glyphMap;
  pdfUrl: string;
}

const DocumentItem = React.memo(
  ({ title, icon, pdfUrl }: DocumentItemProps) => {
    const { colors: themeColors } = useTheme();

    const handlePress = useCallback(async () => {
      try {
        if (Platform.OS === "ios") {
          await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
        }
        router.push({
          pathname: "/pdf-viewer",
          params: {
            url: pdfUrl,
            title: title,
          },
        });
      } catch (error) {
        console.error("Error opening PDF:", error);
        router.push({
          pathname: "/pdf-viewer",
          params: {
            url: pdfUrl,
            title: title,
          },
        });
      }
    }, [pdfUrl, title]);

    return (
      <Pressable
        style={({ pressed }) => [
          styles.documentItem,
          {
            backgroundColor: themeColors.card,
            borderColor: themeColors.border,
            shadowColor: themeColors.shadow,
          },
          pressed && styles.documentItemPressed,
        ]}
        onPress={handlePress}
        android_ripple={{
          color: "rgba(0, 122, 255, 0.2)",
          borderless: false,
        }}
        accessibilityRole="button"
        accessibilityLabel={`Open ${title} PDF document`}
        accessibilityHint="Tap to view PDF in document viewer"
        hitSlop={{ top: 8, bottom: 8, left: 8, right: 8 }}
      >
        <View style={styles.documentContent}>
          <View
            style={[
              styles.iconContainer,
              { backgroundColor: themeColors.primary + "15" },
            ]}
          >
            <FontAwesome5 name={icon} size={22} color={themeColors.link} />
          </View>
          <View style={styles.textContainer}>
            <Text style={[styles.documentTitle, { color: themeColors.text }]}>
              {title}
            </Text>
            <Text
              style={[
                styles.documentSubtext,
                { color: themeColors.textSecondary },
              ]}
            >
              Tik om PDF te openen
            </Text>
          </View>
          <Ionicons
            name={Platform.OS === "ios" ? "chevron-forward" : "arrow-forward"}
            size={20}
            color={themeColors.textTertiary}
          />
        </View>
      </Pressable>
    );
  },
);
DocumentItem.displayName = "DocumentItem";

export default function GastgezinScreen() {
  const { colors: themeColors } = useTheme();

  const renderDocument = useCallback(
    (document: DocumentItemProps, index: number) => (
      <DocumentItem
        key={index}
        title={document.title}
        icon={document.icon}
        pdfUrl={document.pdfUrl}
      />
    ),
    [],
  );

  const documents = [
    {
      title: "Handboek Gastgezin",
      icon: "home" as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/handboek-gastgezin-versie-2025-2026-def.pdf",
    },
    {
      title: "First Night Questions",
      icon: "question-circle" as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/first-nights-questions-aangepast.pdf",
    },
    {
      title: "Travel rules within and outside the Netherlands",
      icon: "suitcase-rolling" as keyof typeof FontAwesome5.glyphMap,
      pdfUrl:
        "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/25-26/travel-rules-within-and-outside-the-netherlands-2024-2025.pdf",
    },
  ];

  return (
    <SafeAreaView
      style={[styles.safeArea, { backgroundColor: themeColors.background }]}
      edges={["bottom"]}
    >
      <View
        style={[styles.container, { backgroundColor: themeColors.background }]}
      >
        <ScrollView
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          contentInsetAdjustmentBehavior="automatic"
        >
          <Text
            style={[styles.description, { color: themeColors.textSecondary }]}
          >
            Informatie en documentatie voor gastgezinnen die een exchange
            student ontvangen.
          </Text>

          {documents.map(renderDocument)}
        </ScrollView>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  container: {
    flex: 1,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: 16,
    paddingBottom: 34,
  },
  description: {
    fontSize: 15,
    lineHeight: 22,
    marginBottom: 20,
    textAlign: "center",
    paddingHorizontal: 16,
  },
  documentItem: {
    borderRadius: 12,
    marginBottom: 12,
    overflow: "hidden",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 2,
  },
  documentItemPressed: {
    opacity: Platform.OS === "ios" ? 0.8 : 1,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  documentContent: {
    flexDirection: "row",
    alignItems: "center",
    padding: 16,
    minHeight: 72,
  },
  iconContainer: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: "center",
    justifyContent: "center",
    marginRight: 16,
  },
  textContainer: {
    flex: 1,
    marginRight: 8,
  },
  documentTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
    lineHeight: 22,
  },
  documentSubtext: {
    fontSize: 13,
    fontWeight: "400",
  },
});
