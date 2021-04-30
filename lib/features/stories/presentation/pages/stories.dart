// @dart=2.9
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/languages.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/more.dart';
import 'package:rotary_nl_rye/features/stories/domain/repositories/fromprop.dart';
import 'package:rotary_nl_rye/main.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class InnerTab extends StatefulWidget {
  @override
  _InnerTabState createState() => _InnerTabState();
}

class _InnerTabState extends State<InnerTab> {
  List _stories = [];

  List data = [];
  void getData() async {
    data = await Data.readDB();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:
                CircleTabIndicator(color: Palette.accentColor, radius: 2),
            unselectedLabelColor: Palette.lightIndigo,
            labelColor: Palette.accentColor,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            tabs: [
              Container(
                  height: 30,
                  child: Tab(
                      text: DemoLocalizations.of(context)
                          .trans('storiesTabBar1'))),
              Container(
                  height: 30,
                  child: Tab(
                    text: DemoLocalizations.of(context).trans('storiesTabBar2'),
                  )),
              Container(
                  height: 30,
                  child: Tab(
                    text: DemoLocalizations.of(context).trans('storiesTabBar3'),
                  )),
              Container(
                  height: 30,
                  child: Tab(
                    text: DemoLocalizations.of(context).trans('storiesTabBar4'),
                  )),
            ],
          ),
          Container(
            height: Device.height - 277,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TabBarView(children: [
              FutureBuilder(
                  future: Data.readDB(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      _stories = snapshot.data;
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return new ListView.builder(
                          itemCount: _stories.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Transform.translate(
                              offset: Offset(0, -10),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => More(
                                            image: _stories[index]["images"],
                                            country: _stories[index]["country"],
                                            name: _stories[index]["name"],
                                            text1: _stories[index]["text1"],
                                            text2: _stories[index]["text2"],
                                            departureDate: _stories[index]
                                                ["departureDate"],
                                            arrivalDate: _stories[index]
                                                ["arrivalDate"],
                                          )),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: TravelCard(
                                    image: _stories[index]["images"],
                                    country: _stories[index]["country"],
                                    text1: _stories[index]["text1"],
                                    text2: _stories[index]["text2"],
                                    departureDate: _stories[index]
                                        ["departureDate"],
                                    arrivalDate: _stories[index]["arrivalDate"],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                          child: Container(
                              width: Device.width * 0.4,
                              height: Device.width * 0.4,
                              child: CircularProgressIndicator()));
                    }
                  }),
              Center(
                child: Text("2"),
              ),
              Center(
                child: Text("3"),
              ),
              Center(
                child: Text("4"),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  final String country, text1, text2, image;
  final int departureDate, arrivalDate;

  TravelCard(
      {this.departureDate,
      this.text1,
      this.text2,
      this.arrivalDate,
      this.country,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.themeShadeColor,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: SizedBox(
          height: 120,
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(14.0),
                      child: Image.asset(image),
                    )),
                SizedBox(
                  height: 120,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: Text(
                          country,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Palette.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.planeDeparture,
                              color: Palette.lightIndigo,
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                Device.convert(departureDate),
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Palette.lightIndigo),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.planeArrival,
                              color: Palette.lightIndigo,
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                Device.convert(arrivalDate),
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Palette.lightIndigo),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: SizedBox(
                          width: Device.width - 240,
                          child: Text(text1,
                              textScaleFactor: 0.7,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: Palette.grey)),
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
          )),
    );
  }
}

// Circle tab indicator
class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
// Circle tab indicator END
