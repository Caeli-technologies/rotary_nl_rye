import 'dart:collection';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/utils.dart';
import '../../models/event_result.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Events>> _selectedEvents;
  final String localLanguage = Platform.localeName;
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
          systemOverlayStyle:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
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
              print(localLanguage);
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
                      // Use `CalendarStyle` to customize the UI
                      outsideTextStyle: const TextStyle(color: Colors.red),
                      // defaultTextStyle: const TextStyle(color: Colors.black54),
                      outsideDaysVisible: false,

                      //TODO change colour dark mode
                      markerDecoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),

                    //TODO add this to the lang files
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.twoWeeks: '2 weeks',
                      CalendarFormat.week: 'Week'
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
                      //TODO still needs to be added to the Color Pallete
                      dowBuilder: (context, day) {
                        if (day.weekday == DateTime.saturday) {
                          final text = DateFormat.E(localLanguage).format(day);

                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        if (day.weekday == DateTime.sunday) {
                          final text = DateFormat.E(localLanguage).format(day);

                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else {
                          final text = DateFormat.E(localLanguage).format(day);
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.blue),
                            ),
                          );
                        }
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
                                              color: Palette.imageBlox,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        Palette.imageShadowBox2,
                                                    spreadRadius: 0.1,
                                                    blurRadius: 25.0,
                                                    offset: Offset(0.0, 1.0)),
                                                BoxShadow(
                                                    color:
                                                        Palette.imageShadowBox1,
                                                    spreadRadius: 0.1,
                                                    blurRadius: 25.0,
                                                    offset: Offset(0.0, 1.0))
                                              ]),
                                          child: CachedNetworkImage(
                                            height: 50,
                                            width: 50,
                                            imageUrl:
                                                "https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png",
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )),
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
                                                color:
                                                    Palette.descriptionText)),
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
                                                    color: Palette
                                                        .descriptionText)),
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
                                                    .toIso8601String(),
                                                endDate: value[index]
                                                    .end
                                                    .dateTime
                                                    .toIso8601String(),
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
                                    child: Text(
                                        'No events found')); //TODO add to lang file
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
    final startFullDate = DateFormat.yMMMMd(defaultLocale)
        .format(DateTime.parse(startDate).toLocal());
    final endFullDate = DateFormat.yMMMMd(defaultLocale)
        .format(DateTime.parse(endDate).toLocal());
    final startWeekDay = DateFormat.EEEE(defaultLocale)
        .format(DateTime.parse(startDate).toLocal());
    final endWeekDay = DateFormat.EEEE(defaultLocale)
        .format(DateTime.parse(endDate).toLocal());
    final startTime = DateFormat.jm(defaultLocale)
        .format(DateTime.parse(startDate).toLocal());
    final endTime =
        DateFormat.jm(defaultLocale).format(DateTime.parse(endDate).toLocal());

    // Widget _detectMultipleDays() {
    //   if (startFullDate == endFullDate) {
    //     return SizedBox.shrink();
    //   } else {
    //     return Padding(
    //       padding: const EdgeInsets.only(top: 5.0, bottom: 16),
    //       child: Row(
    //         children: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 0.0),
    //             child: FaIcon(
    //               FontAwesomeIcons.clock,
    //               color: Palette.lightIndigo,
    //               size: 20,
    //             ),
    //           ),
    //           Expanded(
    //             child: Padding(
    //               padding: EdgeInsets.only(left: 12.0),
    //               child: Text(
    //                 '$startTime - $endTime',
    //                 style: const TextStyle(fontSize: 12.0),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }
    // }
    return Platform.isIOS
        ? new CupertinoAlertDialog(
            title: Text(title ?? 'there is no Title'),
            content: new Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  startTime == endTime
                      ? "$startWeekDay, $startFullDate - \n$endWeekDay, $endFullDate"
                      : "$startWeekDay, $startFullDate \n$startTime - $endTime",
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),

                // _detectMultipleDays(),

                //TODO fix padding location link
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AbsorbPointer(
                    absorbing: (location == null),
                    child: TextButton(
                      onPressed: () {
                        if (location != null) {
                          MapsLauncher.launchQuery(location!);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
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
                        child: Text(
                          description ?? 'there is no description',
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: FaIcon(
                          FontAwesomeIcons.calendarDay,
                          color: Palette.lightIndigo,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          organizer,
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),

                // Text(

                //       "$startWeekDay, $startFullDate - $endWeekDay, $endFullDate",
                //   style: TextStyle(color: Palette.bodyText, fontSize: 12.0),
                // ),
                Text("Created by: $creator",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        inherit: true,
                        fontSize: 12.0,
                        color: Palette.creatorText))
                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0),
                //   child: Row(
                //     children: <Widget>[
                //       Padding(
                //         padding: const EdgeInsets.only(left: 5.0),
                //         child: FaIcon(
                //           FontAwesomeIcons.calendarDay,
                //           color: Palette.lightIndigo,
                //           size: 20,
                //         ),
                //       ),
                //       Expanded(
                //         child: ListTile(
                //           title: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: <Widget>[
                //               Text(organizer,
                //                   style:
                //                       TextStyle(inherit: true, fontSize: 14.0)),
                //             ],
                //           ),
                //           subtitle: Padding(
                //             padding: const EdgeInsets.only(top: 0.0),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: <Widget>[
                //                 Expanded(
                //                   child: SizedBox(
                //                     child: Text("Created by: $creator",
                //                         maxLines: 2,
                //                         overflow: TextOverflow.ellipsis,
                //                         softWrap: false,
                //                         style: TextStyle(
                //                             inherit: true,
                //                             fontSize: 12.0,
                //                             color: Palette.creatorText)),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
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
          )
        : new AlertDialog(
            title: Text(title ?? 'there is no Title'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  startTime == endTime
                      ? "$startWeekDay, $startFullDate - $endWeekDay, $endFullDate"
                      : "$startWeekDay, $startFullDate | $startTime - $endTime",
                  style: TextStyle(color: Palette.bodyText, fontSize: 12.0),
                ),
                // _detectMultipleDays(),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: AbsorbPointer(
                    absorbing: (location == null),
                    child: TextButton(
                      onPressed: () {
                        if (location != null) {
                          MapsLauncher.launchQuery(location!);
                        }
                      },
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
                  ),
                ),
                Padding(
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
                        padding: const EdgeInsets.only(left: 5.0),
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
                                  style:
                                      TextStyle(inherit: true, fontSize: 14.0)),
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
                                            color: Palette.creatorText)),
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

            // actions: <Widget>[
            //   action != null
            //       ? TextButton(
            //           child: Text(action),
            //           onPressed: () {
            //             Navigator.pop(context);
            //           },
            //         )
            //       : TextButton(
            //           child: Text("OK"),
            //           onPressed: () {
            //             Navigator.pop(context);
            //           },
            //         )
            // ],
          );

    // test
    // return new AlertDialog(
    //   title: Text(title ?? 'there is no Title'),
    //   content: new Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(
    //         startTime == endTime
    //             ? "$startWeekDay, $startFullDate - $endWeekDay, $endFullDate"
    //             : "$startWeekDay, $startFullDate | $startTime - $endTime",
    //         style: TextStyle(color: Palette.bodyText, fontSize: 12.0),
    //       ),
    //       // _detectMultipleDays(),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 16.0),
    //         child: AbsorbPointer(
    //           absorbing: (location == null),
    //           child: TextButton(
    //             onPressed: () {
    //               if (location != null) {
    //                 MapsLauncher.launchQuery(location!);
    //               }
    //             },
    //             child: Row(
    //               children: <Widget>[
    //                 Padding(
    //                   padding: const EdgeInsets.only(bottom: 0.0),
    //                   child: FaIcon(
    //                     FontAwesomeIcons.mapMarkerAlt,
    //                     color: Palette.lightIndigo,
    //                     size: 20,
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: Padding(
    //                     padding: EdgeInsets.only(left: 12.0),
    //                     child: Text(
    //                       location ?? 'there is no location',
    //                       style: TextStyle(fontSize: 12.0),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 16.0),
    //         child: Row(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(left: 5.0),
    //               child: FaIcon(
    //                 FontAwesomeIcons.alignLeft,
    //                 color: Palette.lightIndigo,
    //                 size: 20,
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: EdgeInsets.only(left: 12.0),
    //                 child: Text(
    //                   description ?? 'there is no description',
    //                   style: TextStyle(fontSize: 12.0),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(top: 16.0),
    //         child: Row(
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.only(left: 5.0),
    //               child: FaIcon(
    //                 FontAwesomeIcons.calendarDay,
    //                 color: Palette.lightIndigo,
    //                 size: 20,
    //               ),
    //             ),
    //             Expanded(
    //               child: ListTile(
    //                 title: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: <Widget>[
    //                     Text(organizer,
    //                         style: TextStyle(inherit: true, fontSize: 14.0)),
    //                   ],
    //                 ),
    //                 subtitle: Padding(
    //                   padding: const EdgeInsets.only(top: 0.0),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: <Widget>[
    //                       Expanded(
    //                         child: SizedBox(
    //                           child: Text("Created by: $creator",
    //                               maxLines: 2,
    //                               overflow: TextOverflow.ellipsis,
    //                               softWrap: false,
    //                               style: TextStyle(
    //                                   inherit: true,
    //                                   fontSize: 12.0,
    //                                   color: Palette.creatorText)),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    //   actions: <Widget>[
    //     new TextButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       child: const Text('Okay, got it!'),
    //     ),
    //   ],
    // );
  }
}
