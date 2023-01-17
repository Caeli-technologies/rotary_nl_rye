// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/forRotaryClubs/presentation/pages/rotary_club_info_page.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/card_items/calendar_card.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/card_items/news_card.dart';
import 'package:rotary_nl_rye/features/home/presentation/widgets/carousel_display.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/inbound_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/card_item.dart';
import '../widgets/card_items/camps_and_tours_card.dart';
import '../widgets/card_items/outbound_card.dart';
import '../widgets/card_items/program_card.dart';
import '../widgets/card_items/rebound_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isLoading = false;
  List<ExchangeStudent> exchangeStudents = [];
  SharedPreferences? sharedPreferences;
  int _currentNewsIndex = 0;

  @override
  initState() {
    super.initState();
    // TODO: implement dispose
    _loadBadge();
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
                padding:
                    EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 26),
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 90,
                    child: SvgPicture.asset(
                        'assets/image/rotary_rye_nl_logo_home.svg'),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  // Slider images
                  Carousel(),

                  SizedBox(
                    height: 24,
                  ),

                  // navigation panes
                  StaggeredGrid.count(
                    crossAxisCount: 6,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 8,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: ProgramCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: NewsCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: CalendarCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: OutboundCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: CardItem(
                          icon: FaIcon(
                            FontAwesomeIcons.planeArrival,
                            color: Palette.lightIndigo,
                            size: 35,
                          ),
                          title: Row(
                            children: [
                              Text(
                                'To ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Palette.indigo,
                                ),
                              ),
                              // airplain
                              FaIcon(
                                FontAwesomeIcons.arrowRightLong,
                                color: Palette.lightIndigo,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              // NL
                              SvgPicture.asset(
                                'assets/icons/flags/nl.svg',
                                height: 15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          pushTo: InboundPage(),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: ReboundCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 1.5,
                        child: CampsAndToursCard(),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 3,
                        mainAxisCellCount: 1.5,
                        child: CardItem(
                          icon: SvgPicture.asset(
                              'assets/icons/custom/rotary-logo-icon.svg',
                              // color: Color(0xFFf7a81b),
                              color: Palette.lightIndigo,
                              height: 35),
                          title: Text(
                            'voor Rotary Clubs',
                            style: TextStyle(
                              fontSize: 14,
                              color: Palette.indigo,
                            ),
                          ),
                          pushTo: ForRotaryClubsPage(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
