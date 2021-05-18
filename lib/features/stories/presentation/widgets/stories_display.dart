// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/prop.dart';
import '../../domain/entities/story.dart';
import '../pages/stories_details_page.dart';

class StoriesDisplay extends StatefulWidget {
  final stories;

  StoriesDisplay({this.stories});

  @override
  _StoriesDisplayState createState() => _StoriesDisplayState(stories);
}

class _StoriesDisplayState extends State<StoriesDisplay> {
  final List<Story> _stories;

  _StoriesDisplayState(this._stories);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(shrinkWrap: true, children: [
                Container(
                    child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/image/1.PNG"),
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Palette.themeShadeColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40.0),
                    ),
                  ),
                  child: Column(children: <Widget>[
                    Text(
                      "Ruben Talstra",
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                      style: TextStyle(
                        color: Palette.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 40, top: 10, right: 40, bottom: 10),
                            child: Wrap(
                              runSpacing: 15.0,
                              spacing: 30.0,
                              children: <Widget>[
                                Text(
                                  "Sponsor District 1590",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Palette.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Host District 7820",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Palette.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ))),
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Stories",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                  style: TextStyle(
                    color: Palette.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  height: Device.height - 395,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: _stories.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoriesDetails(
                                    image: _stories[index].imagePath,
                                    country: _stories[index].country,
                                    name: _stories[index].studentName,
                                    text1: _stories[index].text1,
                                    text2: _stories[index].text2,
                                    departureDate:
                                        _stories[index].departureDate,
                                    arrivalDate: _stories[index].arrivalDate)),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TravelCard(
                                image: _stories[index].imagePath,
                                country: _stories[index].country,
                                text1: _stories[index].text1,
                                text2: _stories[index].text2,
                                departureDate: _stories[index].departureDate,
                                arrivalDate: _stories[index].arrivalDate),
                          ),
                        );
                      }),
                )
              ])),
        ));
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
