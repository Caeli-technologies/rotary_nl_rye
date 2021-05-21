import 'dart:collection';
import 'dart:convert';
import 'package:dartz/dartz_unsafe.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/calendar/models/event_result.dart';
import 'package:table_calendar/table_calendar.dart';

late Map data;
late String _title;

Future<void> getData() async {
  http.Response response = await http.get(
    Uri.parse(
        "https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY"),
    headers: {
      "Content-Type": "application/json",
    },
  );

  var result = json.decode(response.body);
  var events = EventResult.fromJson(result).events;
  events.forEach((event) => print(event));
}

/// Example event class.
class Event {
  String title, description, location, creator, organizer, startDate, endDate;

  Event(this.title, this.description, this.location, this.creator,
      this.organizer, this.startDate, this.endDate);
}

/// Example events.
///
/// API calandar: https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(2020, 10, item * 5),
    value: (item) => List.generate(
        item % 4 + 1,
        (index) => Event(
            'Farewell Party',
            'Op 22 juni \'s morgens is er in de Kubus Lelystad ook een Infomarkt RYE\nTheaterzaal ‘de Kubus’Tevens Benefietavond ShelterBox, ROTEX in samenwerking met de MDJC (Rotary Youth Exchange)\n\nzie https://www.rotary.nl/yep/nieuws/farewell-party-en-fundraisingsdag-in-lelystad-op-22-juni./',
            "Agorabaan 3, 8224 JS Lelystad, Nederland",
            "clasine.scheepers@gmail.com",
            "rye.netherlands@gmail.com",
            "2019-06-22T17:30:00+02:00",
            "2019-06-22T19:30:00+02:00")))
  ..addAll({
    DateTime.now(): [
      Event(
          'Farewell Party',
          'Op 22 juni \'s morgens is er in de Kubus Lelystad ook een Infomarkt RYE\nTheaterzaal ‘de Kubus’Tevens Benefietavond ShelterBox, ROTEX in samenwerking met de MDJC (Rotary Youth Exchange)\n\nzie https://www.rotary.nl/yep/nieuws/farewell-party-en-fundraisingsdag-in-lelystad-op-22-juni./',
          "Agorabaan 3, 8224 JS Lelystad, Nederland",
          "clasine.scheepers@gmail.com",
          "rye.netherlands@gmail.com",
          "2019-06-22T17:30:00+02:00",
          "2019-06-22T19:30:00+02:00"),
      Event(
          'Farewell Party',
          'Op 22 juni \'s morgens is er in de Kubus Lelystad ook een Infomarkt RYE\nTheaterzaal ‘de Kubus’Tevens Benefietavond ShelterBox, ROTEX in samenwerking met de MDJC (Rotary Youth Exchange)\n\nzie https://www.rotary.nl/yep/nieuws/farewell-party-en-fundraisingsdag-in-lelystad-op-22-juni./',
          "Agorabaan 3, 8224 JS Lelystad, Nederland",
          "clasine.scheepers@gmail.com",
          "rye.netherlands@gmail.com",
          "2019-06-22T17:30:00+02:00",
          "2019-06-22T19:30:00+02:00"),
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
final kFirstDay = DateTime(kNow.year, kNow.month - 12, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 12, kNow.day);
