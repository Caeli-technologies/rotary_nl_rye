// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/lang/languages.dart';
import '../../../../core/prop.dart';
import '../../domain/entities/story.dart';
import '../bloc/stories_bloc.dart';
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
    BlocProvider.of<StoriesBloc>(context).add(BGetStories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, top: 60, right: 20),
          child: Text(
            DemoLocalizations.of(context).trans('storiesHomeHeader'),
            textScaleFactor: 2.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
                      color: Palette.themeCardShadeColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
          height: 50,
          margin: EdgeInsets.only(left: 20, top: 15, right: 20),
          width: Device.width,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Search...", style: TextStyle(color: Palette.grey),))),
        ),
        Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
/*
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
*/
                  Container(
                    height: Device.height - 277,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: ListView.builder(
                        itemCount: _stories.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Transform.translate(
                            offset: Offset(0, -10),
                            child: GestureDetector(
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
                                        arrivalDate:
                                            _stories[index].arrivalDate)),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: TravelCard(
                                    image: _stories[index].imagePath,
                                    country: _stories[index].country,
                                    text1: _stories[index].text1,
                                    text2: _stories[index].text2,
                                    departureDate:
                                        _stories[index].departureDate,
                                    arrivalDate: _stories[index].arrivalDate),
                              ),
                            ),
                          );
                        }),
                  ),
                ])),
      ],
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
