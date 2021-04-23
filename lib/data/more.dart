// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rotary_nl_rye/views/stories.dart';

class More extends StatelessWidget {
  String title, image;
  double rating;

  More({this.title, this.image, this.rating});

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      title: title,
      rating: rating,
      image: image,
    );
  }
}

class MainContainer extends StatelessWidget {
  final String title, image;
  final double rating;

  MainContainer({this.title, this.image, this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Color.fromRGBO(247, 247, 249, 1),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      )),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30, top: 40),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0)),
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: new Icon(
                              Icons.arrow_back,
                              color: Color.fromRGBO(57, 182, 245, 1),
                              size: 30.0,
                            ),
                            shape: new CircleBorder(),
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: const EdgeInsets.all(5.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 247, 249, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 40, top: 20),
                        child: Text(
                          title,
                          textScaleFactor: 2,
                          style: TextStyle(
                            color: Color.fromRGBO(19, 33, 70, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 40, top: 15, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.red,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    rating.toString(),
                                    textScaleFactor: 1.2,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.planeDeparture,
                                  color: Colors.indigo[100],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "2 jam",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(color: Colors.indigo[100]),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.planeArrival,
                                  color: Colors.indigo[100],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "2 jam",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(color: Colors.indigo[100]),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: DefaultTabController(
                  length: 2,
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
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        tabs: [
                          Container(height: 30, child: Tab(text: "City 1")),
                          Container(
                              height: 30,
                              child: Tab(
                                text: "City 2",
                              )),
                        ],
                      ),
                      Container(
                        constraints:
                            BoxConstraints(minHeight: 100, minWidth: 100),
                        height: 400,
                        margin: EdgeInsets.only(left: 20, top: 5, right: 20),
                        child: TabBarView(children: [
                          ListView(children: [
                            Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lectus quam id leo in vitae. Tellus at urna condimentum mattis pellentesque id nibh tortor id. Vitae auctor eu augue ut lectus. Non diam phasellus vestibulum lorem sed. Amet justo donec enim diam. Posuere morbi leo urna molestie at. Pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Neque vitae tempus quam pellentesque nec. Blandit aliquam etiam erat velit scelerisque. Aliquam faucibus purus in massa tempor nec feugiat. Nunc vel risus commodo viverra maecenas. Phasellus vestibulum lorem sed risus ultricies tristique nulla aliquet. A lacus vestibulum sed arcu. Eu feugiat pretium nibh ipsum. Pharetra sit amet aliquam id diam maecenas. Augue mauris augue neque gravida in fermentum et sollicitudin. Diam in arcu cursus euismod quis viverra nibh cras pulvinar. Viverra adipiscing at in tellus integer feugiat scelerisque varius morbi. Sit amet commodo nulla facilisi nullam vehicula ipsum a. Lacus laoreet non curabitur gravida arcu ac tortor dignissim. Purus semper eget duis at tellus. Et netus et malesuada fames. Imperdiet sed euismod nisi porta lorem mollis aliquam. Tempus egestas sed sed risus pretium quam vulputate dignissim. Nulla facilisi cras fermentum odio eu feugiat pretium nibh."),
                          ]),
                          Center(
                            child: Text("Text Description"),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
