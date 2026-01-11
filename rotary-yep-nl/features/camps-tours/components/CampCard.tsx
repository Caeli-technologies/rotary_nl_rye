/**
 * Camp card component for displaying camp/tour information
 */

import { StyleSheet, View, Pressable, Platform, Text } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { Image } from "expo-image";
import { router } from "expo-router";
import { useTheme } from "@/core/theme";
import { getFlagAsset } from "@/shared/utils/flags";
import { isCampPast } from "../api";
import type { Camp } from "../types";

interface CampCardProps {
  camp: Camp;
}

export function CampCard({ camp }: CampCardProps) {
  const { colors } = useTheme();
  const isPast = isCampPast(camp);
  const hostCountries = camp.hostCountry.split("/");
  const hostCountryCodes = camp.hostCountryCode.split("/");

  const handlePress = () => {
    if (camp.invitation && camp.invitation.trim() !== "") {
      router.push({
        pathname: "/pdf-viewer",
        params: {
          url: camp.invitation,
          title: camp.title,
        },
      });
    }
  };

  return (
    <Pressable
      style={({ pressed }) => [
        styles.card,
        { backgroundColor: colors.card, borderColor: colors.border },
        camp.isFull && styles.cardFull,
        isPast && [styles.cardPast, { borderLeftColor: colors.textSecondary }],
        pressed && styles.cardPressed,
        Platform.OS === "ios" ? styles.shadowIOS : styles.shadowAndroid,
      ]}
      onPress={handlePress}
      android_ripple={{ color: "rgba(0, 122, 255, 0.2)", borderless: false }}
    >
      {/* Header */}
      <View style={styles.cardHeader}>
        <View style={styles.titleContainer}>
          <Text
            style={[styles.title, { color: colors.text }]}
            numberOfLines={2}
          >
            {camp.title}
          </Text>
          <View style={styles.badgeContainer}>
            {isPast && (
              <View
                style={[
                  styles.pastBadge,
                  { backgroundColor: colors.textSecondary },
                ]}
              >
                <Ionicons name="time" size={12} color="#fff" />
                <Text style={styles.pastBadgeText}>AFGELOPEN</Text>
              </View>
            )}
            {camp.isFull && (
              <View style={[styles.fullBadge, isPast && styles.badgeSpacing]}>
                <Ionicons name="warning" size={14} color="#fff" />
                <Text style={styles.fullBadgeText}>VOL</Text>
              </View>
            )}
          </View>
        </View>
        {camp.invitation && camp.invitation.trim() !== "" && (
          <View style={styles.actionIndicator}>
            <Ionicons
              name="document-text-outline"
              size={18}
              color={colors.textSecondary}
            />
          </View>
        )}
      </View>

      {/* Body */}
      <View style={styles.cardBody}>
        {/* Date */}
        <View
          style={[
            styles.dateContainer,
            { backgroundColor: colors.backgroundElevated },
            isPast && styles.dateContainerPast,
          ]}
        >
          <Ionicons
            name="calendar-outline"
            size={16}
            color={isPast ? colors.textSecondary : colors.primary}
          />
          <Text
            style={[
              styles.dateText,
              { color: isPast ? colors.textSecondary : colors.text },
            ]}
          >
            {camp.startDate} - {camp.endDate}
          </Text>
        </View>

        {/* Details Grid */}
        <View style={styles.detailsGrid}>
          {/* Country */}
          <View style={styles.detailItem}>
            <View style={styles.detailHeader}>
              <Ionicons
                name="location-outline"
                size={14}
                color={colors.textSecondary}
              />
              <Text
                style={[styles.detailLabel, { color: colors.textSecondary }]}
              >
                Land
              </Text>
            </View>
            <View style={styles.countryContainer}>
              {hostCountries.map((country, index) => {
                const countryCode = hostCountryCodes[index];
                const flagAsset = countryCode
                  ? getFlagAsset(countryCode.toLowerCase())
                  : null;

                return (
                  <View
                    key={`${country.trim()}-${index}`}
                    style={[
                      styles.countryItem,
                      { backgroundColor: colors.backgroundElevated },
                    ]}
                  >
                    {flagAsset && (
                      <Image
                        source={flagAsset}
                        style={styles.flag}
                        contentFit="cover"
                      />
                    )}
                    {!flagAsset && countryCode && (
                      <View
                        style={[
                          styles.flag,
                          styles.flagPlaceholder,
                          { backgroundColor: colors.background },
                        ]}
                      >
                        <Ionicons
                          name="flag-outline"
                          size={10}
                          color={colors.textSecondary}
                        />
                      </View>
                    )}
                    <Text
                      style={[styles.countryText, { color: colors.text }]}
                    >
                      {country.trim()}
                    </Text>
                  </View>
                );
              })}
            </View>
          </View>

          {/* District */}
          <View style={styles.detailItem}>
            <View style={styles.detailHeader}>
              <Ionicons
                name="business-outline"
                size={14}
                color={colors.textSecondary}
              />
              <Text
                style={[styles.detailLabel, { color: colors.textSecondary }]}
              >
                District
              </Text>
            </View>
            <Text style={[styles.detailValue, { color: colors.text }]}>
              {camp.hostDistrict}
            </Text>
          </View>

          {/* Age and Cost */}
          <View style={styles.detailRow}>
            <View style={styles.detailItem}>
              <View style={styles.detailHeader}>
                <Ionicons
                  name="people-outline"
                  size={14}
                  color={colors.textSecondary}
                />
                <Text
                  style={[styles.detailLabel, { color: colors.textSecondary }]}
                >
                  Leeftijd
                </Text>
              </View>
              <Text style={[styles.detailValue, { color: colors.text }]}>
                {camp.ageMin}-{camp.ageMax} jr
              </Text>
            </View>

            <View style={styles.detailItem}>
              <View style={styles.detailHeader}>
                <Ionicons
                  name="card-outline"
                  size={14}
                  color={colors.textSecondary}
                />
                <Text
                  style={[styles.detailLabel, { color: colors.textSecondary }]}
                >
                  Kosten
                </Text>
              </View>
              <Text style={[styles.detailValue, { color: colors.text }]}>
                {camp.contribution}
              </Text>
            </View>
          </View>
        </View>
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  card: {
    borderRadius: 12,
    marginBottom: 12,
    overflow: "hidden",
  },
  shadowIOS: {
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
  },
  shadowAndroid: {
    elevation: 2,
    borderWidth: StyleSheet.hairlineWidth,
  },
  cardFull: {
    borderLeftWidth: 4,
    borderLeftColor: "#FF3B30",
  },
  cardPast: {
    opacity: 0.7,
    borderLeftWidth: 4,
  },
  cardPressed: {
    opacity: 0.8,
    transform: Platform.OS === "ios" ? [{ scale: 0.98 }] : [],
  },
  cardHeader: {
    flexDirection: "row",
    alignItems: "flex-start",
    justifyContent: "space-between",
    paddingHorizontal: 16,
    paddingTop: 16,
    paddingBottom: 8,
  },
  titleContainer: {
    flex: 1,
    marginRight: 12,
  },
  title: {
    fontSize: 16,
    fontWeight: "600",
    lineHeight: 22,
    marginBottom: 4,
  },
  badgeContainer: {
    flexDirection: "column",
    alignItems: "flex-start",
    gap: 4,
  },
  pastBadge: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: 8,
    paddingVertical: 3,
    borderRadius: 10,
    alignSelf: "flex-start",
  },
  pastBadgeText: {
    fontSize: 10,
    fontWeight: "600",
    marginLeft: 3,
    letterSpacing: 0.5,
    color: "#FFFFFF",
  },
  fullBadge: {
    flexDirection: "row",
    alignItems: "center",
    backgroundColor: "#FF3B30",
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: "flex-start",
  },
  fullBadgeText: {
    fontSize: 11,
    fontWeight: "600",
    marginLeft: 4,
    letterSpacing: 0.5,
    color: "#FFFFFF",
  },
  badgeSpacing: {
    marginTop: 0,
  },
  actionIndicator: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: "center",
    alignItems: "center",
  },
  cardBody: {
    paddingHorizontal: 16,
    paddingBottom: 16,
  },
  dateContainer: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 8,
    marginBottom: 16,
  },
  dateContainerPast: {},
  dateText: {
    fontSize: 14,
    fontWeight: "500",
    marginLeft: 8,
  },
  detailsGrid: {
    gap: 16,
  },
  detailRow: {
    flexDirection: "row",
    gap: 16,
  },
  detailItem: {
    flex: 1,
  },
  detailHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 6,
  },
  detailLabel: {
    fontSize: 13,
    fontWeight: "500",
    marginLeft: 6,
  },
  detailValue: {
    fontSize: 15,
    fontWeight: "500",
  },
  countryContainer: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: 8,
  },
  countryItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 6,
  },
  countryText: {
    fontSize: 14,
    fontWeight: "500",
  },
  flag: {
    width: 16,
    height: 12,
    marginRight: 6,
    borderRadius: 2,
  },
  flagPlaceholder: {
    justifyContent: "center",
    alignItems: "center",
  },
});
