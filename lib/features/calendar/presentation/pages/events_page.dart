// calendar_page.dart

// 🎯 Dart imports:
import 'dart:collection';
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/calendar/data/EventUtils.dart';
import 'package:rotary_nl_rye/features/calendar/models/EventModel.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Events>> _selectedEvents;
  final String localLanguage = Platform.localeName;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
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
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  LinkedHashMap<DateTime, List<Events>> kEvents =
      LinkedHashMap<DateTime, List<Events>>();

  List<Events> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Events> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [for (final d in days) ..._getEventsForDay(d)];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
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
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: MediaQuery.of(context).platformBrightness,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Calendar',
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: getEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching events'));
          }
          kEvents = snapshot.data as LinkedHashMap<DateTime, List<Events>>;
          return buildCalendarView(context);
        },
      ),
    );
  }

  Widget buildCalendarView(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Events>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          locale: localLanguage,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          rangeSelectionMode: _rangeSelectionMode,
          eventLoader: _getEventsForDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarStyle: CalendarStyle(
            outsideTextStyle: const TextStyle(color: Colors.red),
            outsideDaysVisible: false,
            markerDecoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.twoWeeks: '2 weeks',
            CalendarFormat.week: 'Week',
          },
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
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final text = DateFormat.E(localLanguage).format(day);
              return Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: day.weekday == DateTime.saturday ||
                            day.weekday == DateTime.sunday
                        ? Colors.red
                        : Colors.blue,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Events>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.isEmpty ? 1 : value.length,
                itemBuilder: (context, index) {
                  if (value.isNotEmpty) {
                    return buildEventTile(context, value[index]);
                  } else {
                    return const Center(child: Text('No events found'));
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildEventTile(BuildContext context, Events event) {
    final String defaultLocale = Platform.localeName;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: Palette.imageBlox,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Palette.imageShadowBox2,
                  spreadRadius: 0.1,
                  blurRadius: 25.0,
                  offset: Offset(0.0, 1.0),
                ),
                BoxShadow(
                  color: Palette.imageShadowBox1,
                  spreadRadius: 0.1,
                  blurRadius: 25.0,
                  offset: Offset(0.0, 1.0),
                ),
              ],
            ),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl:
                  'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        title: buildEventTitle(event, defaultLocale),
        subtitle: buildEventDescription(event),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) =>
                EventDetailsDialog(event: event, defaultLocale: defaultLocale),
          );
        },
      ),
    );
  }

  Widget buildEventTitle(Events event, String defaultLocale) {
    bool isMultiDayEvent = !isSameDay(event.start.dateTime, event.end.dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.summary ?? 'No Title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          style: TextStyle(
            inherit: true,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                isMultiDayEvent
                    ? '${DateFormat.yMMMMd(defaultLocale).format(event.start.dateTime)} - ${DateFormat.yMMMMd(defaultLocale).format(event.end.dateTime)}'
                    : DateFormat.yMMMMd(defaultLocale)
                        .format(event.start.dateTime),
                style: TextStyle(
                  inherit: true,
                  fontSize: 14.0,
                  color: Palette.descriptionText,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildEventDescription(Events event) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              event.description ?? 'No description',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(
                inherit: true,
                fontSize: 14.0,
                color: Palette.descriptionText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetailsDialog extends StatelessWidget {
  final Events event;
  final String defaultLocale;

  EventDetailsDialog({
    required this.event,
    required this.defaultLocale,
  });

  @override
  Widget build(BuildContext context) {
    final startFullDate =
        DateFormat.yMMMMd(defaultLocale).format(event.start.dateTime.toLocal());
    final startWeekDay =
        DateFormat.EEEE(defaultLocale).format(event.start.dateTime.toLocal());
    final startTime =
        DateFormat.jm(defaultLocale).format(event.start.dateTime.toLocal());
    final endTime =
        DateFormat.jm(defaultLocale).format(event.end.dateTime.toLocal());

    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(event.description ?? '');

    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(event.summary ?? 'No Title'),
            content: buildDialogContent(context, startWeekDay, startFullDate,
                startTime, endTime, exp, matches),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay, got it!'),
              ),
            ],
          )
        : AlertDialog(
            title: Text(event.summary ?? 'No Title'),
            content: buildDialogContent(context, startWeekDay, startFullDate,
                startTime, endTime, exp, matches),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay, got it!'),
              ),
            ],
          );
  }

  Widget buildDialogContent(
      BuildContext context,
      String startWeekDay,
      String startFullDate,
      String startTime,
      String endTime,
      RegExp exp,
      Iterable<RegExpMatch> matches) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          startTime == endTime
              ? '$startWeekDay, $startFullDate'
              : '$startWeekDay, $startFullDate | $startTime - $endTime',
          style: TextStyle(color: Palette.bodyText, fontSize: 12.0),
        ),
        buildLocationButton(context),
        buildDescription(),
        buildLinkButton(exp, matches),
      ],
    );
  }

  Widget buildLocationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AbsorbPointer(
        absorbing: (event.location == null),
        child: TextButton(
          onPressed: () async {
            if (event.location != null) {
              final availableMaps = await MapLauncher.installedMaps;
              if (availableMaps.isNotEmpty) {
                final coords =
                    await _getCoordinatesFromAddress(event.location!);

                if (coords != null) {
                  await availableMaps.first.showMarker(
                    coords: coords,
                    title: event.location!,
                  );
                } else {
                  // Handle the case where the address cannot be geocoded
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Unable to find location coordinates.')),
                  );
                }
              }
            }
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: Palette.lightIndigo,
                  size: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    event.location ?? 'No location',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Coords?> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return Coords(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }
    return null;
  }

  Widget buildDescription() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
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
                event.description ?? 'No description',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLinkButton(RegExp exp, Iterable<RegExpMatch> matches) {
    return exp.hasMatch(event.description ?? '')
        ? Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: FaIcon(
                  FontAwesomeIcons.link,
                  color: Palette.lightIndigo,
                  size: 20,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(),
                  child: TextButton(
                    onPressed: () {
                      matches.forEach((match) {
                        String sendLink = event.description!
                            .substring(match.start, match.end);
                        launchUrlString(sendLink);
                      });
                    },
                    child: Text('Link'),
                  ),
                ),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
