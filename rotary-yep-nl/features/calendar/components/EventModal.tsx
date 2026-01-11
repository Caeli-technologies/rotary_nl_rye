/**
 * Event detail modal component
 */

import {
  StyleSheet,
  View,
  Modal,
  Pressable,
  ScrollView,
  Platform,
  Linking,
} from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { useTheme } from "@/core/theme";
import {
  formatEventDate,
  formatEventTime,
  isMultiDayEvent,
  extractLinksFromDescription,
} from "../utils";
import type { CalendarEvent, EventWithOriginalData } from "../types";

interface EventModalProps {
  event: CalendarEvent | null;
  visible: boolean;
  onClose: () => void;
}

export function EventModal({ event, visible, onClose }: EventModalProps) {
  const { colors } = useTheme();

  if (!event) return null;

  const eventWithOriginal = event as EventWithOriginalData;
  const isAllDay =
    eventWithOriginal._originalStart?.date !== undefined &&
    !eventWithOriginal._originalStart?.dateTime;
  const isMultiDay = isMultiDayEvent(event);

  const startDate = formatEventDate(event.start.dateTime);
  const endDate = formatEventDate(event.end.dateTime);
  const timeDisplay = isAllDay
    ? "Hele dag"
    : formatEventTime(event.start.dateTime, event.end.dateTime);

  const links = event.description
    ? extractLinksFromDescription(event.description)
    : [];

  const handleOpenLocation = () => {
    if (event.location) {
      const url = `https://maps.apple.com/?q=${encodeURIComponent(event.location)}`;
      Linking.openURL(url);
    }
  };

  const handleOpenLink = (url: string) => {
    Linking.openURL(url);
  };

  const handleOpenCalendarLink = () => {
    if (event.htmlLink) {
      Linking.openURL(event.htmlLink);
    }
  };

  return (
    <Modal
      visible={visible}
      animationType="slide"
      presentationStyle="pageSheet"
      onRequestClose={onClose}
    >
      <View style={[styles.container, { backgroundColor: colors.background }]}>
        {/* Header */}
        <View style={[styles.header, { borderBottomColor: colors.border }]}>
          <ThemedText style={[styles.headerTitle, { color: colors.text }]}>
            Evenement
          </ThemedText>
          <Pressable
            onPress={onClose}
            style={({ pressed }) => [
              styles.closeButton,
              { backgroundColor: colors.card, opacity: pressed ? 0.7 : 1 },
            ]}
          >
            <Ionicons name="close" size={20} color={colors.text} />
          </Pressable>
        </View>

        <ScrollView
          style={styles.content}
          contentContainerStyle={styles.contentContainer}
          showsVerticalScrollIndicator={false}
        >
          {/* Title */}
          <ThemedText style={[styles.title, { color: colors.text }]}>
            {event.summary}
          </ThemedText>

          {/* Date & Time */}
          <View style={styles.infoRow}>
            <View
              style={[
                styles.iconContainer,
                { backgroundColor: colors.primary },
              ]}
            >
              <Ionicons name="calendar" size={18} color="#FFFFFF" />
            </View>
            <View style={styles.infoContent}>
              {isMultiDay ? (
                <>
                  <ThemedText style={[styles.infoText, { color: colors.text }]}>
                    {startDate} - {endDate}
                  </ThemedText>
                  <ThemedText
                    style={[
                      styles.infoSubtext,
                      { color: colors.textSecondary },
                    ]}
                  >
                    Meerdaags evenement
                  </ThemedText>
                </>
              ) : (
                <>
                  <ThemedText style={[styles.infoText, { color: colors.text }]}>
                    {startDate}
                  </ThemedText>
                  <ThemedText
                    style={[
                      styles.infoSubtext,
                      { color: colors.textSecondary },
                    ]}
                  >
                    {timeDisplay}
                  </ThemedText>
                </>
              )}
            </View>
          </View>

          {/* Location */}
          {event.location && (
            <Pressable
              onPress={handleOpenLocation}
              style={({ pressed }) => [
                styles.infoRow,
                { opacity: pressed ? 0.7 : 1 },
              ]}
            >
              <View
                style={[
                  styles.iconContainer,
                  { backgroundColor: colors.accent },
                ]}
              >
                <Ionicons name="location" size={18} color="#FFFFFF" />
              </View>
              <View style={styles.infoContent}>
                <ThemedText style={[styles.infoText, { color: colors.text }]}>
                  {event.location}
                </ThemedText>
                <ThemedText
                  style={[styles.infoSubtext, { color: colors.primary }]}
                >
                  Open in Kaarten
                </ThemedText>
              </View>
              <Ionicons
                name="chevron-forward"
                size={20}
                color={colors.textSecondary}
              />
            </Pressable>
          )}

          {/* Description */}
          {event.description && (
            <View style={styles.descriptionContainer}>
              <ThemedText style={[styles.sectionTitle, { color: colors.text }]}>
                Beschrijving
              </ThemedText>
              <ThemedText
                style={[styles.description, { color: colors.textSecondary }]}
              >
                {event.description.replace(/<[^>]*>/g, "")}
              </ThemedText>
            </View>
          )}

          {/* Links */}
          {links.length > 0 && (
            <View style={styles.linksContainer}>
              <ThemedText style={[styles.sectionTitle, { color: colors.text }]}>
                Links
              </ThemedText>
              {links.map((link, index) => (
                <Pressable
                  key={index}
                  onPress={() => handleOpenLink(link)}
                  style={({ pressed }) => [
                    styles.linkRow,
                    {
                      backgroundColor: colors.card,
                      opacity: pressed ? 0.7 : 1,
                    },
                  ]}
                >
                  <Ionicons name="link" size={18} color={colors.primary} />
                  <ThemedText
                    style={[styles.linkText, { color: colors.primary }]}
                    numberOfLines={1}
                  >
                    {link}
                  </ThemedText>
                  <Ionicons
                    name="open-outline"
                    size={16}
                    color={colors.textSecondary}
                  />
                </Pressable>
              ))}
            </View>
          )}

          {/* View in Calendar */}
          {event.htmlLink && (
            <Pressable
              onPress={handleOpenCalendarLink}
              style={({ pressed }) => [
                styles.calendarButton,
                { backgroundColor: colors.primary, opacity: pressed ? 0.8 : 1 },
              ]}
            >
              <Ionicons name="open-outline" size={18} color="#FFFFFF" />
              <ThemedText style={styles.calendarButtonText}>
                Bekijk in Google Calendar
              </ThemedText>
            </Pressable>
          )}
        </ScrollView>
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: 16,
    paddingHorizontal: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  headerTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  closeButton: {
    position: "absolute",
    right: 16,
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: "center",
    justifyContent: "center",
  },
  content: {
    flex: 1,
  },
  contentContainer: {
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: "700",
    marginBottom: 24,
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: 16,
  },
  iconContainer: {
    width: 36,
    height: 36,
    borderRadius: 10,
    alignItems: "center",
    justifyContent: "center",
  },
  infoContent: {
    flex: 1,
    marginLeft: 12,
  },
  infoText: {
    fontSize: 16,
    fontWeight: "500",
  },
  infoSubtext: {
    fontSize: 14,
    marginTop: 2,
  },
  descriptionContainer: {
    marginTop: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 12,
  },
  description: {
    fontSize: 15,
    lineHeight: 22,
  },
  linksContainer: {
    marginTop: 24,
  },
  linkRow: {
    flexDirection: "row",
    alignItems: "center",
    padding: 12,
    borderRadius: 10,
    marginBottom: 8,
  },
  linkText: {
    flex: 1,
    fontSize: 14,
    marginLeft: 8,
    marginRight: 8,
  },
  calendarButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: 16,
    borderRadius: 12,
    marginTop: 32,
  },
  calendarButtonText: {
    fontSize: 16,
    fontWeight: "600",
    color: "#FFFFFF",
    marginLeft: 8,
  },
});
