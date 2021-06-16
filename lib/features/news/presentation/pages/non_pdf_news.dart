import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/core/translation/translate.dart';
import 'package:rotary_nl_rye/features/news/models/news.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NonPDFPage extends StatefulWidget {
  @override
  _NonPDFPageState createState() => _NonPDFPageState();
  final News data;

  NonPDFPage({required this.data});
}

class _NonPDFPageState extends State<NonPDFPage> {
  bool isTranslating = false;
  String heading = "Placeholder";
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  bool translationSuccess = true;
  String errorMessage = "";

  String? _linkMessage;
  bool _isCreatingLink = false;
  String? id;

  void dispose() {
    isTranslating = false;
    translate.clear();
    removeBadge();
    index = 0;
    translationIndex = 0; // TODO: implement dispose
    _linkMessage;

    // TODO: implement dispose

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._createDynamicLink(id = widget.data.id.toString());
    removeBadge();
  }

  removeBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove('newsBadge');
    });
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
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
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10, top: 5),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Palette.themeShadeColor,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Platform.localeName == 'NL'
                  ? PopupMenuButton<int>(
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
                      ],
                      onSelected: (item) => selectedItem(context, item),
                    )
                  : PopupMenuButton<int>(
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
            ),
          ],
          title: Text(
            widget.data.title,
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: _isLoading
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
                          "${(this.progressPercent * 100).round()}%",
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
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        (isTranslating)
                            ? heading
                            : (widget.data.text![0]["heading"]),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...((isTranslating)
                        ? translate
                        : (_text(widget.data.text![1]['body'])))
                  ],
                ),
              ) // NativeVideo(url: "https://www.youtube.com/watch?v=ClpPvpbYBpY"),
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
    heading = await header(widget.data.text![0]["heading"]);
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
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
    );
  }

  Widget subHeaderItem({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> selectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        _createDynamicLink(
            id = widget.data.id.toString()); //TODO add the parameters here

        if (await canLaunch(_linkMessage!)) {
          await Share.share(
              Platform.isIOS
                  ? 'Hier moet nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage' // iOS
                  : 'Hier moet nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage',
              //android
              subject: 'look at this nice app :)');
        } else {
          throw 'Could not launch $_linkMessage';
        }

        break;
      case 1:
        print('platform${Platform.localeName}');
        setState(() {
          _isLoading = true;
          isTranslating = !isTranslating;
          FutureBuilder(
            future: translated(widget.data.text![1]["body"]),
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

  Future<void> _createDynamicLink(String id) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rotarytestnl.page.link',
      link: Uri.parse(
          'https://rotarytestnl.page.link/news?id=$id'), //change this to the url in the main.dart
      androidParameters: AndroidParameters(
        packageName: 'com.caelitechnologies.rotary_nl_rye',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.caelitechnologies.rotary-nl-rye',
        minimumVersion: '1.0.0',
        appStoreId: '1567096118',
      ),
      // socialMetaTagParameters: SocialMetaTagParameters(
      //   title: 'Example of a Dynamic Link',
      //   description: 'This link works whether app is installed or not!',
      //   imageUrl: Uri.parse(
      //       'https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/6e/21/e4/6e21e45b-49cb-fa52-83c2-bb56ab288b49/AppIcon-0-0-1x_U007emarketing-0-0-0-4-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.jpeg/1200x630wa.png'),
      // ),
    );

    Uri url;
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }
}
