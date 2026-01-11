/**
 * PDF Viewer screen route
 * Thin wrapper using the pdf-viewer feature module
 */

import { useState, useEffect, useLayoutEffect, useCallback } from "react";
import { StyleSheet, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { useLocalSearchParams, useNavigation } from "expo-router";
import PdfRendererView from "react-native-pdf-renderer";
import { useTheme } from "@/core/theme";
import { LoadingState, ErrorState } from "@/shared/components/feedback";
import {
  usePdfDownload,
  usePdfShare,
  PdfHeaderTitle,
  PdfShareButton,
} from "@/features/pdf-viewer";

export default function PDFViewerScreen() {
  const { colors } = useTheme();
  const navigation = useNavigation();
  const { url, title } = useLocalSearchParams<{ url: string; title: string }>();

  const { localFilePath, isLoading, error, retry } = usePdfDownload(url);
  const { handleShare } = usePdfShare(localFilePath, title);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);

  const handlePageChange = useCallback((current: number, total: number) => {
    setCurrentPage(current);
    setTotalPages(total);
  }, []);

  const handleError = useCallback((err?: string) => {
    console.error("PDF rendering error:", err);
  }, []);

  // Configure navigation header
  useLayoutEffect(() => {
    navigation.setOptions({
      headerTitle: () => (
        <PdfHeaderTitle
          title={title || "PDF Document"}
          currentPage={currentPage}
          totalPages={totalPages}
        />
      ),
      headerRight: () =>
        localFilePath && !isLoading ? (
          <PdfShareButton onPress={handleShare} />
        ) : null,
    });
  }, [
    navigation,
    title,
    localFilePath,
    isLoading,
    currentPage,
    totalPages,
    handleShare,
  ]);

  if (error) {
    return (
      <SafeAreaView
        style={[styles.container, { backgroundColor: colors.background }]}
        edges={["bottom"]}
      >
        <ErrorState message={error} onRetry={retry} />
      </SafeAreaView>
    );
  }

  if (isLoading || !localFilePath) {
    return (
      <SafeAreaView
        style={[styles.container, { backgroundColor: colors.background }]}
        edges={["bottom"]}
      >
        <LoadingState message="PDF laden..." />
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
      edges={["bottom"]}
    >
      <View style={styles.pdfContainer}>
        <PdfRendererView
          source={localFilePath}
          style={styles.pdf}
          distanceBetweenPages={16}
          maxZoom={20}
          maxPageResolution={2048}
          onPageChange={handlePageChange}
          onError={handleError}
        />
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  pdfContainer: {
    flex: 1,
  },
  pdf: {
    flex: 1,
  },
});
