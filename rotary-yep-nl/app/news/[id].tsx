/**
 * News detail screen route
 * Thin wrapper using the news feature module
 */

import { useMemo } from "react";
import { View, Text, StyleSheet } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { useLocalSearchParams, router } from "expo-router";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { NewsDetail, convertRawNewsItem } from "@/features/news";
import type { RawNewsItem } from "@/features/news";

export default function NewsDetailScreen() {
  const { colors } = useTheme();
  const { content } = useLocalSearchParams<{ content: string }>();

  const newsItem = useMemo(() => {
    if (!content) return null;
    try {
      const raw: RawNewsItem = JSON.parse(content);
      return convertRawNewsItem(raw);
    } catch {
      return null;
    }
  }, [content]);

  const handleOpenPdf = () => {
    if (newsItem?.pdfUrl) {
      router.push({
        pathname: "/pdf-viewer",
        params: { url: newsItem.pdfUrl, title: newsItem.title },
      });
    }
  };

  if (!newsItem) {
    return (
      <SafeAreaView
        style={{ flex: 1, backgroundColor: colors.background }}
        edges={["bottom"]}
      >
        <View style={styles.centered}>
          <Ionicons name="alert-circle" size={64} color={colors.error} />
          <Text style={[styles.errorText, { color: colors.error }]}>
            Nieuwsbericht niet gevonden
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView
      style={{ flex: 1, backgroundColor: colors.background }}
      edges={["bottom"]}
    >
      <NewsDetail item={newsItem} onOpenPdf={handleOpenPdf} />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  centered: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: 40,
  },
  errorText: {
    marginTop: 16,
    fontSize: 18,
    fontWeight: "600",
    textAlign: "center",
  },
});
