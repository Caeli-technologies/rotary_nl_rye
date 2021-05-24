import 'dart:collection';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/event_result.dart';
import '../../data/utils.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Events>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late Future<LinkedHashMap<DateTime, List<Events>>> getEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    getEvents = getData();
/* Testing
    final String defaultLocale = Platform.localeName;
    final clockString = DateFormat.yMMMMd(defaultLocale)
        .format(DateTime.parse('2019-06-22T19:30:00+02:00'));
    print(clockString); // 07:18 AM
    print(defaultLocale);
*/
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  LinkedHashMap<DateTime, List<Events>> kEvents =
      LinkedHashMap<DateTime, List<Events>>();

  List<Events> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Events> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Initial kEvents is empty becuase its null.");
    print(kEvents.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Icon(
                Icons.arrow_back,
                color: Palette.accentColor,
                size: 30.0,
              ),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Palette.themeShadeColor,
              padding: const EdgeInsets.all(5.0),
            ),
          ),
          title: Text(
            "Calendar",
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
            future: getEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              kEvents = snapshot.data as LinkedHashMap<DateTime, List<Events>>;
              print("Got data for kEvents");
              print(kEvents.length);
              return Column(
                children: [
                  TableCalendar<Events>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      // Use `CalendarStyle` to customize the UI
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ValueListenableBuilder<List<Events>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        return ListView.builder(
                            itemCount: value.isEmpty ? 1 : value.length,
                            itemBuilder: (context, index) {
                              final String defaultLocale = Platform.localeName;
                              if (value.isNotEmpty) {
                                return Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    spreadRadius: 0.1,
                                                    blurRadius: 25.0,
                                                    offset: Offset(0.0, 1.0)),
                                                BoxShadow(
                                                    color: Colors.white,
                                                    spreadRadius: 0.1,
                                                    blurRadius: 25.0,
                                                    offset: Offset(0.0, 1.0))
                                              ]),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png",
                                                width: 50.0,
                                                height: 50.0,
                                              ))),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          width: Device.width - 260,
                                          child: Text("${value[index].summary}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  inherit: true,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Text(
                                            "${DateFormat.yMMMMd(defaultLocale).format(value[index].start.dateTime)}",
                                            style: TextStyle(
                                                inherit: true,
                                                fontSize: 14.0,
                                                color: Colors.black45)),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: Device.width - 150,
                                            child: Text(
                                                value[index].description ??
                                                    'there is no description',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    inherit: true,
                                                    fontSize: 14.0,
                                                    color: Colors.black45)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //onTap: () => print('\nTitle: ${value[index].title} \ndescription: ${value[index].description}'),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => DialogPage1(
                                                title: value[index].summary,
                                                description:
                                                    value[index].description,
                                                location: value[index].location,
                                                startDate: value[index]
                                                    .start
                                                    .dateTime
                                                    .toString(),
                                                endDate: value[index]
                                                    .end
                                                    .dateTime
                                                    .toString(),
                                                organizer: value[index]
                                                    .organizer
                                                    .email,
                                                creator:
                                                    value[index].creator.email,
                                                defaultLocale: defaultLocale,
                                              ));
                                    },
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: Text('No events found'));
                              }
                            });
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}

class DialogPage1 extends StatelessWidget {
  final String startDate, endDate, creator, organizer, defaultLocale;
  final String? description, title, location;
  DialogPage1({
    this.description,
    this.title,
    required this.startDate,
    required this.endDate,
    this.location,
    required this.creator,
    required this.organizer,
    required this.defaultLocale,
  });

  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat.yMMMMd(defaultLocale).format(DateTime.parse(startDate));
    final weekDay =
        DateFormat.EEEE(defaultLocale).format(DateTime.parse(startDate));
    final startTime =
        DateFormat.jm(defaultLocale).format(DateTime.parse(startDate));
    final endTime =
        DateFormat.jm(defaultLocale).format(DateTime.parse(endDate));

    return new AlertDialog(
      title: Text(title ?? 'there is no Title'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$weekDay, $date | $startTime - $endTime",
            style: const TextStyle(color: Colors.black87, fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: Palette.lightIndigo,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      location ?? 'there is no location',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.alignLeft,
                    color: Palette.lightIndigo,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      description ?? 'there is no description',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.calendarDay,
                    color: Palette.lightIndigo,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(organizer,
                            style: TextStyle(
                                inherit: true,
                                fontSize: 14.0,
                                color: Colors.black)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              child: Text("Created by: $creator",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      inherit: true,
                                      fontSize: 12.0,
                                      color: Colors.black45)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}
