/**
 * News detail component for displaying full news content
 */

import {
  ScrollView,
  View,
  Text,
  Pressable,
  StyleSheet,
  Platform,
} from "react-native";
import { Image } from "expo-image";
import { Ionicons } from "@expo/vector-icons";
import { Video, ResizeMode } from "expo-av";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import { NetworkImage } from "@/shared/components/media/NetworkImage";
import { useHaptics } from "@/shared/hooks";
import type { NewsItem, NewsTextBlock } from "../types";

interface NewsDetailProps {
  item: NewsItem;
  onOpenPdf?: () => void;
}

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

export function NewsDetail({ item, onOpenPdf }: NewsDetailProps) {
  const { colors } = useTheme();
  const { triggerLight } = useHaptics();

  const handleOpenPdf = async () => {
    await triggerLight();
    onOpenPdf?.();
  };

  return (
    <ScrollView
      style={[styles.container, { backgroundColor: colors.background }]}
      showsVerticalScrollIndicator={false}
      contentInsetAdjustmentBehavior="automatic"
    >
      {/* Hero Image */}
      <View style={styles.heroContainer}>
        <NetworkImage
          source={item.imageUrl}
          fallbackName={item.title}
          style={styles.heroImage}
        />
      </View>

      <View style={styles.content}>
        {/* Title Section */}
        <View
          style={[
            styles.titleSection,
            {
              backgroundColor: colors.card,
              borderColor: colors.border,
              shadowColor: colors.shadow,
            },
          ]}
        >
          <Text style={[styles.title, { color: colors.text }]}>
            {item.title}
          </Text>
          <Text style={[styles.description, { color: colors.textSecondary }]}>
            {item.description}
          </Text>
        </View>

        {/* PDF Button */}
        {item.isPdf && item.pdfUrl && (
          <Pressable
            style={({ pressed }) => [
              styles.pdfButton,
              { backgroundColor: colors.primary },
              pressed && styles.pdfButtonPressed,
            ]}
            onPress={handleOpenPdf}
          >
            <Ionicons name="document-text" size={24} color="#FFFFFF" />
            <View style={styles.pdfButtonContent}>
              <Text style={styles.pdfButtonTitle}>Open PDF</Text>
              <Text style={styles.pdfButtonSubtitle}>
                View the full document
              </Text>
            </View>
            <Ionicons name="open-outline" size={20} color="#FFFFFF" />
          </Pressable>
        )}

        {/* Text Content */}
        {item.textContent && item.textContent.length > 0 && (
          <View style={styles.textContentContainer}>
            {item.textContent.map((block, blockIndex) => (
              <TextBlockView key={blockIndex} block={block} colors={colors} />
            ))}
          </View>
        )}

        {/* Bottom spacing */}
        <View style={{ height: spacing.xl }} />
      </View>
    </ScrollView>
  );
}

interface TextBlockViewProps {
  block: NewsTextBlock;
  colors: ReturnType<typeof useTheme>["colors"];
}

function TextBlockView({ block, colors }: TextBlockViewProps) {
  return (
    <View
      style={[
        styles.textBlock,
        {
          backgroundColor: colors.card,
          borderColor: colors.border,
          shadowColor: colors.shadow,
        },
      ]}
    >
      {/* Section Heading */}
      {block.heading && (
        <View
          style={[
            styles.headingContainer,
            { borderBottomColor: colors.border },
          ]}
        >
          <Text style={[styles.heading, { color: colors.primary }]}>
            {block.heading}
          </Text>
        </View>
      )}

      {/* Body Content */}
      {block.body &&
        block.body.map((bodyItem, bodyIndex) => (
          <View key={bodyIndex} style={styles.bodyItem}>
            {/* Paragraphs */}
            {bodyItem.paragraph &&
              bodyItem.paragraph.map((para, paraIndex) => (
                <Text
                  key={paraIndex}
                  style={[styles.paragraph, { color: colors.text }]}
                >
                  {para}
                </Text>
              ))}

            {/* Inline Image */}
            {bodyItem.imageUrl && (
              <View style={styles.inlineImageContainer}>
                <Image
                  source={{ uri: bodyItem.imageUrl }}
                  style={styles.inlineImage}
                  contentFit="cover"
                />
              </View>
            )}

            {/* Video */}
            {bodyItem.videoUrl && (
              <View style={styles.videoContainer}>
                <Video
                  source={{ uri: bodyItem.videoUrl }}
                  style={styles.video}
                  useNativeControls
                  resizeMode={ResizeMode.CONTAIN}
                />
              </View>
            )}
          </View>
        ))}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  heroContainer: {
    width: "100%",
    height: 220,
  },
  heroImage: {
    width: "100%",
    height: "100%",
  },
  content: {
    padding: spacing.md,
    marginTop: -spacing.lg,
  },
  titleSection: {
    borderRadius: spacing.radiusLg,
    padding: spacing.lg,
    marginBottom: spacing.md,
    ...(Platform.OS === "ios"
      ? shadowStyle
      : { elevation: 3, borderWidth: StyleSheet.hairlineWidth }),
  },
  title: {
    fontSize: Platform.OS === "ios" ? 24 : 22,
    fontWeight: Platform.OS === "ios" ? "700" : "600",
    marginBottom: spacing.sm,
    lineHeight: 32,
  },
  description: {
    fontSize: 16,
    lineHeight: 24,
  },
  pdfButton: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    borderRadius: spacing.radiusMd,
    marginBottom: spacing.md,
    gap: spacing.sm,
  },
  pdfButtonPressed: {
    opacity: 0.9,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  pdfButtonContent: {
    flex: 1,
  },
  pdfButtonTitle: {
    color: "#FFFFFF",
    fontSize: 16,
    fontWeight: "600",
  },
  pdfButtonSubtitle: {
    color: "rgba(255, 255, 255, 0.8)",
    fontSize: 13,
  },
  textContentContainer: {
    gap: spacing.md,
  },
  textBlock: {
    borderRadius: spacing.radiusMd,
    overflow: "hidden",
    ...(Platform.OS === "ios"
      ? shadowStyle
      : { elevation: 2, borderWidth: StyleSheet.hairlineWidth }),
  },
  headingContainer: {
    paddingHorizontal: spacing.md,
    paddingVertical: spacing.sm,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  heading: {
    fontSize: 18,
    fontWeight: "600",
  },
  bodyItem: {
    padding: spacing.md,
  },
  paragraph: {
    fontSize: 16,
    lineHeight: 24,
    marginBottom: spacing.sm,
  },
  inlineImageContainer: {
    marginVertical: spacing.sm,
    borderRadius: spacing.radiusSm,
    overflow: "hidden",
  },
  inlineImage: {
    width: "100%",
    height: 200,
  },
  videoContainer: {
    marginVertical: spacing.sm,
    borderRadius: spacing.radiusSm,
    overflow: "hidden",
    backgroundColor: "#000",
  },
  video: {
    width: "100%",
    aspectRatio: 16 / 9,
  },
});
