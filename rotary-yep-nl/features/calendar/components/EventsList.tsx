/**
 * Events list component for displaying events on a selected date
 */

import { StyleSheet, View, FlatList, Text } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { useTheme } from "@/core/theme";
import { EventCard } from "./EventCard";
import { getEventsForDay, formatEventDate } from "../utils";
import type { CalendarEvent, EventsData } from "../types";

interface EventsListProps {
  eventsData: EventsData;
  selectedDate: string;
  onEventPress: (event: CalendarEvent) => void;
  ListHeaderComponent?: React.ReactElement;
}

export function EventsList({
  eventsData,
  selectedDate,
  onEventPress,
  ListHeaderComponent,
}: EventsListProps) {
  const { colors } = useTheme();
  const events = getEventsForDay(eventsData, selectedDate);
  const formattedDate = formatEventDate(new Date(selectedDate));

  const renderItem = ({ item }: { item: CalendarEvent }) => (
    <EventCard event={item} onPress={onEventPress} />
  );

  const renderEmptyState = () => (
    <View style={styles.emptyContainer}>
      <Ionicons
        name="calendar-outline"
        size={48}
        color={colors.textSecondary}
      />
      <Text style={[styles.emptyTitle, { color: colors.text }]}>
        Geen evenementen
      </Text>
      <Text
        style={[styles.emptySubtitle, { color: colors.textSecondary }]}
      >
        Er zijn geen evenementen gepland voor {formattedDate}
      </Text>
    </View>
  );

  const renderHeader = () => (
    <View style={styles.headerContainer}>
      {ListHeaderComponent}
      <View style={styles.dateHeader}>
        <Text style={[styles.dateText, { color: colors.text }]}>
          {formattedDate}
        </Text>
        <Text style={[styles.countText, { color: colors.textSecondary }]}>
          {events.length} {events.length === 1 ? "evenement" : "evenementen"}
        </Text>
      </View>
    </View>
  );

  return (
    <FlatList
      data={events}
      keyExtractor={(item) => item.id}
      renderItem={renderItem}
      ListHeaderComponent={renderHeader}
      ListEmptyComponent={renderEmptyState}
      contentContainerStyle={styles.listContent}
      showsVerticalScrollIndicator={false}
    />
  );
}

const styles = StyleSheet.create({
  listContent: {
    flexGrow: 1,
    paddingBottom: 24,
  },
  headerContainer: {
    marginBottom: 8,
  },
  dateHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  dateText: {
    fontSize: 18,
    fontWeight: "600",
  },
  countText: {
    fontSize: 14,
  },
  emptyContainer: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 32,
    paddingTop: 48,
  },
  emptyTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginTop: 16,
    marginBottom: 8,
  },
  emptySubtitle: {
    fontSize: 14,
    textAlign: "center",
  },
});
