// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/data/more.dart';
import 'package:rotary_nl_rye/views/prop.dart';

class InnerTab extends StatefulWidget {
  @override
  _InnerTabState createState() => _InnerTabState();
}

class _InnerTabState extends State<InnerTab> {
  List _stories = [];

  // Fetch content from the json file
  Future readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/stories.json');
    final data = await json.decode(response);
    setState(() {
      _stories = data["stories"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
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
            indicator: CircleTabIndicator(
                color: Palette.accentColor, radius: 2),
            unselectedLabelColor: Palette.lightIndigo,
            labelColor: Palette.accentColor,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            tabs: [
              Container(height: 30, child: Tab(text: "Stories")),
              Container(
                  height: 30,
                  child: Tab(
                    text: "info",
                  )),
              Container(
                  height: 30,
                  child: Tab(
                    text: "geen idee",
                  )),
              Container(
                  height: 30,
                  child: Tab(
                    text: "????",
                  )),
            ],
          ),
          Container(
            height: Device.height - 277,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TabBarView(children: [
              ListView.builder(
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
                                    arrivalDate: _stories[index]["arrivalDate"],
                                  )),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TravelCard(
                            images: _stories[index]["images"],
                            country: _stories[index]["country"],
                            text1: _stories[index]["text1"],
                            text2: _stories[index]["text2"],
                            departureDate: _stories[index]["departureDate"],
                            arrivalDate: _stories[index]["arrivalDate"],
                          ),
                        ),
                      ),
                    );
                  }),
              Container(
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
  final String country, text1, text2, images, departureDate, arrivalDate;

  TravelCard(
      {this.departureDate,
      this.text1,
      this.text2,
      this.arrivalDate,
      this.country,
      this.images});

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
                      child: Image.asset(images),
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
                                departureDate,
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
                                arrivalDate,
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
