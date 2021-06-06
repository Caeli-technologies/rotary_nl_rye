import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/circle_progress_bar.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/lang.dart';
import 'package:translator/translator.dart';

class NonPDFPage extends StatefulWidget {
  @override
  _NonPDFPageState createState() => _NonPDFPageState();
  final Map<String, dynamic> data;

  NonPDFPage({required this.data});
}

class _NonPDFPageState extends State<NonPDFPage> {
  final translator = GoogleTranslator();
  String? localeLanguage;
  String? heading;
  List<Widget> translate = [];
  bool _isLoading = false;
  double progressPercent = 0;
  int index = 0;
  int translationIndex = 0;

  void dispose() {
    localeLanguage = null;
    translate.clear();
    index = 0;
    translationIndex = 0; // TODO: implement dispose

    // TODO: implement dispose

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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
              child: RawMaterialButton(
                onPressed: () {
                  // code :)
                  setState(() {
                    if (localeLanguage == null) {
                      if (Platform.localeName.toString().split('_')[0] ==
                          'zh') {
                        localeLanguage = 'zh-cn';
                      } else {
                        localeLanguage =
                            Platform.localeName.toString().split('_')[0];
                        print('locale $localeLanguage');
                      }
                      _isLoading = true;
                      translated(widget.data['text'][1]["body"]);
                    } else {
                      localeLanguage = null;
                    }
                  });
                },
                child: new FaIcon(
                  FontAwesomeIcons.language,
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
          title: Text(
            widget.data["title"],
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
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        (localeLanguage == null)
                            ? (widget.data["text"][0]["heading"])
                            : heading,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...((localeLanguage == null)
                        ? (_text(widget.data["text"][1]['body']))
                        : translate)
                  ],
                ),
              ) // NativeVideo(url: "https://www.youtube.com/watch?v=ClpPvpbYBpY"),
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
    header(widget.data['text'][0]["heading"]);
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
