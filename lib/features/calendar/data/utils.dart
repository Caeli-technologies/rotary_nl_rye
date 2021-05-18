import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  String title, description, date;

  Event(this.title, this.description, this.date);
}

/// Example events.
///
/// API calandar: https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll({
    DateTime.now(): [
      Event('Today\'s Event 1', 'test', "18 may 2021"),
      Event('Today\'s Event 2', 'test', "18 may 2021"),
    ],
    DateTime.utc(2021, 05, 19): [
      Event('Today\'s Event 3', 'test', "19 may 2021"),
      Event('Today\'s Event 4', 'test', "19 may 2021"),
    ],
    DateTime.utc(2021, 05, 20): [
      Event('Today\'s Event 3', 'test', "20 may 2021"),
      Event('Today\'s Event 4', 'test', "20 may 2021"),
      Event('Today\'s Event 4', 'test', "20 may 2021"),
      Event('Today\'s Event 4', 'test', "20 may 2021"),
      Event('Today\'s Event 4', 'test', "20 may 2021"),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);
