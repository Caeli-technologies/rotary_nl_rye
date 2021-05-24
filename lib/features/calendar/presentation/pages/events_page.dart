import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/calendar/models/event_result.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/utils.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _pageLoading = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final List<MyEvent> _todayEvents = [];

  // ignore: unused_field
  late List<MyEvent> _myEvent; // TODO: Use otherwise remove

  Future _updateCalendar() async {
    await getData().then((value) => setState(() => _myEvent = value));
    setState(() => _pageLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _updateCalendar();
/* Testing 
    final String defaultLocale = Platform.localeName;
    final clockString = DateFormat.yMMMMd(defaultLocale)
        .format(DateTime.parse('2019-06-22T19:30:00+02:00'));
    debugPrint(clockString); // 07:18 AM
    debugPrint(defaultLocale);
*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<MyEvent> _getEventsForDay(DateTime day) {
    // Implementation example
    //print('kevents${kEvents[day]}');
    return kEvents[day] ?? [];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   // Implementation example
  //   final days = daysInRange(start, end);

  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      // _selectedEvents.value = _getEventsForDay(selectedDay);
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
      // _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      // _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      // _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () => Navigator.pop(context),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
          ),
        ),
        title: Text(
          'Calendar',
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: _pageLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar<MyEvent>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: (date) => _getEventsForDay(_selectedDay!),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: _todayEvents.isEmpty ? 1 : _todayEvents.length,
                    itemBuilder: (context, i) {
                      String defaultLocale = Platform.localeName;
                      if (_todayEvents.isNotEmpty) {
                        return _myEventTile(
                          context: context,
                          defaultLocale: defaultLocale,
                          endDate: _todayEvents[i].end.toString(),
                          startDate: _todayEvents[i].start.toString(),
                          title: _todayEvents[i].summary,
                          description: _todayEvents[i].description,
                          creator: _todayEvents[i].creator,
                          location: _todayEvents[i].location,
                          organizer: _todayEvents[i].organizer,
                        );
                      } else {
                        return const Center(child: Text('No events found'));
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

Widget _myEventTile({
  // Utils
  required BuildContext context,
  required dynamic defaultLocale,
  // Required Fields
  required String endDate,
  creator,
  organizer,
  startDate,
  location,
  title,
  description,
}) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 0.1,
                      blurRadius: 25.0,
                      offset: const Offset(0.0, 1.0)),
                  const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 0.1,
                      blurRadius: 25.0,
                      offset: Offset(0.0, 1.0))
                ]),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
                  width: 50.0,
                  height: 50.0,
                ))),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
          ),
          Text(
              DateFormat.yMMMMd(defaultLocale)
                  .format(DateTime.parse(startDate)),
              style: const TextStyle(
                  inherit: true, fontSize: 14.0, color: Colors.black45)),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 150,
              child: Text(description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                      inherit: true, fontSize: 14.0, color: Colors.black45)),
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => DialogPage1(
                  title: title,
                  description: description,
                  location: location!,
                  startDate: startDate,
                  endDate: endDate,
                  organizer: organizer,
                  creator: creator,
                  defaultLocale: defaultLocale,
                ));
      },
    ),
  );
}

class DialogPage1 extends StatelessWidget {
  final String description,
      title,
      startDate,
      endDate,
      location,
      creator,
      organizer,
      defaultLocale;

  DialogPage1({
    required this.description,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.creator,
    required this.organizer,
    required this.defaultLocale,
  });

  @override
  Widget build(BuildContext context) {
    var date =
        DateFormat.yMMMMd(defaultLocale).format(DateTime.parse(startDate));
    var weekDay =
        DateFormat.EEEE(defaultLocale).format(DateTime.parse(startDate));
    var startTime =
        DateFormat.jm(defaultLocale).format(DateTime.parse(startDate));
    var endTime = DateFormat.jm(defaultLocale).format(DateTime.parse(endDate));

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$weekDay, $date | $startTime - $endTime',
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
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      location,
                      style: const TextStyle(fontSize: 12.0),
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
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      description,
                      style: const TextStyle(fontSize: 12.0),
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
                            style: const TextStyle(
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
                          SizedBox(
                            child: Text('Created by: $creator',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: const TextStyle(
                                    inherit: true,
                                    fontSize: 12.0,
                                    color: Colors.black45)),
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Okay, got it!'),
        ),
      ],
    );
  }
}
