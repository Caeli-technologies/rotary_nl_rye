// @dart=2.9
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final List<String> departures = [
    "12 april 2014",
    "13 mei 2015",
    "14 juni 2016",
    "15 julli 2017",
    "16 augustus 2018",
    "17 september 2019"
  ];
  final List<String> arivals = [
    "18 november 2015",
    "19 decemeber 2016",
    "20 januarie 2017",
    "21 fabuarie 2018",
    "22 maart 2019",
    "23 april 2020"
  ];
  final List<String> images = [
    "assets/3.PNG",
    "assets/2.PNG",
    "assets/3.PNG",
    "assets/2.PNG",
    "assets/2.PNG",
    "assets/3.PNG"
  ];
  final List<String> texts = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh."
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
            height: 640,
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
                                    image: images[index],
                                    title: titles[index],
                                    text: texts[index],
                                    departure: departures[index],
                                    arival: arivals[index],
                                  )),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TravelCard(
                            images: images[index],
                            title: titles[index],
                            text: texts[index],
                            departure: departures[index],
                            arival: arivals[index],
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
  final String title, text, images, departure, arival;

  TravelCard({this.departure, this.text, this.arival, this.title, this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 249, 1),
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
                          title,
                          textScaleFactor: 1.2,
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
                            FaIcon(
                              FontAwesomeIcons.planeDeparture,
                              color: Colors.indigo[100],
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                departure,
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Colors.indigo[100]),
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
                              color: Colors.indigo[100],
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                arival,
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Colors.indigo[100]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: SizedBox(
                          width: 200.0,
                          child: Text(text,
                              textScaleFactor: 0.7,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: Colors.grey)),
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
