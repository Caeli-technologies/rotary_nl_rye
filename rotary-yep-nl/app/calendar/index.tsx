import React, { useState, useEffect, useCallback } from 'react';
import {
  View,
  Text,
  Pressable,
  ScrollView,
  ActivityIndicator,
  StyleSheet,
  Platform,
  Linking,
  Alert,
  Modal,
} from 'react-native';
import * as Haptics from 'expo-haptics';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Calendar } from 'react-native-calendars';
import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useTheme } from '@/hooks/use-theme';
import {
  fetchCalendarEvents,
  formatDateKey,
  getEventsForDay,
  formatEventDate,
  formatEventTime,
  isMultiDayEvent,
  extractLinksFromDescription,
  getDisplayEndDate,
} from '@/utils/eventUtils';
import { Event, EventsData } from '@/types/events';

export default function CalendarScreen() {
  const { colors: themeColors } = useTheme();
  const [eventsData, setEventsData] = useState<EventsData>({});
  const [selectedDate, setSelectedDate] = useState<string>(formatDateKey(new Date()));
  const [loading, setLoading] = useState(true);
  const [selectedEvent, setSelectedEvent] = useState<Event | null>(null);
  const [modalVisible, setModalVisible] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Helper function to create marked dates
  const createMarkedDates = (events: EventsData, selected: string) => {
    const marked: { [key: string]: any } = {};
    Object.keys(events).forEach((dateKey) => {
      if (events[dateKey] && events[dateKey].length > 0) {
        marked[dateKey] = {
          marked: true,
          dotColor: themeColors.secondary,
        };
      }
    });
    marked[selected] = {
      ...marked[selected],
      selected: true,
      selectedColor: themeColors.primary,
      selectedTextColor: themeColors.onPrimary,
    };
    return marked;
  };

  const loadEvents = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const data = await fetchCalendarEvents();
      setEventsData(data);
    } catch (err) {
      console.error('Calendar events loading error:', err);
      setError('Failed to load events. Please check your internet connection and try again.');
    } finally {
      setLoading(false);
    }
  }, []);

  // Computed values - no need for separate state
  const selectedEvents = getEventsForDay(eventsData, new Date(selectedDate + 'T00:00:00'));
  const markedDates = createMarkedDates(eventsData, selectedDate);

  useEffect(() => {
    loadEvents();
  }, [loadEvents]);

  const onDayPress = useCallback((day: any) => {
    setSelectedDate(day.dateString);
  }, []);

  const openEventDetails = useCallback(async (event: Event) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Medium);
      }
      setSelectedEvent(event);
      setModalVisible(true);
    } catch (error) {
      console.error('Error opening event details:', error);
    }
  }, []);

  const closeEventDetails = useCallback(async () => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }
      setModalVisible(false);
      setSelectedEvent(null);
    } catch (error) {
      console.error('Error closing event details:', error);
      // Still close even if haptics fail
      setModalVisible(false);
      setSelectedEvent(null);
    }
  }, []);

  const openLocation = useCallback(async (location: string) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }

      const encodedLocation = encodeURIComponent(location);
      const url = Platform.select({
        ios: `maps:0,0?q=${encodedLocation}`,
        android: `geo:0,0?q=${encodedLocation}`,
      });

      if (url) {
        const canOpen = await Linking.canOpenURL(url);
        if (canOpen) {
          await Linking.openURL(url);
        } else {
          Alert.alert('Error', 'Maps application is not available on this device');
        }
      }
    } catch (error) {
      console.error('Error opening location:', error);
      Alert.alert('Error', 'Unable to open maps application');
    }
  }, []);

  const openLink = useCallback(async (url: string) => {
    try {
      if (Platform.OS === 'ios') {
        await Haptics.impactAsync(Haptics.ImpactFeedbackStyle.Light);
      }

      const canOpen = await Linking.canOpenURL(url);
      if (canOpen) {
        await Linking.openURL(url);
      } else {
        Alert.alert('Error', 'Unable to open this link type');
      }
    } catch (error) {
      console.error('Error opening link:', error);
      Alert.alert('Error', 'Unable to open link');
    }
  }, []);

  const renderEvent = (event: Event) => {
    const isMultiDay = isMultiDayEvent(event);
    const startDate = formatEventDate(event.start.dateTime);
    const startTime = formatEventTime(event.start.dateTime);
    const endTime = formatEventTime(event.end.dateTime);
    const endDate = isMultiDay ? formatEventDate(getDisplayEndDate(event)) : '';

    return (
      <Pressable
        key={event.id}
        style={({ pressed }) => [
          styles.eventCard,
          {
            backgroundColor: themeColors.card,
            borderColor: themeColors.border,
            shadowColor: themeColors.shadow,
            ...shadowStyle,
          },
          pressed && styles.eventCardPressed,
        ]}
        onPress={() => openEventDetails(event)}
        accessibilityRole="button"
        accessibilityLabel={`Event: ${event.summary}`}
        accessibilityHint="Tap to view event details">
        <View style={styles.eventHeader}>
          <View style={styles.eventIconContainer}>
            <Image
              source={require('@/assets/logo/rotary-logo-icon.svg')}
              style={styles.eventIcon}
              contentFit="contain"
              tintColor={themeColors.secondary}
            />
          </View>
          <View style={styles.eventContent}>
            <Text style={[styles.eventTitle, { color: themeColors.text }]} numberOfLines={2}>
              {event.summary.trim() || 'Untitled Event'}
            </Text>
            <View style={styles.eventDateContainer}>
              <Ionicons name="calendar-outline" size={14} color={themeColors.primary} />
              <Text style={[styles.eventDateText, { color: themeColors.textSecondary }]}>
                {isMultiDay ? `${startDate} - ${endDate}` : startDate}
              </Text>
            </View>
            {!isMultiDay && startTime !== endTime && (
              <View style={styles.eventTimeContainer}>
                <Ionicons name="time-outline" size={14} color={themeColors.accent} />
                <Text style={[styles.eventTimeText, { color: themeColors.textSecondary }]}>
                  {startTime} - {endTime}
                </Text>
              </View>
            )}
            <View style={styles.eventLocationContainer}>
              <Ionicons name="location-outline" size={14} color={themeColors.accent} />
              <Text
                style={[styles.eventLocationText, { color: themeColors.textSecondary }]}
                numberOfLines={1}>
                {event.location}
              </Text>
            </View>
          </View>
          <View style={styles.eventActionButton}>
            <Ionicons name="chevron-forward" size={16} color={themeColors.textTertiary} />
          </View>
        </View>
      </Pressable>
    );
  };

  const renderEventModal = () => {
    if (!selectedEvent) return null;

    const links = selectedEvent.description
      ? extractLinksFromDescription(selectedEvent.description)
      : [];
    const startDate = formatEventDate(selectedEvent.start.dateTime);
    const startTime = formatEventTime(selectedEvent.start.dateTime);
    const endTime = formatEventTime(selectedEvent.end.dateTime);
    const isMultiDay = isMultiDayEvent(selectedEvent);
    const displayEndDate = getDisplayEndDate(selectedEvent);
    const endDate = formatEventDate(displayEndDate);

    return (
      <Modal
        animationType="slide"
        presentationStyle={Platform.OS === 'ios' ? 'pageSheet' : 'fullScreen'}
        visible={modalVisible}
        onRequestClose={closeEventDetails}>
        <View style={[styles.modalContainer, { backgroundColor: themeColors.background }]}>
          {/* Modal Handle Bar (iOS style) */}
          {Platform.OS === 'ios' && (
            <View style={styles.modalHandle}>
              <View
                style={[styles.modalHandleBar, { backgroundColor: themeColors.textTertiary }]}
              />
            </View>
          )}

          {/* Header with Event Icon */}
          <View style={[styles.modalHeader, { borderBottomColor: themeColors.border }]}>
            <View style={styles.modalTitleContainer}>
              <View style={styles.modalIconContainer}>
                <Image
                  source={require('@/assets/logo/rotary-logo-icon.svg')}
                  style={styles.modalIcon}
                  contentFit="contain"
                  tintColor={themeColors.secondary}
                />
              </View>
              <View style={styles.modalTitleContent}>
                <Text style={[styles.modalTitle, { color: themeColors.text }]}>
                  {selectedEvent.summary.trim() || 'Event Details'}
                </Text>
                <Text style={[styles.modalSubtitle, { color: themeColors.textSecondary }]}>
                  {selectedEvent.status === 'confirmed' ? 'Confirmed Event' : selectedEvent.status}
                </Text>
              </View>
            </View>
            <Pressable
              style={({ pressed }) => [styles.closeButton, pressed && styles.closeButtonPressed]}
              onPress={closeEventDetails}
              accessibilityRole="button"
              accessibilityLabel="Close event details"
              hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
              <Ionicons name="close" size={24} color={themeColors.text} />
            </Pressable>
          </View>

          <ScrollView style={styles.modalBody} showsVerticalScrollIndicator={false}>
            {/* Date & Time Section */}
            <View
              style={[
                styles.modalCard,
                {
                  backgroundColor: themeColors.backgroundElevated,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={[styles.modalCardHeader, { borderBottomColor: themeColors.border }]}>
                <Ionicons name="calendar-outline" size={20} color={themeColors.link} />
                <Text style={[styles.modalCardTitle, { color: themeColors.text }]}>
                  Date & Time
                </Text>
              </View>
              <View style={styles.modalCardContent}>
                <Text style={[styles.modalDateText, { color: themeColors.text }]}>
                  {isMultiDay ? `${startDate} - ${endDate}` : startDate}
                </Text>
                {!isMultiDay && startTime !== endTime && (
                  <Text style={[styles.modalTimeText, { color: themeColors.textSecondary }]}>
                    {startTime} - {endTime}
                  </Text>
                )}
                <View style={styles.modalDateDetails}>
                  <Text style={[styles.modalDetailText, { color: themeColors.textTertiary }]}>
                    Created: {selectedEvent.created.toLocaleDateString()}
                  </Text>
                  <Text style={[styles.modalDetailText, { color: themeColors.textTertiary }]}>
                    Updated: {selectedEvent.updated.toLocaleDateString()}
                  </Text>
                </View>
              </View>
            </View>

            {/* Location Section */}
            <View
              style={[
                styles.modalCard,
                {
                  backgroundColor: themeColors.backgroundElevated,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={[styles.modalCardHeader, { borderBottomColor: themeColors.border }]}>
                <Ionicons name="location-outline" size={20} color={themeColors.primary} />
                <Text style={[styles.modalCardTitle, { color: themeColors.text }]}>Location</Text>
              </View>
              {selectedEvent.location !== 'Location not specified' ? (
                <Pressable
                  style={({ pressed }) => [
                    styles.modalCardContent,
                    pressed && styles.modalCardContentPressed,
                  ]}
                  onPress={() => openLocation(selectedEvent.location)}>
                  <Text
                    style={[
                      styles.modalLocationText,
                      styles.linkText,
                      { color: themeColors.primary },
                    ]}>
                    {selectedEvent.location}
                  </Text>
                  <View style={styles.modalLocationAction}>
                    <Ionicons name="map" size={16} color={themeColors.primary} />
                    <Text style={[styles.modalActionText, { color: themeColors.primary }]}>
                      Open in Maps
                    </Text>
                  </View>
                </Pressable>
              ) : (
                <View style={styles.modalCardContent}>
                  <Text style={[styles.modalLocationText, { color: themeColors.textSecondary }]}>
                    {selectedEvent.location}
                  </Text>
                </View>
              )}
            </View>

            {/* Description Section */}
            <View
              style={[
                styles.modalCard,
                {
                  backgroundColor: themeColors.backgroundElevated,
                  borderColor: themeColors.border,
                },
              ]}>
              <View style={styles.modalCardHeader}>
                <Ionicons name="document-text-outline" size={20} color={themeColors.primary} />
                <Text style={[styles.modalCardTitle, { color: themeColors.text }]}>
                  Description
                </Text>
              </View>
              <View style={styles.modalCardContent}>
                <Text style={[styles.modalDescriptionText, { color: themeColors.textSecondary }]}>
                  {selectedEvent.description.trim() || 'No description available for this event.'}
                </Text>
              </View>
            </View>

            {/* Organizer Section */}
            {selectedEvent.organizer?.email && (
              <View
                style={[
                  styles.modalCard,
                  {
                    backgroundColor: themeColors.backgroundElevated,
                    borderColor: themeColors.border,
                  },
                ]}>
                <View style={[styles.modalCardHeader, { borderBottomColor: themeColors.border }]}>
                  <Ionicons name="person-outline" size={20} color={themeColors.primary} />
                  <Text style={[styles.modalCardTitle, { color: themeColors.text }]}>
                    Organizer
                  </Text>
                </View>
                <View style={styles.modalCardContent}>
                  <Text style={[styles.modalOrganizerText, { color: themeColors.textSecondary }]}>
                    {selectedEvent.organizer.email}
                  </Text>
                </View>
              </View>
            )}

            {/* Links Section */}
            {links.length > 0 && (
              <View
                style={[
                  styles.modalCard,
                  {
                    backgroundColor: themeColors.backgroundElevated,
                    borderColor: themeColors.border,
                  },
                ]}>
                <View style={[styles.modalCardHeader, { borderBottomColor: themeColors.border }]}>
                  <Ionicons name="link-outline" size={20} color={themeColors.primary} />
                  <Text style={[styles.modalCardTitle, { color: themeColors.text }]}>Links</Text>
                </View>
                <View style={styles.modalCardContent}>
                  {links.map((link, index) => (
                    <Pressable
                      key={index}
                      style={({ pressed }) => [
                        styles.modalLinkItem,
                        pressed && styles.modalLinkItemPressed,
                      ]}
                      onPress={() => openLink(link)}>
                      <Ionicons name="open-outline" size={16} color={themeColors.primary} />
                      <Text
                        style={[
                          styles.modalLinkText,
                          styles.linkText,
                          { color: themeColors.primary },
                        ]}
                        numberOfLines={1}>
                        {link}
                      </Text>
                      <Ionicons name="chevron-forward" size={16} color={themeColors.textTertiary} />
                    </Pressable>
                  ))}
                </View>
              </View>
            )}
          </ScrollView>

          {/* Action Buttons */}
          {selectedEvent.location !== 'Location not specified' && (
            <View
              style={[
                styles.modalActions,
                {
                  backgroundColor: themeColors.backgroundElevated,
                  borderTopColor: themeColors.border,
                },
              ]}>
              <Pressable
                style={({ pressed }) => [
                  styles.modalActionButton,
                  { backgroundColor: themeColors.primary },
                  pressed && styles.modalActionButtonPressed,
                ]}
                onPress={() => openLocation(selectedEvent.location)}
                accessibilityRole="button"
                accessibilityLabel={`Get directions to ${selectedEvent.location}`}>
                <Ionicons name="map-outline" size={18} color={themeColors.onPrimary} />
                <Text style={[styles.modalActionButtonText, { color: themeColors.onPrimary }]}>
                  Directions
                </Text>
              </Pressable>
            </View>
          )}
        </View>
      </Modal>
    );
  };

  return (
    <SafeAreaView
      style={[styles.safeArea, { backgroundColor: themeColors.background }]}
      edges={['bottom']}>
      <View style={[styles.container, { backgroundColor: themeColors.background }]}>
        {loading ? (
          <View style={styles.centerContainer}>
            <ActivityIndicator size="large" color={themeColors.link} />
            <Text style={[styles.loadingText, { color: themeColors.textSecondary }]}>
              Loading calendar events...
            </Text>
          </View>
        ) : error ? (
          <View style={styles.centerContainer}>
            <View style={[styles.errorIcon, { backgroundColor: themeColors.error + '20' }]}>
              <Ionicons name="warning-outline" size={64} color={themeColors.error} />
            </View>
            <Text style={[styles.errorTitle, { color: themeColors.text }]}>
              Oops! Something went wrong
            </Text>
            <Text style={[styles.errorText, { color: themeColors.textSecondary }]}>{error}</Text>
            <Pressable
              style={({ pressed }) => [
                styles.retryButton,
                { backgroundColor: themeColors.primary },
                pressed && styles.retryButtonPressed,
              ]}
              onPress={loadEvents}
              accessibilityRole="button"
              accessibilityLabel="Retry loading events">
              <Text style={[styles.retryButtonText, { color: themeColors.onPrimary }]}>
                Try Again
              </Text>
            </Pressable>
          </View>
        ) : (
          <>
            {/* Fixed Calendar */}
            <View
              style={[
                styles.calendarContainer,
                {
                  backgroundColor: themeColors.card,
                  borderBottomColor: themeColors.border,
                },
              ]}>
              <Calendar
                key={`calendar-${themeColors.background}`}
                onDayPress={onDayPress}
                markedDates={markedDates}
                theme={{
                  backgroundColor: themeColors.card,
                  calendarBackground: themeColors.card,
                  dayTextColor: themeColors.text,
                  monthTextColor: themeColors.text,
                  textSectionTitleColor: themeColors.text,
                  textDisabledColor: themeColors.textTertiary,
                  selectedDayBackgroundColor: themeColors.primary,
                  selectedDayTextColor: themeColors.onPrimary,
                  todayTextColor: themeColors.primary,
                  dotColor: themeColors.secondary,
                  selectedDotColor: themeColors.onPrimary,
                  arrowColor: themeColors.primary,
                }}
                firstDay={1}
                style={styles.calendar}
              />
            </View>

            {/* Scrollable Events Section */}
            <ScrollView
              style={styles.eventsScrollView}
              contentContainerStyle={styles.eventsScrollContent}
              showsVerticalScrollIndicator={false}>
              <View style={styles.eventsSection}>
                <View style={styles.sectionHeader}>
                  <Text style={[styles.sectionTitle, { color: themeColors.text }]}>
                    {new Date(selectedDate + 'T00:00:00').toLocaleDateString('en-US', {
                      weekday: 'long',
                      month: 'long',
                      day: 'numeric',
                    })}
                  </Text>
                  <Pressable
                    style={({ pressed }) => [
                      styles.refreshButton,
                      pressed && [
                        styles.refreshButtonPressed,
                        { backgroundColor: themeColors.backgroundElevated },
                      ],
                    ]}
                    onPress={loadEvents}
                    hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
                    accessibilityRole="button"
                    accessibilityLabel="Refresh events"
                    accessibilityHint="Reload calendar events">
                    <Ionicons name="refresh" size={20} color={themeColors.link} />
                  </Pressable>
                </View>

                {selectedEvents.length > 0 ? (
                  selectedEvents.map((event) => renderEvent(event))
                ) : (
                  <View style={styles.emptyContainer}>
                    <View
                      style={[
                        styles.emptyIcon,
                        { backgroundColor: themeColors.backgroundElevated },
                      ]}>
                      <Ionicons
                        name="calendar-outline"
                        size={64}
                        color={themeColors.textTertiary}
                      />
                    </View>
                    <Text style={[styles.emptyTitle, { color: themeColors.text }]}>No Events</Text>
                    <Text style={[styles.emptyText, { color: themeColors.textSecondary }]}>
                      There are no events scheduled for this day.
                    </Text>
                  </View>
                )}
              </View>
            </ScrollView>
          </>
        )}
      </View>

      {renderEventModal()}
    </SafeAreaView>
  );
}

const shadowStyle = {
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

// Dynamic styles based on theme colors
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
    paddingBottom: 34,
  },
  eventsScrollView: {
    flex: 1,
  },
  eventsScrollContent: {
    paddingBottom: 34,
  },
  calendarContainer: {
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  calendar: {
    borderBottomWidth: 0,
  },
  eventsSection: {
    paddingHorizontal: 16,
  },
  sectionHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
    paddingHorizontal: 4,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: '600',
    flex: 1,
  },
  refreshButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
  },
  refreshButtonPressed: {
    opacity: 0.8,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  eventCard: {
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    marginBottom: 12,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
        }),
    overflow: 'hidden',
  },
  eventCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  eventHeader: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    padding: 16,
  },
  eventIconContainer: {
    marginRight: 12,
    alignSelf: 'flex-start',
  },
  eventIcon: {
    width: 44,
    height: 44,
    borderRadius: 8,
  },
  eventContent: {
    flex: 1,
    marginRight: 8,
  },
  eventTitle: {
    fontSize: 16,
    fontWeight: '600',
    lineHeight: 22,
    marginBottom: 6,
  },
  eventDateContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  eventDateText: {
    fontSize: 14,
    fontWeight: '500',
    marginLeft: 6,
  },
  eventTimeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 4,
  },
  eventTimeText: {
    fontSize: 14,
    fontWeight: '400',
    marginLeft: 6,
  },
  eventLocationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  eventLocationText: {
    fontSize: 14,
    fontWeight: '400',
    marginLeft: 6,
    flex: 1,
  },
  eventActionButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
  },
  eventDescriptionContainer: {
    paddingHorizontal: 16,
    paddingBottom: 16,
    borderTopWidth: StyleSheet.hairlineWidth,
    marginTop: 8,
    paddingTop: 12,
  },
  eventDescription: {
    fontSize: 14,
    fontWeight: '400',
    lineHeight: 20,
  },
  centerContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 32,
  },
  loadingText: {
    fontSize: 16,
    fontWeight: '400',
    marginTop: 16,
    textAlign: 'center',
  },
  errorIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: '#FFEBEE',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  errorTitle: {
    fontSize: 20,
    fontWeight: '600',
    textAlign: 'center',
    marginBottom: 8,
  },
  errorText: {
    fontSize: 16,
    fontWeight: '400',
    textAlign: 'center',
    lineHeight: 22,
    marginBottom: 32,
    paddingHorizontal: 20,
  },
  retryButton: {
    paddingHorizontal: 32,
    paddingVertical: 14,
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    minWidth: 120,
  },
  retryButtonPressed: {
    opacity: 0.8,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  retryButtonText: {
    fontSize: 16,
    fontWeight: '600',
    textAlign: 'center',
  },
  emptyContainer: {
    alignItems: 'center',
    paddingVertical: 60,
    paddingHorizontal: 32,
  },
  emptyIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: '600',
    textAlign: 'center',
    marginBottom: 8,
  },
  emptyText: {
    fontSize: 16,
    fontWeight: '400',
    textAlign: 'center',
    lineHeight: 22,
  },
  modalContainer: {
    flex: 1,
  },
  modalHandle: {
    alignItems: 'center',
    paddingVertical: 12,
  },
  modalHandleBar: {
    width: 36,
    height: 4,
    borderRadius: 2,
    opacity: 0.4,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    flex: 1,
    borderTopLeftRadius: Platform.OS === 'ios' ? 20 : 0,
    borderTopRightRadius: Platform.OS === 'ios' ? 20 : 0,
    overflow: 'hidden',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingTop: Platform.OS === 'ios' ? 8 : 20,
    paddingBottom: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: '600',
    flex: 1,
    marginRight: 16,
  },
  closeButton: {
    padding: 4,
  },
  closeButtonPressed: {
    opacity: 0.6,
    transform: Platform.OS === 'ios' ? [{ scale: 0.95 }] : [],
  },
  modalCardContentPressed: {
    opacity: 0.8,
  },
  modalLinkItemPressed: {
    opacity: 0.8,
  },
  modalActionButtonPressed: {
    opacity: 0.8,
    transform: Platform.OS === 'ios' ? [{ scale: 0.98 }] : [],
  },
  modalBody: {
    padding: 20,
  },
  modalSection: {
    marginBottom: 16,
  },
  modalRow: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  modalText: {
    fontSize: 14,
    marginLeft: 12,
    flex: 1,
  },
  linkText: {
    textDecorationLine: 'underline',
  },
  modalButton: {
    paddingVertical: 16,
    alignItems: 'center',
    margin: 20,
    marginTop: 0,
    borderRadius: 8,
  },
  modalButtonText: {
    fontSize: 16,
    fontWeight: '600',
  },
  modalTitleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  modalIconContainer: {
    marginRight: 12,
  },
  modalIcon: {
    width: 40,
    height: 40,
    borderRadius: 8,
  },
  modalTitleContent: {
    flex: 1,
  },
  modalSubtitle: {
    fontSize: 14,
    fontWeight: '400',
    marginTop: 2,
  },
  modalCard: {
    borderRadius: 12,
    marginBottom: 16,
    overflow: 'hidden',
  },
  modalCardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  modalCardTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  modalCardContent: {
    padding: 16,
  },
  modalDateText: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  modalTimeText: {
    fontSize: 15,
    fontWeight: '500',
    marginBottom: 8,
  },
  modalDateDetails: {
    marginTop: 8,
  },
  modalDetailText: {
    fontSize: 13,
    fontWeight: '400',
    marginBottom: 2,
  },
  modalLocationText: {
    fontSize: 15,
    fontWeight: '500',
    marginBottom: 8,
  },
  modalLocationAction: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  modalActionText: {
    fontSize: 14,
    fontWeight: '500',
    marginRight: 4,
  },
  modalDescriptionText: {
    fontSize: 15,
    fontWeight: '400',
    lineHeight: 22,
  },
  modalOrganizerText: {
    fontSize: 15,
    fontWeight: '500',
  },
  modalLinkItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
    paddingHorizontal: 12,
    borderRadius: 8,
    marginBottom: 8,
  },
  modalLinkText: {
    fontSize: 14,
    fontWeight: '400',
    marginLeft: 8,
    flex: 1,
  },
  modalCalendarAction: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  modalActions: {
    flexDirection: 'row',
    paddingHorizontal: 20,
    paddingVertical: 16,
    borderTopWidth: StyleSheet.hairlineWidth,
    gap: 12,
  },
  modalActionButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: Platform.OS === 'ios' ? 16 : 14,
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    gap: 6,
    minHeight: Platform.OS === 'ios' ? 50 : 48,
  },
  modalActionButtonText: {
    fontSize: 16,
    fontWeight: '600',
  },
});
