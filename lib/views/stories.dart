// @dart=2.9
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:rotary_nl_rye/data/more.dart';

class InnerTab extends StatelessWidget {
  final List<String> titles = [
    "Bali",
    "Bukittinggi",
    "Yogyakarta",
    "Bogor",
    "Bandung",
    "Malang"
  ];
  final List<double> stars = [4, 3, 5, 5, 4, 5];
  final List<String> images = [
    "assets/3.PNG",
    "assets/2.PNG",
    "assets/3.PNG",
    "assets/2.PNG",
    "assets/2.PNG",
    "assets/3.PNG"
  ];

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
                color: Color.fromRGBO(57, 182, 245, 1), radius: 2),
            unselectedLabelColor: Colors.indigo[100],
            labelColor: Color.fromRGBO(57, 182, 245, 1),
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
            height: 700,
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: TabBarView(children: [
              ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Transform.translate(
                      offset: Offset(0, -24),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => More(
                                    title: titles[index],
                                    rating: stars[index],
                                    image: images[index],
                                  )),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TravelCard(
                            title: titles[index],
                            rating: stars[index],
                            images: images[index],
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
  final double rating;
  final String title, images;

  TravelCard({this.rating, this.title, this.images});

  @override
  Widget build(BuildContext context) {
    double r = rating;

    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 249, 1),
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: SizedBox(
          height: 80,
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                    height: 80,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(14.0),
                      child: Image.asset(images),
                    )),
                SizedBox(
                  height: 80,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: Text(
                          title,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Color.fromRGBO(19, 33, 70, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, top: 4),
                          child: Row(
                            children: <Widget>[
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  onRatingChanged: (v) {
                                    r = v;
                                  },
                                  starCount: 5,
                                  rating: rating,
                                  size: 10.0,
                                  color: Colors.orange,
                                  borderColor: Colors.orange,
                                  spacing: 0.0),
                              Container(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  rating.toInt().toString(),
                                  textScaleFactor: 0.8,
                                  style: TextStyle(color: Colors.orange),
                                ),
                              )
                            ],
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: Text(
                          "Kota Denpasar merupakan \nkota terbesar kedua di willayah..",
                          textScaleFactor: 0.7,
                          style: TextStyle(color: Colors.grey),
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
