// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';

// ignore: must_be_immutable
class StoryDetails extends StatelessWidget {
  final Story story;

  StoryDetails({@required this.story});

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      story: story,
    );
  }
}

class MainContainer extends StatelessWidget {
  final Story story;

  MainContainer({@required this.story});

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
              story.imageUrl,
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
                        story.country,
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
                        story.name,
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
                                      story.departureDate.toString(),
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
                                      story.arrivalDate.toString(),
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
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        story.message[0]["heading"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ..._text(story.message[1]["body"])
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _text(List x) {
    print(x.toString());

    List<Widget> list = [];
    for (Map<String, dynamic> y in x) {
      if (y['paragraph'] != null) {
        for (String a in y['paragraph']) {
          list.add(Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              a,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ));
        }
      } else if (y['imageUrl'] != null) {
        list.add(
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.network(y['imageUrl']),
          ),
        );
      } else if (y['videoUrl'] != null) {
        list.add(Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: NativeVideo(url: y["videoUrl"])));
      } else if (y['subHeader'] != null) {
        list.add(
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              y['subHeader'],
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    }

    return list;
  }
}
