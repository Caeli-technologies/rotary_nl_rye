import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/calendar/models/event_result.dart';
import 'package:table_calendar/table_calendar.dart';

List<MyEvent> _results = [];

Future<List<MyEvent>> getData() async {
  http.Response response = await http.get(
    Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  var result = json.decode(response.body);
  var events = EventResult.fromJson(result).events;
  for (var i = 0; i < events.length; i++) {
    _results.add(
      MyEvent(
        status: events[i].status, // Can be null
        summary: events[i].summary, // Can be null
        description: events[i].description, // Can be null
        location: events[i].location, // Can be null
        id: events[i].id,
        htmlLink: events[i].htmlLink,
        created: events[i].created,
        updated: events[i].updated,
        creator: events[i].creator,
        organizer: events[i].organizer,
        start: events[i].start,
        end: events[i].end,
      ),
    );
    // events.forEach((event) => debugPrint(event));
  }
  return _results;
}

/// Example events.
///
/// API calandar: https://www.googleapis.com/calendar/v3/calendars/rye.netherlands@gmail.com/events?key=AIzaSyCgNcg5M2wIVuPjjIK8ZcHNCSGhG9rUgbY
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<MyEvent>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = _events; //{
//   for (var item in List.generate(50, (index) => index))
//     DateTime.utc(2020, 10, item * 5): List.generate(
//       item % 4 + 1,
//       (index) => MyEvent(
//         id: '06ofid1vnh443vjd29p9o6btos',
//         htmlLink:
//             'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png',
//         created: DateTime.now(),
//         updated: DateTime.now(),
//         creator: Creator(email: 'example@example.com'),
//         organizer: Creator(email: 'example@example.com'),
//         start: End(dateTime: '2012-09-05T07:00:00+02:00'),
//         end: End(dateTime: '2012-09-05T07:00:00+02:00'),
//       ),
//     )
// };
// ..addAll({
// DateTime.now(): [
// Event(
//     'Farewell Party',
//     'Op 22 juni \'s morgens is er in de Kubus Lelystad ook een Infomarkt RYE\nTheaterzaal ‘de Kubus’Tevens Benefietavond ShelterBox, ROTEX in samenwerking met de MDJC (Rotary Youth Exchange)\n\nzie https://www.rotary.nl/yep/nieuws/farewell-party-en-fundraisingsdag-in-lelystad-op-22-juni./',
//     "Agorabaan 3, 8224 JS Lelystad, Nederland",
//     "clasine.scheepers@gmail.com",
//     "rye.netherlands@gmail.com",
//     "2019-06-22T17:30:00+02:00",
//     "2019-06-22T19:30:00+02:00"),
// Event(
//     'Farewell Party',
//     'Op 22 juni \'s morgens is er in de Kubus Lelystad ook een Infomarkt RYE\nTheaterzaal ‘de Kubus’Tevens Benefietavond ShelterBox, ROTEX in samenwerking met de MDJC (Rotary Youth Exchange)\n\nzie https://www.rotary.nl/yep/nieuws/farewell-party-en-fundraisingsdag-in-lelystad-op-22-juni./',
//     "Agorabaan 3, 8224 JS Lelystad, Nederland",
//     "clasine.scheepers@gmail.com",
//     "rye.netherlands@gmail.com",
//     "2019-06-22T17:30:00+02:00",
//     "2019-06-22T19:30:00+02:00"),
// ],
// });
Map<DateTime, List<MyEvent>> get _events {
  var x = {
    //for (var x in _results) DateTime.parse(x.start.toIso8601String()): [x]
    for (var x in _results)
      DateTime.parse(x.created.toIso8601String()): [x] // test
  };
  return x;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  var dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 12, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 12, kNow.day);
