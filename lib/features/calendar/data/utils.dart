import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/calendar/models/event_result.dart';
import 'package:table_calendar/table_calendar.dart';

late Map<String, dynamic> data;
//late String _title;
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
    throw 'unable to parse calendar api';
  }

  data = json.decode(response.body);
  events = EventResult.fromJson(data).events;
  //This is n^2 in time. Find a better implementation?
  eventsHashMap.clear();
  events.forEach((event) {
    //   eventsHashMap[event.start.dateTime] = [event];
    //if a day has more than one event the above implementation will replace the existing event
    if (!eventsHashMap.containsKey(event.start.dateTime)) {
      eventsHashMap[event.start.dateTime] =
          []; //this line is to avoid null error and initialize the list
      eventsHashMap[event.start.dateTime]!.add(event);
    } else {
      eventsHashMap[event.start.dateTime]!.add(event);
    }
  });

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
final kFirstDay = DateTime(kNow.year, kNow.month - 12, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 12, kNow.day);
