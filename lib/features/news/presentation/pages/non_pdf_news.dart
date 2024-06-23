// 🐦 Flutter imports:
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/news.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/core/translation/translate.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class NonPDFPage extends StatefulWidget {
  final News data;

  NonPDFPage({required this.data});

  @override
  _NonPDFPageState createState() => _NonPDFPageState();
}

class _NonPDFPageState extends State<NonPDFPage> {
  bool isTranslating = false;
  String heading = 'Placeholder';
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  bool translationSuccess = true;
  String errorMessage = '';

  String? _linkMessage;
  String? id;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void dispose() {
    super.dispose();
    isTranslating = false;
    translate.clear();
    index = 0;
    translationIndex = 0;
    _linkMessage = null;
  }

  @override
  void initState() {
    super.initState();
    _createDynamicLink(id = widget.data.id.toString());
    _removeBadge();
  }

  void _removeBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('newsBadge', 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: MediaQuery.of(context).platformBrightness,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Palette.themeShadeColor,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.share,
                          color: Palette.lightIndigo,
                        ),
                        const SizedBox(width: 7),
                        Text('Share')
                      ],
                    )),
                if (Platform.localeName != 'NL') PopupMenuDivider(),
                if (Platform.localeName != 'NL')
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.language,
                            color: Palette.lightIndigo,
                          ),
                          const SizedBox(width: 7),
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
          ),
        ],
        title: Text(
          widget.data.title,
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    radius: 80.0,
                    lineWidth: 8.0,
                    percent: this.progressPercent,
                    center: Column(
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
                          : (widget.data.text![0]['heading']),
                      style: TextStyle(
                          color: Palette.titleText,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...((isTranslating)
                      ? translate
                      : (_text(widget.data.text![1]['body']))),
                ],
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
      } else if (bodyItem['pdfUrl'] != null) {
        resultList.add(pdfButton(pdfUrl: bodyItem['pdfUrl']));
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
    heading = await header(widget.data.text![0]['heading']);
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
      } else if (bodyItem['pdfUrl'] != null) {
        translate.add(pdfButton(pdfUrl: bodyItem['pdfUrl']));
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

  Widget pdfButton({required String pdfUrl}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 30),
      child: Container(
        child: Center(
          child: CupertinoButton.filled(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PDFPage(
                          pdfUrl: pdfUrl,
                          data: widget.data,
                        )),
              );
            },
            child: Text('Open PDF'),
          ),
        ),
      ),
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

  Future<void> selectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        _createDynamicLink(id = widget.data.id.toString());

        if (await canLaunchUrlString(_linkMessage!)) {
          await Share.share(
              Platform.isIOS
                  ? 'Hier moet nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage'
                  : 'Hier moet nog een leuk stukje komen. + de link naar de juiste pagina $_linkMessage',
              subject: 'look at this nice app :)');
        } else {
          throw 'Could not launch $_linkMessage';
        }

        break;
      case 1:
        setState(() {
          _isLoading = true;
          isTranslating = !isTranslating;
          FutureBuilder(
            future: translated(widget.data.text![1]['body']),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (!translationSuccess && isTranslating) {
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
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://rotarynl.page.link',
      link: Uri.parse('https://rotarynl.page.link/news?id=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.caelitechnologies.rotary_nl_rye',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.caelitechnologies.rotary-nl-rye',
        minimumVersion: '1.0.0',
        appStoreId: '1567096118',
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLinks.buildShortLink(parameters);
    final Uri url = shortLink.shortUrl;

    setState(() {
      _linkMessage = url.toString();
    });
  }
}
