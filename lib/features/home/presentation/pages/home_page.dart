// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/calendar/presentation/pages/events_page.dart';
import 'package:rotary_nl_rye/features/forRotaryClubs/presentation/pages/rotary_club_info_page.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/carousel_display.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/home_card_item.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/home_card_item_rotary.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/home_card_item_single.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/inbound_page.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/news_page.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/outbound_page.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/short_term/camps_and_tours/widgets/loadCsv.dart';
import 'package:rotary_nl_rye/features/programs/presentation/pages/program_page.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/countries_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  // _HomePageState() {
  //   // FirebaseAuth.instance.signInAnonymously().then(
  //   //     (UserCredential userCredential) =>
  //   //         _currentSubscription = data.loadNews().listen(_updateNews));
  // }

  bool _isLoading = false;
  List<ExchangeStudent> exchangeStudents = [];
  SharedPreferences? sharedPreferences;
  int _currentNewsIndex = 0;

  // Future readJson(String url) async {
  //   // final String response =
  //   //     await rootBundle.loadString('assets/test/stories.json');
  //   final data = await api.getDataStudentList(url);
  //   exchangeStudents = data;
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // _updateNews(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   _isLoading = false;
  //   _news = data.getNewsFromQuery(snapshot);
  //   readJson(_news.students);
  // }

  @override
  initState() {
    super.initState();
    // TODO: implement dispose
    _loadBadge();
  }

  @override
  void dispose() {
    //  _currentSubscription.cancel();

    // TODO: implement dispose
    super.dispose();
  }

  void _loadBadge() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentNewsIndex = (prefs.getInt('newsBadge') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 90,
                    margin: EdgeInsets.only(
                        left: 16, right: 16, bottom: 24, top: 10),
                    child: SvgPicture.asset(
                        'assets/image/rotary_rye_nl_logo_home.svg'),
                  ),

                  // Slider images
                  Carousel(),

                  // navigator buttons
                  Container(
                    margin: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            HomeCardItem(
                                icon: FontAwesomeIcons.list,
                                title: 'Programs',
                                pushTo: ProgramPage(),
                                currentNewsIndex: 0),
                            HomeCardItem(
                              icon: FontAwesomeIcons.newspaper,
                              title: 'News',
                              pushTo: NewsPage(),
                              currentNewsIndex: _currentNewsIndex,
                            ),
                            HomeCardItem(
                              icon: FontAwesomeIcons.calendarDays,
                              title: 'Calendar',
                              pushTo: CalendarPage(),
                              currentNewsIndex: 0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            HomeCardItem(
                                icon: FontAwesomeIcons.planeDeparture,
                                title: 'Op Exchange',
                                pushTo: OutboundPage(),
                                currentNewsIndex: 0),
                            HomeCardItemToNL(
                                icon: FontAwesomeIcons.planeArrival,
                                title: 'To ',
                                pushTo: InboundPage(),
                                currentNewsIndex: 0),
                            HomeCardItem(
                                icon: FontAwesomeIcons.rotateRight,
                                title: 'Rebound',
                                pushTo: CountriesPage(),
                                currentNewsIndex: 0),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[
                            HomeCardItemSingle(
                                icon: FontAwesomeIcons.campground,
                                title: 'Camps & Tours List',
                                pushTo: LoadCsv(),
                                currentNewsIndex: 0),
                            HomeCardItemSingleRotary(
                                title: 'voor Rotary Clubs',
                                pushTo: ForRotaryClubsPage(),
                                currentNewsIndex: 0),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
