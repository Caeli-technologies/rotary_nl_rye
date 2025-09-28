// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
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
import 'package:rotary_nl_rye/features/rebounds/presentation/pages/CountriesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isLoading = false;
  List<ExchangeStudent> exchangeStudents = [];
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                physics: ClampingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Container(
                    height: 90,
                    margin: EdgeInsets.only(
                        left: 16, right: 16, bottom: 24, top: 16),
                    child: SvgPicture.asset(
                      'assets/image/rotary_rye_nl_logo_home.svg',
                    ),
                  ),
                  Carousel(),
                  SizedBox(height: 16),
                  _buildNavigatorButtons(),
                ],
              ),
      ),
    );
  }

  Widget _buildNavigatorButtons() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            HomeCardItem(
              icon: FontAwesomeIcons.list,
              title: 'Programs',
              pushTo: ProgramPage(),
            ),
            HomeCardItem(
              icon: FontAwesomeIcons.newspaper,
              title: 'News',
              pushTo: NewsPage(),
            ),
            HomeCardItem(
              icon: FontAwesomeIcons.calendarDays,
              title: 'Calendar',
              pushTo: CalendarPage(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            HomeCardItem(
              icon: FontAwesomeIcons.planeDeparture,
              title: 'Op Exchange',
              pushTo: OutboundPage(),
            ),
            HomeCardItemToNL(
              icon: FontAwesomeIcons.planeArrival,
              title: 'To',
              pushTo: InboundPage(),
            ),
            HomeCardItem(
              icon: FontAwesomeIcons.rotateRight,
              title: 'Rebound',
              pushTo: CountriesPage(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            HomeCardItemSingle(
              icon: FontAwesomeIcons.campground,
              title: 'Camps & Tours List',
              pushTo: LoadCsv(),
            ),
            HomeCardItemSingleRotary(
              title: 'voor Rotary Clubs',
              pushTo: ForRotaryClubsPage(),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
