/**
 * Event card component for calendar events list
 */

import { StyleSheet, View, Pressable, Platform } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { useTheme } from "@/core/theme";
import { formatEventTime, isMultiDayEvent } from "../utils";
import type { CalendarEvent, EventWithOriginalData } from "../types";

interface EventCardProps {
  event: CalendarEvent;
  onPress: (event: CalendarEvent) => void;
}

export function EventCard({ event, onPress }: EventCardProps) {
  const { colors } = useTheme();

  const eventWithOriginal = event as EventWithOriginalData;
  const isAllDay =
    eventWithOriginal._originalStart?.date !== undefined &&
    !eventWithOriginal._originalStart?.dateTime;
  const isMultiDay = isMultiDayEvent(event);

  const timeDisplay = isAllDay
    ? "Hele dag"
    : formatEventTime(event.start.dateTime, event.end.dateTime);

  return (
    <Pressable
      onPress={() => onPress(event)}
      style={({ pressed }) => [
        styles.container,
        {
          backgroundColor: colors.card,
          borderColor: colors.border,
          opacity: pressed ? 0.7 : 1,
        },
        Platform.OS === "ios" ? styles.shadowIOS : styles.shadowAndroid,
      ]}
    >
      <View style={styles.timeContainer}>
        <Ionicons
          name={isAllDay ? "calendar" : "time-outline"}
          size={16}
          color={colors.primary}
        />
        <ThemedText style={[styles.timeText, { color: colors.primary }]}>
          {timeDisplay}
        </ThemedText>
        {isMultiDay && (
          <View
            style={[styles.multiDayBadge, { backgroundColor: colors.primary }]}
          >
            <ThemedText style={styles.multiDayText}>Meerdaags</ThemedText>
          </View>
        )}
      </View>

      <ThemedText
        style={[styles.title, { color: colors.text }]}
        numberOfLines={2}
      >
        {event.summary}
      </ThemedText>

      {event.location && (
        <View style={styles.locationContainer}>
          <Ionicons
            name="location-outline"
            size={14}
            color={colors.textSecondary}
          />
          <ThemedText
            style={[styles.locationText, { color: colors.textSecondary }]}
            numberOfLines={1}
          >
            {event.location}
          </ThemedText>
        </View>
      )}

      <View style={styles.chevronContainer}>
        <Ionicons
          name="chevron-forward"
          size={20}
          color={colors.textSecondary}
        />
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: 16,
    marginHorizontal: 16,
    marginVertical: 6,
    borderRadius: 12,
    borderWidth: Platform.OS === "android" ? StyleSheet.hairlineWidth : 0,
    position: "relative",
  },
  shadowIOS: {
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  shadowAndroid: {
    elevation: 2,
  },
  timeContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 8,
  },
  timeText: {
    fontSize: 13,
    fontWeight: "600",
    marginLeft: 6,
  },
  multiDayBadge: {
    marginLeft: 8,
    paddingHorizontal: 8,
    paddingVertical: 2,
    borderRadius: 10,
  },
  multiDayText: {
    fontSize: 11,
    fontWeight: "600",
    color: "#FFFFFF",
  },
  title: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: 4,
    paddingRight: 24,
  },
  locationContainer: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: 4,
  },
  locationText: {
    fontSize: 13,
    marginLeft: 4,
    flex: 1,
  },
  chevronContainer: {
    position: "absolute",
    right: 12,
    top: "50%",
    marginTop: -10,
  },
});
