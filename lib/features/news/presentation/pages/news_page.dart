import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/domain/news.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/cached_network_image.dart';
import 'package:rotary_nl_rye/features/news/presentation/pages/non_pdf_news.dart';
import 'package:rotary_nl_rye/features/news/presentation/widgets/pdf_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/entities/news.dart';
import '../../../../core/prop.dart';

class NewsPage extends StatefulWidget {
  // final News news;

// NewsPage({required this.news});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _newsBloc = NewsBloc();
  //_NewsPageState({required News news}) : _news = news;
  //final News _news;
  // List _stories = [];
  // bool _isLoading = true;

  //Fetch content from the json file
  // Future readJson(String url) async {
  //   final response = await data.getDataNews(url);
  //   //await rootBundle.loadString('assets/test/news.json');
  //   final info = await json.decode(response);
  //   setState(() {
  //     _stories = info["news"];
  //     _isLoading = false;
  //   });
  // }
  //
  // _updateNews(News news) {
  //   readJson(news.jsonUrl);
  // }

  // late List data;
  // late List<String> imageList = [];

  // Future<String> fetchDataFromApi() async {
  //   var jsonData = await http.get(Uri.parse(
  //       "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/news/new-header.json"));
  //   var fetchData = jsonDecode(jsonData.body);

  //   setState(() {
  //     data = fetchData;
  //     data.forEach((element) {
  //       imageList.add(element);
  //     });
  //   });
  //   // print(imageList);
  //   return "Success";
  // }

  @override
  initState() {
    super.initState();
    _newsBloc.getNewsData();
    _removeBadge();

    // fetchDataFromApi();
  }

  void _removeBadge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("newsBadge", 0);
    });
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
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
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      child: StreamBuilder<String>(
                          stream: _newsBloc.header,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error.toString());
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.hasData) {
                              return

                                  // CachedNetworkImageRotary(
                                  //     imageUrl: snapshot.data!);
                                  //     Image.network(
                                  //   snapshot.data!,
                                  //   fit: BoxFit.cover,
                                  // );

                                  CachedNetworkImage(
                                height: 55,
                                width: 55,
                                imageUrl: snapshot.data!,
                                //"https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/images/Informatiedag_Informatiemarkt_2021.png",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.64,
                      child: StreamBuilder<List<News>>(
                          stream: _newsBloc.news,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error.toString());
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.hasData) {
                              // print(
                              //     'snapshot has data ${snapshot.data.toString()}');
                              return ListView.builder(
                                padding: EdgeInsets.only(top: 10, bottom: 30),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () => {
                                            snapshot.data![index].isPdf
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PDFPage(
                                                                pdfUrl: snapshot
                                                                    .data![
                                                                        index]
                                                                    .pdf!,
                                                                data: snapshot
                                                                        .data![
                                                                    index])),
                                                  )
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NonPDFPage(
                                                              data: snapshot
                                                                  .data![index],
                                                            ))),
                                          },

//TODO not everything is a pdf news post. if the post contains text it needs to push to a different page where the text can be displayed.

                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: TravelCard(
                                          image: snapshot.data![index].images,
                                          title: snapshot.data![index].title,
                                          description:
                                              snapshot.data![index].description,
                                        ),
                                      ));
                                },
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )
                  ])),
        ));
  }
}

class TravelCard extends StatelessWidget {
  final String title, description, image;

  TravelCard(
      {required this.title, required this.description, required this.image});

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
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                // SizedBox(
                //     height: 120,
                //     child: ClipRRect(
                //       borderRadius: new BorderRadius.circular(14.0),
                //       child: Image.asset(image),
                //     )),
                SizedBox(
                  height: 120,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.47,
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
                          width: MediaQuery.of(context).size.width * 0.47,
                          child: Text(description,
                              textScaleFactor: 0.7,
                              maxLines: 4,
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
