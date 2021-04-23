// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class More extends StatelessWidget {
  String country, name, text1, text2, image, arrivalDate, departureDate;

  More(
      {this.country,
      this.name,
      this.text1,
      this.text2,
      this.image,
      this.arrivalDate,
      this.departureDate});

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      country: country,
      text1: text1,
      text2: text2,
      name: name,
      departureDate: departureDate,
      arrivalDate: arrivalDate,
      image: image,
    );
  }
}

class MainContainer extends StatelessWidget {
  final String image, name, country, text1, text2, arrivalDate, departureDate;

  MainContainer(
      {this.image,
      this.name,
      this.country,
      this.text1,
      this.text2,
      this.arrivalDate,
      this.departureDate});

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
                          country,
                          textScaleFactor: 2,
                          style: TextStyle(
                            color: Color.fromRGBO(19, 33, 70, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 40, top: 5),
                        child: Text(
                          name,
                          textScaleFactor: 1,
                          style: TextStyle(
                            color: Colors.grey,
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
                                  FontAwesomeIcons.planeDeparture,
                                  color: Colors.indigo[100],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    departureDate,
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
                                    arrivalDate,
                                    textScaleFactor: 1.2,
                                    style: TextStyle(color: Colors.indigo[100]),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
                        indicator: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(50), // Creates border
                            color: Colors.blue[100]),
                        unselectedLabelColor: Colors.indigo[100],
                        labelColor: Color.fromRGBO(57, 182, 245, 1),
                        indicatorColor: Colors.transparent,
                        labelStyle: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        tabs: [
                          Container(child: Tab(text: "City 1")),
                          Container(
                              child: Tab(
                            text: "City 2",
                          )),
                        ],
                        labelPadding: EdgeInsets.all(0),
                      ),
                      Container(
                        constraints:
                            BoxConstraints(minHeight: 200, minWidth: 100),
                        height: 400,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TabBarView(children: [
                          ListView(children: [Text(text1)]),
                          ListView(children: [Text(text2)])
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
