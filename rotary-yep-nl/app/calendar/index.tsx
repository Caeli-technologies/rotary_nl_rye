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
      marked[dateKey] = { marked: true, dotColor: '#007AFF' };
    });
    marked[selected] = {
      ...marked[selected],
      selected: true,
      selectedColor: '#007AFF',
    };
    return marked;
  };

  // Computed values - no need for separate state
  const selectedEvents = getEventsForDay(eventsData, new Date(selectedDate + 'T00:00:00'));
  const markedDates = createMarkedDates(eventsData, selectedDate);

  useEffect(() => {
    loadEvents();
  }, []);

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
        style={({ pressed }) => [styles.eventCard, pressed && styles.eventCardPressed]}
        onPress={() => openEventDetails(event)}
        accessibilityRole="button"
        accessibilityLabel={`Event: ${event.summary}`}
        accessibilityHint="Tap to view event details">
        <View style={styles.eventHeader}>
          <View style={styles.eventIconContainer}>
            <Image
              source={{
                uri: 'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
              }}
              style={styles.eventIcon}
              contentFit="cover"
            />
          </View>
          <View style={styles.eventContent}>
            <Text style={styles.eventTitle} numberOfLines={2}>
              {event.summary.trim() || 'Untitled Event'}
            </Text>
            <View style={styles.eventDateContainer}>
              <Ionicons name="calendar-outline" size={14} color="#007AFF" />
              <Text style={styles.eventDateText}>
                {isMultiDay ? `${startDate} - ${endDate}` : startDate}
              </Text>
            </View>
            {!isMultiDay && startTime !== endTime && (
              <View style={styles.eventTimeContainer}>
                <Ionicons name="time-outline" size={14} color="#8E8E93" />
                <Text style={styles.eventTimeText}>
                  {startTime} - {endTime}
                </Text>
              </View>
            )}
            <View style={styles.eventLocationContainer}>
              <Ionicons name="location-outline" size={14} color="#8E8E93" />
              <Text style={styles.eventLocationText} numberOfLines={1}>
                {event.location}
              </Text>
            </View>
          </View>
          <View style={styles.eventActionButton}>
            <Ionicons name="chevron-forward" size={16} color="#C7C7CC" />
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
        transparent={true}
        visible={modalVisible}
        onRequestClose={closeEventDetails}>
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            {/* Header with Event Icon */}
            <View style={styles.modalHeader}>
              <View style={styles.modalTitleContainer}>
                <View style={styles.modalIconContainer}>
                  <Image
                    source={{
                      uri: 'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
                    }}
                    style={styles.modalIcon}
                    contentFit="cover"
                  />
                </View>
                <View style={styles.modalTitleContent}>
                  <Text style={styles.modalTitle}>
                    {selectedEvent.summary.trim() || 'Event Details'}
                  </Text>
                  <Text style={styles.modalSubtitle}>
                    {selectedEvent.status === 'confirmed'
                      ? 'Confirmed Event'
                      : selectedEvent.status}
                  </Text>
                </View>
              </View>
              <Pressable
                style={({ pressed }) => [styles.closeButton, pressed && styles.closeButtonPressed]}
                onPress={closeEventDetails}
                accessibilityRole="button"
                accessibilityLabel="Close event details"
                hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
                <Ionicons name="close" size={24} color="#000000" />
              </Pressable>
            </View>

            <ScrollView style={styles.modalBody} showsVerticalScrollIndicator={false}>
              {/* Date & Time Section */}
              <View style={styles.modalCard}>
                <View style={styles.modalCardHeader}>
                  <Ionicons name="calendar-outline" size={20} color="#007AFF" />
                  <Text style={styles.modalCardTitle}>Date & Time</Text>
                </View>
                <View style={styles.modalCardContent}>
                  <Text style={styles.modalDateText}>
                    {isMultiDay ? `${startDate} - ${endDate}` : startDate}
                  </Text>
                  {!isMultiDay && startTime !== endTime && (
                    <Text style={styles.modalTimeText}>
                      {startTime} - {endTime}
                    </Text>
                  )}
                  <View style={styles.modalDateDetails}>
                    <Text style={styles.modalDetailText}>
                      Created: {selectedEvent.created.toLocaleDateString()}
                    </Text>
                    <Text style={styles.modalDetailText}>
                      Updated: {selectedEvent.updated.toLocaleDateString()}
                    </Text>
                  </View>
                </View>
              </View>

              {/* Location Section */}
              <View style={styles.modalCard}>
                <View style={styles.modalCardHeader}>
                  <Ionicons name="location-outline" size={20} color="#007AFF" />
                  <Text style={styles.modalCardTitle}>Location</Text>
                </View>
                {selectedEvent.location !== 'Location not specified' ? (
                  <Pressable
                    style={({ pressed }) => [
                      styles.modalCardContent,
                      pressed && styles.modalCardContentPressed,
                    ]}
                    onPress={() => openLocation(selectedEvent.location)}>
                    <Text style={[styles.modalLocationText, styles.linkText]}>
                      {selectedEvent.location}
                    </Text>
                    <View style={styles.modalLocationAction}>
                      <Ionicons name="map" size={16} color="#007AFF" />
                      <Text style={styles.modalActionText}>Open in Maps</Text>
                    </View>
                  </Pressable>
                ) : (
                  <View style={styles.modalCardContent}>
                    <Text style={styles.modalLocationText}>{selectedEvent.location}</Text>
                  </View>
                )}
              </View>

              {/* Description Section */}
              <View style={styles.modalCard}>
                <View style={styles.modalCardHeader}>
                  <Ionicons name="document-text-outline" size={20} color="#007AFF" />
                  <Text style={styles.modalCardTitle}>Description</Text>
                </View>
                <View style={styles.modalCardContent}>
                  <Text style={styles.modalDescriptionText}>
                    {selectedEvent.description.trim() || 'No description available for this event.'}
                  </Text>
                </View>
              </View>

              {/* Organizer Section */}
              {selectedEvent.organizer?.email && (
                <View style={styles.modalCard}>
                  <View style={styles.modalCardHeader}>
                    <Ionicons name="person-outline" size={20} color="#007AFF" />
                    <Text style={styles.modalCardTitle}>Organizer</Text>
                  </View>
                  <View style={styles.modalCardContent}>
                    <Text style={styles.modalOrganizerText}>{selectedEvent.organizer.email}</Text>
                  </View>
                </View>
              )}

              {/* Links Section */}
              {links.length > 0 && (
                <View style={styles.modalCard}>
                  <View style={styles.modalCardHeader}>
                    <Ionicons name="link-outline" size={20} color="#007AFF" />
                    <Text style={styles.modalCardTitle}>Links</Text>
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
                        <Ionicons name="open-outline" size={16} color="#007AFF" />
                        <Text style={[styles.modalLinkText, styles.linkText]} numberOfLines={1}>
                          {link}
                        </Text>
                        <Ionicons name="chevron-forward" size={16} color="#C7C7CC" />
                      </Pressable>
                    ))}
                  </View>
                </View>
              )}
            </ScrollView>

            {/* Action Buttons */}
            <View style={styles.modalActions}>
              {selectedEvent.location !== 'Location not specified' && (
                <Pressable
                  style={({ pressed }) => [
                    styles.modalActionButton,
                    styles.modalSecondaryButton,
                    pressed && styles.modalSecondaryButtonPressed,
                  ]}
                  onPress={() => openLocation(selectedEvent.location)}
                  accessibilityRole="button"
                  accessibilityLabel={`Get directions to ${selectedEvent.location}`}>
                  <Ionicons name="map-outline" size={18} color="#007AFF" />
                  <Text style={styles.modalSecondaryButtonText}>Directions</Text>
                </Pressable>
              )}
              <Pressable
                style={({ pressed }) => [
                  styles.modalActionButton,
                  styles.modalPrimaryButton,
                  pressed && styles.modalPrimaryButtonPressed,
                ]}
                onPress={closeEventDetails}
                accessibilityRole="button"
                accessibilityLabel="Close event details">
                <Text style={styles.modalPrimaryButtonText}>Done</Text>
              </Pressable>
            </View>
          </View>
        </View>
      </Modal>
    );
  };

  return (
    <SafeAreaView style={styles.safeArea} edges={['bottom']}>
      <View style={styles.container}>
        {loading ? (
          <View style={styles.centerContainer}>
            <ActivityIndicator size="large" color="#007AFF" />
            <Text style={styles.loadingText}>Loading calendar events...</Text>
          </View>
        ) : error ? (
          <View style={styles.centerContainer}>
            <View style={styles.errorIcon}>
              <Ionicons name="warning-outline" size={64} color="#FF3B30" />
            </View>
            <Text style={styles.errorTitle}>Oops! Something went wrong</Text>
            <Text style={styles.errorText}>{error}</Text>
            <Pressable
              style={({ pressed }) => [styles.retryButton, pressed && styles.retryButtonPressed]}
              onPress={loadEvents}
              accessibilityRole="button"
              accessibilityLabel="Retry loading events">
              <Text style={styles.retryButtonText}>Try Again</Text>
            </Pressable>
          </View>
        ) : (
          <ScrollView
            style={styles.scrollView}
            contentContainerStyle={styles.scrollContent}
            showsVerticalScrollIndicator={false}
            contentInsetAdjustmentBehavior="automatic">
            {/* Calendar */}
            <View style={styles.calendarContainer}>
              <Calendar
                onDayPress={onDayPress}
                markedDates={markedDates}
                theme={{
                  backgroundColor: '#FFFFFF',
                  calendarBackground: '#FFFFFF',
                  textSectionTitleColor: '#000000',
                  selectedDayBackgroundColor: '#007AFF',
                  selectedDayTextColor: '#FFFFFF',
                  todayTextColor: '#007AFF',
                  dayTextColor: '#000000',
                  textDisabledColor: '#C7C7CC',
                  dotColor: '#007AFF',
                  selectedDotColor: '#FFFFFF',
                  arrowColor: '#007AFF',
                  disabledArrowColor: '#C7C7CC',
                  monthTextColor: '#000000',
                  indicatorColor: '#007AFF',
                  textDayFontFamily: 'System',
                  textMonthFontFamily: 'System',
                  textDayHeaderFontFamily: 'System',
                  textDayFontWeight: '400',
                  textMonthFontWeight: '600',
                  textDayHeaderFontWeight: '400',
                  textDayFontSize: 16,
                  textMonthFontSize: 17,
                  textDayHeaderFontSize: 13,
                }}
                firstDay={1}
                style={styles.calendar}
              />
            </View>

            {/* Events Section */}
            <View style={styles.eventsSection}>
              <View style={styles.sectionHeader}>
                <Text style={styles.sectionTitle}>
                  {new Date(selectedDate + 'T00:00:00').toLocaleDateString('en-US', {
                    weekday: 'long',
                    month: 'long',
                    day: 'numeric',
                  })}
                </Text>
                <Pressable
                  style={({ pressed }) => [
                    styles.refreshButton,
                    pressed && styles.refreshButtonPressed,
                  ]}
                  onPress={loadEvents}
                  hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
                  accessibilityRole="button"
                  accessibilityLabel="Refresh events"
                  accessibilityHint="Reload calendar events">
                  <Ionicons name="refresh" size={20} color="#007AFF" />
                </Pressable>
              </View>

              {selectedEvents.length > 0 ? (
                selectedEvents.map((event) => renderEvent(event))
              ) : (
                <View style={styles.emptyContainer}>
                  <View style={styles.emptyIcon}>
                    <Ionicons name="calendar-outline" size={64} color="#C7C7CC" />
                  </View>
                  <Text style={styles.emptyTitle}>No Events</Text>
                  <Text style={styles.emptyText}>There are no events scheduled for this day.</Text>
                </View>
              )}
            </View>
          </ScrollView>
        )}
      </View>

      {renderEventModal()}
    </SafeAreaView>
  );
}

const shadowStyle = {
  shadowColor: '#000',
  shadowOffset: { width: 0, height: 4 },
  shadowOpacity: 0.08,
  shadowRadius: 20,
  elevation: 4,
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#F2F2F7',
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
  calendarContainer: {
    backgroundColor: '#FFFFFF',
    marginBottom: 20,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
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
    color: '#000000',
    flex: 1,
  },
  refreshButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: '#F2F2F7',
    justifyContent: 'center',
    alignItems: 'center',
  },
  refreshButtonPressed: {
    backgroundColor: '#E8E8ED',
    opacity: 0.8,
  },
  eventCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: Platform.OS === 'ios' ? 16 : 12,
    marginBottom: 12,
    ...(Platform.OS === 'ios'
      ? shadowStyle
      : {
          elevation: 2,
          borderWidth: StyleSheet.hairlineWidth,
          borderColor: '#E0E0E0',
        }),
    overflow: 'hidden',
  },
  eventCardPressed: {
    opacity: Platform.OS === 'ios' ? 0.8 : 0.6,
    backgroundColor: Platform.OS === 'ios' ? '#F8F9FA' : '#F5F5F5',
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
    color: '#000000',
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
    color: '#007AFF',
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
    color: '#8E8E93',
    marginLeft: 6,
  },
  eventLocationContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  eventLocationText: {
    fontSize: 14,
    fontWeight: '400',
    color: '#8E8E93',
    marginLeft: 6,
    flex: 1,
  },
  eventActionButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#F2F2F7',
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
  },
  eventDescriptionContainer: {
    paddingHorizontal: 16,
    paddingBottom: 16,
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: '#E5E5EA',
    marginTop: 8,
    paddingTop: 12,
  },
  eventDescription: {
    fontSize: 14,
    fontWeight: '400',
    color: '#8E8E93',
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
    color: '#8E8E93',
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
    color: '#000000',
    textAlign: 'center',
    marginBottom: 8,
  },
  errorText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    textAlign: 'center',
    lineHeight: 22,
    marginBottom: 32,
    paddingHorizontal: 20,
  },
  retryButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 32,
    paddingVertical: 14,
    borderRadius: Platform.OS === 'ios' ? 12 : 8,
    minWidth: 120,
  },
  retryButtonPressed: {
    backgroundColor: '#0056CC',
    opacity: 0.8,
  },
  retryButtonText: {
    color: '#FFFFFF',
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
    backgroundColor: '#F2F2F7',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 24,
  },
  emptyTitle: {
    fontSize: 20,
    fontWeight: '600',
    color: '#000000',
    textAlign: 'center',
    marginBottom: 8,
  },
  emptyText: {
    fontSize: 16,
    fontWeight: '400',
    color: '#8E8E93',
    textAlign: 'center',
    lineHeight: 22,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    width: '95%',
    maxHeight: '90%',
    overflow: 'hidden',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#C6C6C8',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000000',
    flex: 1,
    marginRight: 16,
  },
  closeButton: {
    padding: 4,
  },
  closeButtonPressed: {
    opacity: 0.6,
  },
  modalCardContentPressed: {
    backgroundColor: '#F0F0F0',
  },
  modalLinkItemPressed: {
    backgroundColor: '#E8E8ED',
  },
  modalPrimaryButtonPressed: {
    backgroundColor: '#0056CC',
    opacity: 0.8,
  },
  modalSecondaryButtonPressed: {
    backgroundColor: '#F0F0F0',
    opacity: 0.8,
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
    color: '#000000',
    marginLeft: 12,
    flex: 1,
  },
  linkText: {
    color: '#007AFF',
    textDecorationLine: 'underline',
  },
  modalButton: {
    backgroundColor: '#007AFF',
    paddingVertical: 16,
    alignItems: 'center',
    margin: 20,
    marginTop: 0,
    borderRadius: 8,
  },
  modalButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
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
    color: '#8E8E93',
    marginTop: 2,
  },
  modalCard: {
    backgroundColor: '#F9F9F9',
    borderRadius: 12,
    marginBottom: 16,
    overflow: 'hidden',
  },
  modalCardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#E5E5EA',
  },
  modalCardTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginLeft: 8,
  },
  modalCardContent: {
    padding: 16,
  },
  modalDateText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#000000',
    marginBottom: 4,
  },
  modalTimeText: {
    fontSize: 15,
    fontWeight: '500',
    color: '#007AFF',
    marginBottom: 8,
  },
  modalDateDetails: {
    marginTop: 8,
  },
  modalDetailText: {
    fontSize: 13,
    fontWeight: '400',
    color: '#8E8E93',
    marginBottom: 2,
  },
  modalLocationText: {
    fontSize: 15,
    fontWeight: '500',
    color: '#000000',
    marginBottom: 8,
  },
  modalLocationAction: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  modalActionText: {
    fontSize: 14,
    fontWeight: '500',
    color: '#007AFF',
    marginRight: 4,
  },
  modalDescriptionText: {
    fontSize: 15,
    fontWeight: '400',
    color: '#000000',
    lineHeight: 22,
  },
  modalOrganizerText: {
    fontSize: 15,
    fontWeight: '500',
    color: '#000000',
  },
  modalLinkItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
    paddingHorizontal: 12,
    backgroundColor: '#F2F2F7',
    borderRadius: 8,
    marginBottom: 8,
  },
  modalLinkText: {
    fontSize: 14,
    fontWeight: '400',
    color: '#007AFF',
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
    backgroundColor: '#F9F9F9',
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: '#E5E5EA',
    gap: 12,
  },
  modalActionButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 12,
    borderRadius: 8,
    gap: 6,
  },
  modalPrimaryButton: {
    backgroundColor: '#007AFF',
  },
  modalSecondaryButton: {
    backgroundColor: '#FFFFFF',
    borderWidth: 1,
    borderColor: '#007AFF',
  },
  modalPrimaryButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
  modalSecondaryButtonText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#007AFF',
  },
});
