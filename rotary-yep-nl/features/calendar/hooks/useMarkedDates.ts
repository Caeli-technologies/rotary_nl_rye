/**
 * Hook for creating marked dates for calendar component
 */

import { useMemo } from "react";
import type { EventsData, MarkedDates } from "../types";

interface UseMarkedDatesOptions {
  eventsData: EventsData;
  selectedDate: string;
  dotColor: string;
  selectedColor: string;
  selectedTextColor: string;
}

export function useMarkedDates({
  eventsData,
  selectedDate,
  dotColor,
  selectedColor,
  selectedTextColor,
}: UseMarkedDatesOptions): MarkedDates {
  return useMemo(() => {
    const marked: MarkedDates = {};

    // Add dots for days with events
    Object.keys(eventsData).forEach((dateKey) => {
      if (eventsData[dateKey] && eventsData[dateKey].length > 0) {
        marked[dateKey] = {
          marked: true,
          dotColor,
        };
      }
    });

    // Add selection styling
    marked[selectedDate] = {
      ...marked[selectedDate],
      selected: true,
      selectedColor,
      selectedTextColor,
    };

    return marked;
  }, [eventsData, selectedDate, dotColor, selectedColor, selectedTextColor]);
}
