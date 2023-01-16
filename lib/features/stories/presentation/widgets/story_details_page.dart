// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:translator/translator.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import '../../../../core/presentation/uniform_widgets/back_button.dart';
import '../../../../core/translation/translate.dart';

// ignore: import_of_legacy_library_into_null_safe

class StoryDetails extends StatefulWidget {
  @override
  _StoryDetailsState createState() => _StoryDetailsState();
  final Story story;
  final String name, imageUrl, country;

  StoryDetails(
      {required this.story,
      required this.name,
      required this.imageUrl,
      required this.country});
}

class _StoryDetailsState extends State<StoryDetails> {
  final translator = GoogleTranslator();
  bool isTranslating = false;
  String heading = 'Placeholder';
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  bool translationSuccess = true;
  String errorMessage = '';

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
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            systemOverlayStyle:
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light,
            leading: UniformBackButton(),
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
                            Text('Share')
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
                            Text('Translate')
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
                  decoration: BoxDecoration(
                      color: Palette.themeShadeColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            child: Container(
                              width: 150,
                              height: 7,
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.story.title,
                              textScaleFactor: 1.5,
                              style: TextStyle(
                                color: Palette.indigo,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                height: 50,
                                width: 50,
                                imageUrl: widget.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.name,
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: Palette.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(widget.country,
                                      textScaleFactor: 1.1,
                                      style:
                                          TextStyle(color: Palette.lightIndigo))
                                ],
                              )
                            ],
                          ),
                        ]),
                  )),

              //TODO, the text and images all on one scroll page that's going up when you go up.

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: _isLoading
                      ? Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularPercentIndicator(
                                animation: true,
                                animateFromLastPercent: true,
                                radius: 60.0,
                                lineWidth: 5.0,
                                percent: this.progressPercent,
                                center: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${(this.progressPercent * 100).round()}%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'COMPLETED',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                progressColor: Colors.green,
                              )
                            ],
                          ),
                        )
                      : ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(
                              (isTranslating)
                                  ? heading
                                  : (widget.story.message[0]['heading']),
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
        resultList.add(imageItem(url: bodyItem['imageUrl']));
      } else if (bodyItem['videoUrl'] != null) {
        resultList.add(videoItem(url: bodyItem['videoUrl']));
      } else if (bodyItem['subHeader'] != null) {
        index++;
        resultList.add(subHeaderItem(text: bodyItem['subHeader']));
      }
    }

    return resultList;
  }

  Future<void> translated(List newsBody) async {
    translate.clear();
    translationIndex = 0;
    heading = await header(widget.story.message[0]['heading']);
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
          if (errorMessage == '') {
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
        if (errorMessage == '') {
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
    if (errorMessage == '') {
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

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print('0');
        break;
      case 1:
        print('platform${Platform.localeName}');
        setState(() {
          _isLoading = true;
          isTranslating = !isTranslating;
          FutureBuilder(
            future: translated(widget.story.message[1]['body']),
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
}
