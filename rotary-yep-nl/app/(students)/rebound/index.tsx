/**
 * Rebound countries list screen
 * Shows list of destination countries for rebound students
 */

import { useMemo, useCallback } from "react";
import {
  StyleSheet,
  View,
  Text,
  Pressable,
  FlatList,
  Platform,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { router } from "expo-router";
import * as Haptics from "expo-haptics";
import { useTheme } from "@/core/theme";
import { spacing } from "@/core/theme/spacing";
import {
  useStudents,
  groupByHostCountry,
  type CountryGroup,
} from "@/features/students";
import { getFlagAsset } from "@/shared/utils/flags";

const shadowStyle = {
  shadowColor: "#000",
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

interface CountryCardProps {
  country: CountryGroup;
  onPress: () => void;
}

function CountryCard({ country, onPress }: CountryCardProps) {
  const { colors } = useTheme();
  const flagAsset = getFlagAsset(country.country.code);

  return (
    <Pressable
      style={({ pressed }) => [
        styles.countryCard,
        { backgroundColor: colors.card, borderColor: colors.border },
        pressed && styles.countryCardPressed,
      ]}
      onPress={onPress}
      android_ripple={{
        color: "rgba(0, 122, 255, 0.2)",
        borderless: false,
      }}
    >
      <View style={styles.countryCardContent}>
        {flagAsset ? (
          <Image
            source={flagAsset}
            style={styles.flagImage}
            contentFit="contain"
          />
        ) : (
          <View
            style={[
              styles.flagImage,
              styles.flagPlaceholder,
              { backgroundColor: colors.backgroundElevated },
            ]}
          >
            <Text style={[styles.flagText, { color: colors.textTertiary }]}>
              {country.country.code.toUpperCase()}
            </Text>
          </View>
        )}
        <View style={styles.countryInfo}>
          <Text style={[styles.countryName, { color: colors.text }]}>
            {country.country.name}
          </Text>
          <Text
            style={[
              styles.countryStudentCount,
              { color: colors.textSecondary },
            ]}
          >
            {country.students.length} student
            {country.students.length !== 1 ? "s" : ""}
          </Text>
        </View>
        <Ionicons name="chevron-forward" size={20} color={colors.primary} />
      </View>
    </Pressable>
  );
}

export default function ReboundCountriesScreen() {
  const { colors } = useTheme();
  const { students } = useStudents("rebound");

  const countryGroups = useMemo(() => {
    return groupByHostCountry(students).sort(
      (a, b) => b.students.length - a.students.length,
    );
  }, [students]);

  const handleCountryPress = useCallback(async (country: CountryGroup) => {
    try {
      if (Platform.OS === "ios") {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      router.push({
        pathname: "/rebound/[country]",
        params: {
          country: country.country.code,
          countryName: country.country.name,
        },
      });
    } catch {
      router.push({
        pathname: "/rebound/[country]",
        params: {
          country: country.country.code,
          countryName: country.country.name,
        },
      });
    }
  }, []);

  const renderCountry = useCallback(
    ({ item }: { item: CountryGroup }) => (
      <CountryCard country={item} onPress={() => handleCountryPress(item)} />
    ),
    [handleCountryPress],
  );

  return (
    <SafeAreaView
      style={[styles.container, { backgroundColor: colors.background }]}
      edges={[]}
    >
      <FlatList
        data={countryGroups}
        renderItem={renderCountry}
        keyExtractor={(item) => item.country.code}
        showsVerticalScrollIndicator={false}
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.contentContainer}
        ItemSeparatorComponent={() => <View style={styles.separator} />}
      />
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  contentContainer: {
    paddingTop: spacing.lg,
    paddingBottom: spacing.xl,
  },
  countryCard: {
    borderRadius: 12,
    marginHorizontal: spacing.md,
    ...shadowStyle,
  },
  countryCardPressed: {
    opacity: Platform.OS === "ios" ? 0.8 : 1,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  countryCardContent: {
    flexDirection: "row",
    alignItems: "center",
    padding: spacing.md,
    minHeight: 64,
  },
  flagImage: {
    width: 48,
    height: 32,
    marginRight: spacing.md,
  },
  countryInfo: {
    flex: 1,
  },
  countryName: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
  },
  countryStudentCount: {
    fontSize: 14,
  },
  separator: {
    height: spacing.sm,
  },
  flagPlaceholder: {
    justifyContent: "center",
    alignItems: "center",
    borderRadius: 4,
  },
  flagText: {
    fontSize: 10,
    fontWeight: "600",
  },
});
