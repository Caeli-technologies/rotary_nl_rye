// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/stories/data/utils.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

import '../../../../core/prop.dart';
import '../widgets/story_details_page.dart';

class StoriesDisplay extends StatefulWidget {
  final ExchangeStudent student;

  StoriesDisplay({@required this.student});

  @override
  _StoriesDisplayState createState() => _StoriesDisplayState(student: student);
}

class _StoriesDisplayState extends State<StoriesDisplay> {
  _StoriesDisplayState({@required this.student});

  List<Story> stories = [];
  final ExchangeStudent student;

  // Fetch content from the json file
  Future readJson() async {
    // final String response =
    //     await rootBundle.loadString('assets/test/stories.json');
    final data = await getData(
        "https://rotary.caeli-tech.com/rebounds/students/stories.json");
    setState(() {
      stories = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

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
                  backgroundImage: AssetImage(student.imageUrl),
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
                      student.name,
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
                                  'Sponsor District ${student.sponsorDistrict}',
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                    color: Palette.indigo,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Host District ${student.hostDistrict}',
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
                      itemCount: stories.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryDetails(
                                      story: stories[index],
                                    )),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TravelCard(story: stories[index]),
                          ),
                        );
                      }),
                )
              ])),
        ));
  }
}

class TravelCard extends StatelessWidget {
  final Story story;

  TravelCard({@required this.story});

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
                      child: Image.asset(story.imageUrl),
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
                          story.country,
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
                                story.departureDate.toString(),
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
                                story.arrivalDate.toString(),
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
                          child: Text(story.text1,
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
