// @dart=2.9
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/stories/models/story.dart';
import 'package:translator/translator.dart';

import 'lang.dart';

class StoryDetails extends StatefulWidget {
  final Story story;

  StoryDetails({@required this.story});

  @override
  _StoryDetailsState createState() => _StoryDetailsState(story: story);
}

class _StoryDetailsState extends State<StoryDetails> {
  final Story story;
  final translator = GoogleTranslator();
  String localeLanguage;
  String heading;
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  _StoryDetailsState({@required this.story});

  @override
  void dispose() {
    localeLanguage = null;
    translate.clear();
    index = 0;
    translationIndex = 0; // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color foreground = Colors.red;

    if (progressPercent >= 0.8) {
      foreground = Colors.green;
    } else if (progressPercent >= 0.4) {
      foreground = Colors.orange;
    }

    Color background = foreground.withOpacity(0.2);
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
            // actions: [
            //   Container(
            //     margin: EdgeInsets.only(right: 10, top: 10),
            //     width: 40,
            //     height: 40,
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
            //     child: RawMaterialButton(
            //       onPressed: () {
            //         //
            //       },
            //       child: new FaIcon(
            //         FontAwesomeIcons.ellipsisV,
            //         color: Palette.accentColor,
            //         size: 20.0,
            //       ),
            //       shape: new CircleBorder(),
            //       elevation: 2.0,
            //       fillColor: Palette.themeShadeColor,
            //       padding: const EdgeInsets.all(5.0),
            //     ),
            //   ),
            // ],
            actions: [
              Theme(
                data: Theme.of(context).copyWith(),
                child: PopupMenuButton<int>(
                  // color: Colors.black,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.share,
                              color: Palette.lightIndigo,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("Share")
                          ],
                        )),
                    PopupMenuDivider(),
                    PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.language,
                              color: Palette.lightIndigo,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text("Translate")
                          ],
                        )),
                  ],
                  onSelected: (item) => selectedItem(context, item),
                ),
              ),
            ],
            expandedHeight: Device.height * 0.25,
            flexibleSpace: CachedNetworkImage(
              imageUrl: story.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
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
                  child: _isLoading
                      ? Center(
                          child: Stack(alignment: Alignment.center, children: [
                            Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircleProgressBar(
                                  backgroundColor: background,
                                  foregroundColor: foreground,
                                  value: this.progressPercent,
                                ),
                              ),
                            ),
                            Text("${this.progressPercent * 100}%")
                          ]),
                        )
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              (localeLanguage == null)
                                  ? (story.message[0]["heading"])
                                  : heading,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...((localeLanguage == null)
                              ? (_text(story.message[1]["body"]))
                              : translate),
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
    index = 1;
    List<Widget> list = [];
    for (Map<String, dynamic> y in x) {
      if (y['paragraph'] != null) {
        for (String a in y['paragraph']) {
          index++;
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
        index++;
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

  void translated(List x) async {
    translate.clear();
    translationIndex = 0;
    print(x.toString());
    Random random = Random();
    header(story.message[0]["heading"]);
    setState(() {
      translationIndex++;
      progressPercent = translationIndex / index;
    });

    for (Map<String, dynamic> y in x) {
      if (y['paragraph'] != null) {
        for (String a in y['paragraph']) {
          await Future.delayed(
            Duration(
              seconds: (random.nextInt(2) + 2),
            ),
          ); // to prevent triggering of google recaptcha
          String value = await trans(a);
          print('paragraph :$value');
          translate.add(
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                value,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          );
          setState(() {
            translationIndex++;
            progressPercent = translationIndex / index;
          });
          await Future.delayed(
            Duration(
              seconds: (random.nextInt(2) + 2),
            ),
          ); // to be adjusted
        }
      } else if (y['imageUrl'] != null) {
        translate.add(
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.network(y['imageUrl']),
          ),
        );
      } else if (y['videoUrl'] != null) {
        translate.add(
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: NativeVideo(url: y["videoUrl"]),
          ),
        );
      } else if (y['subHeader'] != null) {
        await Future.delayed(Duration(seconds: (random.nextInt(2) + 2)));
        String value = await trans(y['subHeader']);
        print('subHeader :$value');
        translate.add(
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        setState(() {
          translationIndex++;
          progressPercent = translationIndex / index;
        });
        await Future.delayed(Duration(seconds: (random.nextInt(2) + 2)));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("0");
        break;
      case 1:
        print('platform${Platform.localeName}');
        setState(() {
          if (localeLanguage == null) {
            if (Platform.localeName == 'zh') {
              localeLanguage = 'zh-cn';
            } else {
              localeLanguage = Platform.localeName.toString().split('_')[0];
              print('locale $localeLanguage');
            }
            _isLoading = true;
            translated(story.message[1]["body"]);
          } else {
            localeLanguage = null;
          }
        });

        // showMaterialScrollPicker(
        //   context: context,
        //   items: langs.keys.toList(),
        //   title: 'Translate',
        //   onChanged: (value) => setState(() {
        //     if (value == 'Dutch') {
        //       localeLanguage = null;
        //     } else {
        //       _isLoading = true;
        //       localeLanguage = value;
        //       translated(story.message[1]["body"]);
        //     }
        //   }),
        //   onCancelled: () => setState(() {
        //     localeLanguage = null;
        //   }),
        //   showDivider: false,
        //   selectedValue: 'Dutch',
        // );
        break;
    }
  }

  void header(String x) async {
    await Future.delayed(Duration(seconds: 2));
    heading = await trans(x);
    print('header :$heading');
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> trans(x) async {
    print('trans to $localeLanguage');
    if (langs.containsValue(localeLanguage)) {
      var y = await translator.translate(x, to: "$localeLanguage");
      return y.text;
    } else {
      var y = await translator.translate(x, to: "en");
      return y.text;
    }
  }
}
