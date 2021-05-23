import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/calendar/models/event_result.dart';
import 'package:table_calendar/table_calendar.dart';

late Map<String, dynamic> data;
late String _title;
late List<Events> events;
late LinkedHashMap<DateTime, List<Events>> eventsData;
var eventsHashMap = LinkedHashMap<DateTime, List<Events>>();
Future<LinkedHashMap<DateTime, List<Events>>> getData() async {
  http.Response response = await http.get(
    Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY"),
    headers: {
      "Content-Type": "application/json",
    },
  );

  data = json.decode(response.body);
  events = EventResult.fromJson(data).events;
  //This is n^2 in time. Find a better implementation?
  events.forEach((event) {
    eventsHashMap[event.start.dateTime] = [event];
  });
  final kEvents = LinkedHashMap<DateTime, List<Events>>(
    equals: isSameDay,
    hashCode: getHashCode,
  )..addAll(eventsHashMap);
  return kEvents;
}

/// Example event class.
// class Event {
//   String title, description, location, creator, organizer, startDate, endDate;
//
//   Event(this.title, this.description, this.location, this.creator,
//       this.organizer, this.startDate, this.endDate);
// }

/// Example events.
///
/// API calandar: https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

// final LinkedHashMap<DateTime, List<Events>> kEvents =
//     LinkedHashMap<DateTime, List<Events>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(eventsHashMap);

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
final kFirstDay = DateTime(kNow.year, kNow.month - 12, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 12, kNow.day);
