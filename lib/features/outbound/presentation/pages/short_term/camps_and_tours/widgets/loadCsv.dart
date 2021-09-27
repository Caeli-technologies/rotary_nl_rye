import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;

import 'package:csv/csv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/short_term/camps_and_tours/widgets/pdf_viewer.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class LoadCsv extends StatefulWidget {
  @override
  _LoadCsvState createState() => _LoadCsvState();
}

class _LoadCsvState extends State<LoadCsv> {
  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/csv/Book1.csv");
    List<List<dynamic>> _listData = CsvToListConverter(
      fieldDelimiter: ";",
    ).convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCSV();
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
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
          "Camps & Tours Excel List",
          textScaleFactor: 1.2,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 30),
          itemCount: _data.length,
          itemBuilder: (_, index) {
            if (index == 0) {
              // return the header
              return SizedBox.shrink();
            }
            return GestureDetector(
                onTap: () {
                  print("number " + _data[index][8].toString());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PDFPageViewer(
                              pdfURL: _data[index][9].toString(),
                            )),
                  );
                  // needs to go to the pdf
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TravelCard(
                    number: _data[index][0].toString(),
                    date: _data[index][1].toString(),
                    title: _data[index][2].toString(),
                    hostCountryCode: _data[index][3].toString(),
                    hostCountry: _data[index][4].toString(),
                    hostDistrict: _data[index][5].toString(),
                    ageMin: _data[index][6].toString(),
                    ageMax: _data[index][7].toString(),
                    contribution: _data[index][8].toString(),
                    invitation: _data[index][9].toString(),
                  ),
                ));
          },
        ),
      ),
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.refresh), onPressed: _loadCSV),
    );
  }
}

class TravelCard extends StatelessWidget {
  final String number,
      date,
      title,
      hostCountryCode,
      hostCountry,
      hostDistrict,
      ageMin,
      ageMax,
      contribution,
      invitation;

  TravelCard({
    required this.number,
    required this.date,
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
          height: 170,
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
                          width: MediaQuery.of(context).size.width * 0.9,
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
                // Container(
                //   width: 50,
                //   //MediaQuery.of(context).size.width * 0.20,
                //   height: 50,
                //   child: CachedNetworkImage(
                //     imageUrl:
                //         "https://www.rotary.nl/.uc/i5b0088f50102d3db2b009f6ba7034db105b0994f3df50701c454018c0080/kdgxncq9fap2y1r7femelq.jpg",
                //     imageBuilder: (context, imageProvider) => Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(14),
                //         image: DecorationImage(
                //             image: imageProvider, fit: BoxFit.cover),
                //       ),
                //     ),
                //     placeholder: (context, url) =>
                //         Center(child: CircularProgressIndicator()),
                //     errorWidget: (context, url, error) => Icon(Icons.error),
                //   ),
                // ),
                SizedBox(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 11),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/flags/$hostCountryCode.svg",
                                    height: 20,
                                    width: 50,
                                    fit: BoxFit.contain,
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
                              margin: EdgeInsets.only(left: 28),
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
                      // Container(
                      //   padding: EdgeInsets.only(left: 10, top: 10),
                      //   child: Row(
                      //     children: <Widget>[
                      //       // FaIcon(
                      //       //   FontAwesomeIcons.clock,
                      //       //   color: Palette.lightIndigo,
                      //       //   size: 15,
                      //       // ),
                      //       SvgPicture.asset(
                      //         "assets/icons/flags/$hostCountryCode.svg",
                      //         height: 20,
                      //         width: 50,
                      //         fit: BoxFit.contain,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 10),
                      //         child: Text(
                      //           hostCountry,
                      //           textScaleFactor: 1.2,
                      //           style: TextStyle(
                      //             color: Palette.indigo,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
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
                            Container(
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
                      // Container(
                      //   padding: EdgeInsets.only(left: 20, top: 8),
                      //   child: Row(
                      //     children: <Widget>[
                      //       FaIcon(
                      //         FontAwesomeIcons.thumbtack,
                      //         color: Palette.lightIndigo,
                      //         size: 20,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 17),
                      //         child: Text(
                      //           'Host District: ' + hostDistrict,
                      //           textScaleFactor: 1.2,
                      //           style: TextStyle(
                      //             color: Palette.indigo,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 19, top: 6),
                      //   child: Row(
                      //     children: <Widget>[
                      //       FaIcon(
                      //         FontAwesomeIcons.birthdayCake,
                      //         color: Palette.lightIndigo,
                      //         size: 20,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 15, top: 2),
                      //         child: Text(
                      //           'Min - Max: ' +
                      //               ageMin +
                      //               ' - ' +
                      //               ageMax +
                      //               " Years",
                      //           textScaleFactor: 1.2,
                      //           style: TextStyle(
                      //             color: Palette.indigo,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 19),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.birthdayCake,
                                    color: Palette.lightIndigo,
                                    size: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 17),
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
                              margin: EdgeInsets.only(left: 59),
                              child: Text(
                                ageMin + ' - ' + ageMax + " Years",
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
                                    margin: EdgeInsets.only(left: 17),
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
                              margin: EdgeInsets.only(left: 39),
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
                      // Container(
                      //   padding: EdgeInsets.only(left: 21, top: 6),
                      //   child: Row(
                      //     children: <Widget>[
                      //       FaIcon(
                      //         FontAwesomeIcons.euroSign,
                      //         color: Palette.lightIndigo,
                      //         size: 20,
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 18, top: 2),
                      //         child: Text(
                      //           'Contribution: ' + contribution,
                      //           textScaleFactor: 1.2,
                      //           style: TextStyle(
                      //             color: Palette.indigo,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
