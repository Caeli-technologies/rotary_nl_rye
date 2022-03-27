import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

import 'package:csv/csv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/short_term/camps_and_tours/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:skeletons/skeletons.dart';

class LoadCsv extends StatefulWidget {
  @override
  _LoadCsvState createState() => _LoadCsvState();
}

class _LoadCsvState extends State<LoadCsv> {
  List<List<dynamic>> _data = [];

  Future<List<List>?> getData() async {
    final response = await http.get(
        Uri.parse(
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen-2022.csv'),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
    try {
      if (response.statusCode == 200) {
        List<List<dynamic>> _listData = CsvToListConverter(
          eol: '\r\n',
          fieldDelimiter: ';',
        ).convert(response.body);

        setState(() {
          _data = _listData;
        });

        return _listData;
      } else {
        // ignore: null_check_always_fails
        return null!;
      }
    } catch (e) {
      // ignore: null_check_always_fails
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // getData();
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
          leading: UniformBackButton(),
          title: Text(
            'Camps & Tours List',
            textScaleFactor: 1.2,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder<List<List>?>(
            future: getData(), // async work
            builder:
                (BuildContext context, AsyncSnapshot<List<List>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SkeletonListView();
              } else {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                else
                  // return Center(child: new Text('${snapshot.data}'));  // snapshot.data  :- get your object which is pass from your downloadData() function
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 10, bottom: 30),
                    itemCount: _data.length,
                    itemBuilder: (_, index) {
                      if (index == 0) {
                        // return the header
                        return SizedBox.shrink();
                      }
                      return GestureDetector(
                          onTap: () {
                            print('title: ' +
                                snapshot.data![index][2].toString());

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFPageViewer(
                                        title:
                                            snapshot.data![index][2].toString(),
                                        pdfURL:
                                            snapshot.data![index][9].toString(),
                                      )),
                            );
                            // needs to go to the pdf
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: TravelCard(
                              startDate: snapshot.data![index][0].toString(),
                              endDate: snapshot.data![index][1].toString(),
                              title: snapshot.data![index][2].toString(),
                              hostCountryCode:
                                  snapshot.data![index][3].toString(),
                              hostCountry: snapshot.data![index][4].toString(),
                              hostDistrict: snapshot.data![index][5].toString(),
                              ageMin: snapshot.data![index][6].toString(),
                              ageMax: snapshot.data![index][7].toString(),
                              contribution: snapshot.data![index][8].toString(),
                              invitation: snapshot.data![index][9].toString(),
                            ),
                          ));
                    },
                  );
              }
            },

            // return ListView.builder(
            //   padding: EdgeInsets.only(top: 10, bottom: 30),
            //   itemCount: _data.length,
            //   itemBuilder: (_, index) {
            //     if (index == 0) {
            //       // return the header
            //       return SizedBox.shrink();
            //     }
            //     return GestureDetector(
            //         onTap: () {
            //           print("number " + _data[index][8].toString());

            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => PDFPageViewer(
            //                       pdfURL: _data[index][9].toString(),
            //                     )),
            //           );
            //           // needs to go to the pdf
            //         },
            //         child: Container(
            //           padding: EdgeInsets.only(bottom: 10),
            //           child: TravelCard(
            //             number: _data[index][0].toString(),
            //             date: _data[index][1].toString(),
            //             title: _data[index][2].toString(),
            //             hostCountryCode: _data[index][3].toString(),
            //             hostCountry: _data[index][4].toString(),
            //             hostDistrict: _data[index][5].toString(),
            //             ageMin: _data[index][6].toString(),
            //             ageMax: _data[index][7].toString(),
            //             contribution: _data[index][8].toString(),
            //             invitation: _data[index][9].toString(),
            //           ),
            //         ));
            //   },
            // );

            // return ListView.builder(
            //   padding: EdgeInsets.only(top: 10, bottom: 30),
            //   itemCount: snapshot.data.length,
            //   itemBuilder: (_, index) {
            //     if (index == 0) {
            //       // return the header
            //       return SizedBox.shrink();
            //     }
            //     return GestureDetector(
            //         onTap: () {
            //           print("number " + snapshot.data[index][8].toString());

            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => PDFPageViewer(
            //                       pdfURL: snapshot.data[index][9].toString(),
            //                     )),
            //           );
            //           // needs to go to the pdf
            //         },
            //         child: Container(
            //           padding: EdgeInsets.only(bottom: 10),
            //           child: TravelCard(
            //             number: snapshot.data[index][0].toString(),
            //             date: snapshot.data[index][1].toString(),
            //             title: snapshot.data[index][2].toString(),
            //             hostCountryCode: snapshot.data[index][3].toString(),
            //             hostCountry: snapshot.data[index][4].toString(),
            //             hostDistrict: snapshot.data[index][5].toString(),
            //             ageMin: snapshot.data[index][6].toString(),
            //             ageMax: snapshot.data[index][7].toString(),
            //             contribution: snapshot.data[index][8].toString(),
            //             invitation: snapshot.data[index][9].toString(),
            //           ),
            //         ));
            //   },
            // ),
          ),
          // floatingActionButton:
          //     FloatingActionButton(child: Icon(Icons.refresh), onPressed: _loadCSV),
        ));
  }
}

class TravelCard extends StatelessWidget {
  final String startDate,
      endDate,
      title,
      hostCountryCode,
      hostCountry,
      hostDistrict,
      ageMin,
      ageMax,
      contribution,
      invitation;

  TravelCard({
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.hostCountryCode,
    required this.hostCountry,
    required this.hostDistrict,
    required this.ageMin,
    required this.ageMax,
    required this.contribution,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Palette.themeShadeColor,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: SizedBox(
          height: hostCountryCode.contains('/') ? 230 : 200,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Container(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(title,
                              textScaleFactor: 1.1,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                color: Palette.indigo,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      hostCountryCode.contains('/')
                          ? Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: <Widget>[
                                          FaIcon(
                                            FontAwesomeIcons.solidFlag,
                                            color: Palette.lightIndigo,
                                            size: 20,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 12),
                                            child: Text(
                                              'Host Country:',
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                color: Palette.indigo,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Row(
                                        children: <Widget>[
                                          SvgPicture.asset(
                                            "assets/icons/flags/${hostCountryCode.split('/')[0]}.svg",
                                            height: 20,
                                            width: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              hostCountry.split('/')[0],
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                color: Palette.indigo,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 184),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              '/ ',
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                color: Palette.indigo,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/flags/${hostCountryCode.split('/')[1]}.svg",
                                            height: 20,
                                            width: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              hostCountry.split('/')[1],
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                color: Palette.indigo,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ])
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: <Widget>[
                                        FaIcon(
                                          FontAwesomeIcons.solidFlag,
                                          color: Palette.lightIndigo,
                                          size: 20,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 12),
                                          child: Text(
                                            'Host Country:',
                                            textScaleFactor: 1.2,
                                            style: TextStyle(
                                              color: Palette.indigo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/icons/flags/$hostCountryCode.svg',
                                          height: 20,
                                          width: 50,
                                          fit: BoxFit.contain,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            hostCountry,
                                            textScaleFactor: 1.2,
                                            style: TextStyle(
                                              color: Palette.indigo,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.thumbtack,
                                    color: Palette.lightIndigo,
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 17),
                                    child: Text(
                                      'Host District:',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            hostDistrict.contains('/')
                                ? Container(
                                    margin: EdgeInsets.only(left: 37),
                                    child: Text(
                                      hostDistrict.split('/')[0] +
                                          ' / ' +
                                          hostDistrict.split('/')[1],
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 37),
                                    child: Text(
                                      hostDistrict,
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 19),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.cakeCandles,
                                    color: Palette.lightIndigo,
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Text(
                                      'Min - Max:',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 61),
                              child: Text(
                                ageMin + ' - ' + ageMax + ' Years',
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  color: Palette.indigo,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.euroSign,
                                    color: Palette.lightIndigo,
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Contribution:',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 37),
                              child: Text(
                                contribution,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  color: Palette.indigo,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.calendarDays,
                                    color: Palette.lightIndigo,
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 14),
                                    child: Text(
                                      'Date:',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        color: Palette.indigo,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                startDate + ' - ' + endDate,
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  color: Palette.indigo,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
