// event_utils.dart

// 🎯 Dart imports:
import 'dart:collection';
import 'dart:convert';

// 📦 Package imports:
import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/calendar/models/EventModel.dart';
import 'package:table_calendar/table_calendar.dart';

late Map<String, dynamic> data;
late List<Events> events;
late LinkedHashMap<DateTime, List<Events>> eventsData;
var eventsHashMap = LinkedHashMap<DateTime, List<Events>>();

Future<LinkedHashMap<DateTime, List<Events>>> getData() async {
  http.Response? response;
  try {
    response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  } catch (e) {
    print(e);
    throw 'Unable to parse calendar API';
  }

  data = json.decode(response.body);
  events = EventResult.fromJson(data).events;

  eventsHashMap.clear();
  for (var event in events) {
    DateTime eventStart = event.start.dateTime;
    DateTime eventEnd = event.end.dateTime;

    if (eventStart.isBefore(eventEnd)) {
      eventEnd =
          eventEnd.subtract(Duration(days: 1)); // Ensure end date is exclusive
    }

    for (DateTime date = eventStart;
        date.isBefore(eventEnd) || isSameDay(date, eventEnd);
        date = date.add(Duration(days: 1))) {
      if (!eventsHashMap.containsKey(date)) {
        eventsHashMap[date] = [];
      }
      eventsHashMap[date]!.add(event);
    }
  }

  final kEvents = LinkedHashMap<DateTime, List<Events>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(eventsHashMap);

  return kEvents;
}

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
final kFirstDay = DateTime(kNow.year, kNow.month - 24, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 24, kNow.day);
