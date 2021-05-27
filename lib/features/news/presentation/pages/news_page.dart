// @dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';

import '../../../../core/prop.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List _stories = [];

  // Fetch content from the json file
  Future readJson() async {
    final String response =
        await rootBundle.loadString('assets/test/news.json');
    final data = await json.decode(response);
    setState(() {
      _stories = data["news"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
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
            "News",
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(shrinkWrap: true, children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/image/homepage/Informatiedag_Informatiemarkt_2021.png",
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  height: Device.height - 300,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: _stories.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return GestureDetector(
                          onTap: () => {
                            _stories[index]["isPdf"] == "yes"
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PDFPage(
                                            pdfUrl: _stories[index]["pdf"])),
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NonPDFPage(
                                              data: _stories[index],
                                            ))),
                          },

//TODO not everything is a pdf news post. if the post contains text it needs to push to a different page where the text can be displayed.

                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TravelCard(
                              image: _stories[index]["images"],
                              title: _stories[index]["title"],
                              description: _stories[index]["description"],
                            ),
                          ),
                        );
                      }),
                )
              ])),
        ));
  }
}

class TravelCard extends StatelessWidget {
  final String title, description, image;

  TravelCard({this.title, this.description, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.themeShadeColor,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: SizedBox(
          height: 120,
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(14.0),
                      child: Image.asset(image),
                    )),
                SizedBox(
                  height: 120,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: SizedBox(
                          width: Device.width - 240,
                          child: Text(title,
                              textScaleFactor: 1.2,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: Palette.indigo,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: SizedBox(
                          width: Device.width - 240,
                          child: Text(description,
                              textScaleFactor: 0.7,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: Palette.grey)),
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
