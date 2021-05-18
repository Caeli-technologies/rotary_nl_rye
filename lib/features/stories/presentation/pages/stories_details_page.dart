// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

// ignore: must_be_immutable
class StoriesDetails extends StatelessWidget {
  String country, name, text1, text2, image;
  int arrivalDate, departureDate;

  StoriesDetails(
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            leading: Container(
              margin: EdgeInsets.only(left: 10, top: 10),
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
            expandedHeight: Device.height * 0.25,
            flexibleSpace: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          )
        ],
        body: Container(
          child: Column(
            children: <Widget>[
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
                      padding: EdgeInsets.only(left: 40, top: 30),
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
                    alignment: Alignment.topLeft,
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
                              left: 40, top: 15, right: 40, bottom: 10),
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

              //TODO, the text and images all on one scroll page that's going up when you go up.

              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                  child: ListView(children: [Text(text1)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
