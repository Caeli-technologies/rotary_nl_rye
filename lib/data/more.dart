// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/views/prop.dart';

// ignore: must_be_immutable
class More extends StatelessWidget {
  String country, name, text1, text2, image;
  int arrivalDate, departureDate;

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
  final String image, name, country, text1, text2;
  final int arrivalDate, departureDate;

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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Palette.themeShadeColor,
              child: Container(
                height: Device.height * 0.3,
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
                            color: Palette.accentColor,
                            size: 30.0,
                          ),
                          shape: new CircleBorder(),
                          elevation: 2.0,
                          fillColor: Palette.themeShadeColor,
                          padding: const EdgeInsets.all(5.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Palette.themeShadeColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 40, top: 20),
                    child: Text(
                      country,
                      textScaleFactor: 2,
                      style: TextStyle(
                        color: Palette.indigo,
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
                        color: Palette.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 40, top: 15, right: 40, bottom: 20),
                        child: Wrap(
                          runSpacing: 15.0,
                          spacing: 30.0,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: FaIcon(
                                  FontAwesomeIcons.planeDeparture,
                                  color: Palette.lightIndigo,
                                )),
                                WidgetSpan(
                                    child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10, bottom: 3.6),
                                  child: Text(
                                    Device.convert(departureDate),
                                    textScaleFactor: 1.2,
                                    style:
                                        TextStyle(color: Palette.lightIndigo),
                                  ),
                                ))
                              ]),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                    child: FaIcon(
                                  FontAwesomeIcons.planeArrival,
                                  color: Palette.lightIndigo,
                                )),
                                WidgetSpan(
                                    child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10, bottom: 3.6),
                                  child: Text(
                                    Device.convert(arrivalDate),
                                    textScaleFactor: 1.2,
                                    style:
                                        TextStyle(color: Palette.lightIndigo),
                                  ),
                                ))
                              ]),
                            ),
                          ],
                        ))),
              ]),
            ),
            Center(
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
                          color: Palette.lightIndigo),
                      unselectedLabelColor: Palette.lightIndigo,
                      labelColor: Palette.accentColor,
                      indicatorColor: Colors.transparent,
                      labelStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}
