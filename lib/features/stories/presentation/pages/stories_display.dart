import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/entities/story.dart';
import 'package:rotary_nl_rye/core/domain/exchangeStudents.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_image.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/full_screen_video.dart';

import '../../../../core/prop.dart';
import '../widgets/story_details_page.dart';

class StoriesDisplay extends StatefulWidget {
  final ExchangeStudent student;

  StoriesDisplay({required this.student});

  @override
  _StoriesDisplayState createState() => _StoriesDisplayState(student: student);
}

class _StoriesDisplayState extends State<StoriesDisplay> {
  _StoriesDisplayState({required this.student});

  final storyBloc = StudentsBloc();

  // List<Story> stories = [];
  // bool _isLoading = true;
  final ExchangeStudent student;

  // Fetch content from the json file
  // Future readJson() async {
  //   // final String response =
  //   //     await rootBundle.loadString('assets/test/stories.json');
  //   final data = null; //await getDataStories(
  //   //    "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rebounds/students/${student.exchangeYear}/${student.name.replaceAll(" ", "_").toLowerCase()}.json");
  //   setState(() {
  //     if (data == null) {
  //       print('data $data');
  //       stories = [];
  //     } else {
  //       stories = data;
  //     }
  //     _isLoading = false;
  //   });
  // }

  @override
  void initState() {
    storyBloc.getStoriesList(student.exchangeYear, student.name);
    super.initState();
//    readJson();
  }

  @override
  void dispose() {
    storyBloc.disposeStory();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (student.toString() == "[]") {
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
          ),
          body: Center(
              child: Text(
                  "A problem occured. Maybe there is no data present yet")));
    }
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
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(60),
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                FullScreenImage(url: student.imageUrl)));
                      },
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        imageUrl: student.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: imageProvider),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.themeShadeColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                      ),
                      child: Column(children: <Widget>[
                        Text(
                          student.name,
                          textAlign: TextAlign.center,
                          textScaleFactor: 2,
                          style: TextStyle(
                            color: Palette.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 40, top: 10, right: 40, bottom: 10),
                                child: Wrap(
                                  runSpacing: 15.0,
                                  spacing: 30.0,
                                  children: <Widget>[
                                    Text(
                                      'Sponsor: D${student.sponsorDistrict}',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Host: D${student.hostDistrict}',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ))),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Stories",
                      textAlign: TextAlign.center,
                      textScaleFactor: 2,
                      style: TextStyle(
                        color: Palette.indigo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.57,
                      child: StreamBuilder<List<Story>>(
                          stream: storyBloc.storyList,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error.toString());
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else if (snapshot.hasData) {
                              return (snapshot.data!.length == 0)
                                  ? Center(
                                      child: Text(
                                        'No Adventures yet',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                          color: Palette.indigo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.only(top: 10),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => snapshot
                                                      .data![index].isDutchie ==
                                                  true
                                              ? Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder: (BuildContext
                                                                  context,
                                                              _,
                                                              __) =>
                                                          FullScreenVideo(
                                                              story: snapshot
                                                                      .data![
                                                                  index])))
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StoryDetails(
                                                            story: snapshot
                                                                .data![index],
                                                          )),
                                                ),
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: TravelCard(
                                                  story:
                                                      snapshot.data![index])),
                                        );
                                      });
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
  final Story story;

  TravelCard({required this.story});

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
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: story.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 12),
                        child: Text(
                          story.country,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: Palette.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.planeDeparture,
                              color: Palette.lightIndigo,
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                story.departureDate.toString(),
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Palette.lightIndigo),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.planeArrival,
                              color: Palette.lightIndigo,
                              size: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                story.arrivalDate.toString(),
                                textScaleFactor: 1.1,
                                style: TextStyle(color: Palette.lightIndigo),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(story.description,
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
