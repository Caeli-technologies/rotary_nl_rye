import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/native_video.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:video_player/video_player.dart';

class NonPDFPage extends StatefulWidget {
  @override
  _NonPDFPageState createState() => _NonPDFPageState();
  final Map<String, dynamic> data;

  NonPDFPage({required this.data});
}

class _NonPDFPageState extends State<NonPDFPage> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            widget.data["title"],
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  widget.data["text"][0]["heading"],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ..._text(widget.data["text"][1]['body'])
            ],
          ),
        ) // NativeVideo(url: "https://www.youtube.com/watch?v=ClpPvpbYBpY"),
        );
  }

  List<Widget> _text(List x) {
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
