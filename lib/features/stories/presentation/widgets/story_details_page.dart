import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/core/translation/translate.dart';
import 'package:translator/translator.dart';

class StoryDetails extends StatefulWidget {
  @override
  _StoryDetailsState createState() => _StoryDetailsState();
  final Story story;

  StoryDetails({required this.story});
}

class _StoryDetailsState extends State<StoryDetails> {
  final translator = GoogleTranslator();
  bool isTranslating = false;
  String heading = "Placeholder";
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  bool translationSuccess = true;
  String errorMessage = "";

  @override
  void dispose() {
    isTranslating = false;
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
              Container(
                margin: EdgeInsets.only(right: 10, top: 5),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Palette.themeShadeColor,
                    borderRadius: BorderRadius.circular(40.0)),
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
                  icon: FaIcon(
                    FontAwesomeIcons.list,
                    color: Palette.accentColor,
                    size: 22.0,
                  ),
                ),
              )
            ],
            expandedHeight: Device.height * 0.25,
            flexibleSpace: CachedNetworkImage(
              imageUrl: widget.story.image,
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
                        widget.story.country,
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
                        widget.story.name,
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
                                      widget.story.departureDate.toString(),
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
                                      widget.story.arrivalDate.toString(),
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${this.progressPercent * 100}%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "COMPLETED",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              (isTranslating)
                                  ? heading
                                  : (widget.story.message[0]["heading"]),
                              style: TextStyle(
                                  color: Palette.titleText,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...((isTranslating)
                              ? translate
                              : (_text(widget.story.message[1]['body'])))
                        ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _text(List newsBody) {
    index = 1;
    List<Widget> resultList = [];
    for (Map<String, dynamic> bodyItem in newsBody) {
      if (bodyItem['paragraph'] != null) {
        for (String text in bodyItem['paragraph']) {
          index++;
          resultList.add(paragraphItem(text: text));
        }
      } else if (bodyItem['imageUrl'] != null) {
        resultList.add(imageItem(url: bodyItem["imageUrl"]));
      } else if (bodyItem['videoUrl'] != null) {
        resultList.add(videoItem(url: bodyItem["videoUrl"]));
      } else if (bodyItem['subHeader'] != null) {
        index++;
        resultList.add(subHeaderItem(text: bodyItem["subHeader"]));
      }
    }

    return resultList;
  }

  Future<void> translated(List newsBody) async {
    translate.clear();
    translationIndex = 0;
    heading = await header(widget.story.message[0]["heading"]);
    setState(() {
      translationIndex++;
      progressPercent = translationIndex / index;
    });

    for (Map<String, dynamic> bodyItem in newsBody) {
      if (bodyItem['paragraph'] != null) {
        for (String text in bodyItem['paragraph']) {
          final value = await Translate.text(inputText: text);
          String translation = await value['translation'];
          if (translationSuccess) {
            translationSuccess = await value['success'];
          }
          if (errorMessage == "") {
            errorMessage = await value['message'];
          }
          translate.add(paragraphItem(text: translation));
          setState(() {
            translationIndex++;
            progressPercent = translationIndex / index;
          });
        }
      } else if (bodyItem['imageUrl'] != null) {
        translate.add(imageItem(url: bodyItem['imageUrl']));
      } else if (bodyItem['videoUrl'] != null) {
        translate.add(videoItem(url: bodyItem['videoUrl']));
      } else if (bodyItem['subHeader'] != null) {
        final value = await Translate.text(inputText: bodyItem['subHeader']);
        String translation = await value['translation'];
        if (translationSuccess) {
          translationSuccess = await value['success'];
        }
        if (errorMessage == "") {
          errorMessage = await value['message'];
        }
        translate.add(subHeaderItem(text: translation));
        setState(() {
          translationIndex++;
          progressPercent = translationIndex / index;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<String> header(String text) async {
    final value = await Translate.text(inputText: text);
    final heading = value['translation'];
    if (translationSuccess) {
      translationSuccess = value['success'];
    }
    if (errorMessage == "") {
      errorMessage = value['message'];
    }

    return heading;
  }

  Widget videoItem({required String url}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: NativeVideo(url: url),
    );
  }

  Widget imageItem({required String url}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Image.network(url),
    );
  }

  Widget paragraphItem({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(color: Palette.bodyText, fontSize: 16.0),
      ),
    );
  }

  Widget subHeaderItem({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Text(
        text,
        style: TextStyle(
            color: Palette.titleText,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }
  // List<Widget> _text(List x) {
  //   print(x.toString());
  //   index = 1;
  //   List<Widget> list = [];
  //   for (Map<String, dynamic> y in x) {
  //     if (y['paragraph'] != null) {
  //       for (String a in y['paragraph']) {
  //         index++;
  //         list.add(Padding(
  //           padding: const EdgeInsets.only(top: 10.0),
  //           child: Text(
  //             a,
  //             style: TextStyle(color: Colors.black, fontSize: 16.0),
  //           ),
  //         ));
  //       }
  //     } else if (y['imageUrl'] != null) {
  //       list.add(
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10),
  //           child: Image.network(y['imageUrl']),
  //         ),
  //       );
  //     } else if (y['videoUrl'] != null) {
  //       list.add(Padding(
  //           padding: const EdgeInsets.only(top: 10.0),
  //           child: NativeVideo(url: y["videoUrl"])));
  //     } else if (y['subHeader'] != null) {
  //       index++;
  //       list.add(
  //         Padding(
  //           padding: const EdgeInsets.only(top: 25),
  //           child: Text(
  //             y['subHeader'],
  //             style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 14.0,
  //                 fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //       );
  //     }
  //   }

  //   return list;
  // }

  // void translated(List x) async {
  //   translate.clear();
  //   translationIndex = 0;
  //   print(x.toString());
  //   Random random = Random();
  //   header(story.message[0]["heading"]);
  //   setState(() {
  //     translationIndex++;
  //     progressPercent = translationIndex / index;
  //   });

  //   for (Map<String, dynamic> y in x) {
  //     if (y['paragraph'] != null) {
  //       for (String a in y['paragraph']) {
  //         await Future.delayed(
  //           Duration(
  //             seconds: (random.nextInt(2) + 2),
  //           ),
  //         ); // to prevent triggering of google recaptcha
  //         String value = await trans(a);
  //         print('paragraph :$value');
  //         translate.add(
  //           Padding(
  //             padding: const EdgeInsets.only(top: 10.0),
  //             child: Text(
  //               value,
  //               style: TextStyle(color: Colors.black, fontSize: 16.0),
  //             ),
  //           ),
  //         );
  //         setState(() {
  //           translationIndex++;
  //           progressPercent = translationIndex / index;
  //         });
  //         await Future.delayed(
  //           Duration(
  //             seconds: (random.nextInt(2) + 2),
  //           ),
  //         ); // to be adjusted
  //       }
  //     } else if (y['imageUrl'] != null) {
  //       translate.add(
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10),
  //           child: Image.network(y['imageUrl']),
  //         ),
  //       );
  //     } else if (y['videoUrl'] != null) {
  //       translate.add(
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10.0),
  //           child: NativeVideo(url: y["videoUrl"]),
  //         ),
  //       );
  //     } else if (y['subHeader'] != null) {
  //       await Future.delayed(Duration(seconds: (random.nextInt(2) + 2)));
  //       String value = await trans(y['subHeader']);
  //       print('subHeader :$value');
  //       translate.add(
  //         Padding(
  //           padding: const EdgeInsets.only(top: 25),
  //           child: Text(
  //             value,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 14.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       );
  //       setState(() {
  //         translationIndex++;
  //         progressPercent = translationIndex / index;
  //       });
  //       await Future.delayed(Duration(seconds: (random.nextInt(2) + 2)));
  //     }
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("0");
        break;
      case 1:
        print('platform${Platform.localeName}');
        setState(() {
          _isLoading = true;
          isTranslating = !isTranslating;
          FutureBuilder(
            future: translated(widget.story.message[1]["body"]),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (!translationSuccess && isTranslating) {
                print('show dialog');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      insetPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: TextButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: Palette.accentColor),
                          label: Text(
                            errorMessage,
                            style: TextStyle(color: Palette.accentColor),
                          )),
                    );
                  },
                );
              }
              return Container();
            },
          );
        });

        break;
    }
  }

  // void header(String x) async {
  //   await Future.delayed(Duration(seconds: 2));
  //   heading = await trans(x);
  //   print('header :$heading');
  //   await Future.delayed(Duration(seconds: 2));
  // }

  // Future<String> trans(x) async {
  //   print('trans to $localeLanguage');
  //   if (supportedLangs.containsValue(localeLanguage)) {
  //     var y = await translator.translate(x, to: "$localeLanguage");
  //     return y.text;
  //   } else {
  //     var y = await translator.translate(x, to: "en");
  //     return y.text;
  //   }
  // }
}
