// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';

import '../../../../core/lang/languages.dart';
import '../../../../core/prop.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List _stories = [];

  // Fetch content from the json file
  Future readJson() async {
    final String response =
        await rootBundle.loadString('assets/test/news.json');
    final data = await json.decode(response);
    setState(() {
      _stories = data["news"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
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
          title: Text(
            "News",
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: ListView(shrinkWrap: true, children: [
                  Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: Device.height - 277,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: ListView.builder(
                                  itemCount: _stories.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return Transform.translate(
                                      offset: Offset(0, -10),
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PDFPage(
                                                  pdfUrl: _stories[index]
                                                      ["pdf"])),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: TravelCard(
                                            image: _stories[index]["images"],
                                            country: _stories[index]["country"],
                                            text1: _stories[index]["text1"],
                                            text2: _stories[index]["text2"],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ]))
                ]))));
  }
}

class TravelCard extends StatelessWidget {
  final String country, text1, text2, image;

  TravelCard({this.text1, this.text2, this.country, this.image});

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
