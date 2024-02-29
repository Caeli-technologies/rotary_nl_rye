// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

// 📦 Package imports:
import 'package:csv/csv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/outbound/presentation/pages/short_term/camps_and_tours/widgets/pdf_viewer.dart';

class LoadCsv extends StatefulWidget {
  @override
  _LoadCsvState createState() => _LoadCsvState();
}

class _LoadCsvState extends State<LoadCsv> {
  late Future<List<List<dynamic>>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getData();
  }

  Future<List<List<dynamic>>> getData() async {
    final response = await http.get(
        Uri.parse(
            'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/outbounds/camps-and-tours/zomerkampen.csv'),
        headers: {'Content-Type': 'application/json', 'Charset': 'utf-8'});
    if (response.statusCode == 200) {
      return CsvToListConverter(eol: '\r\n', fieldDelimiter: ';')
          .convert(response.body);
    } else {
      throw Exception('Failed to load CSV data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent, // iOS
          statusBarBrightness: Brightness.light, // Android
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Camps & Tours List',
            textScaler: TextScaler.linear(1.2),
            style:
                TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder<List<List<dynamic>>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Placeholder widget like a loading spinner
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (index == 0) return SizedBox.shrink(); // Skip header
                return TravelCard(
                  startDate: snapshot.data![index][0].toString(),
                  endDate: snapshot.data![index][1].toString(),
                  title: snapshot.data![index][2].toString(),
                  hostCountryCode: snapshot.data![index][3].toString(),
                  hostCountry: snapshot.data![index][4].toString(),
                  hostDistrict: snapshot.data![index][5].toString(),
                  ageMin: snapshot.data![index][6].toString(),
                  ageMax: snapshot.data![index][7].toString(),
                  contribution: snapshot.data![index][8].toString(),
                  invitation: snapshot.data![index][9].toString(),
                  full: snapshot.data![index][10].toString(),
                );
              },
            );
          } else {
            return SizedBox.shrink(); // Fallback placeholder
          }
        },
      ),
    );
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
      invitation,
      full;

  const TravelCard({
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
    required this.full,
  });

  @override
  Widget build(BuildContext context) {
    List<String> hostCountries = hostCountry.split('/');
    List<String> hostCountryCodes = hostCountryCode.split('/');

    return GestureDetector(
        onTap: () {
          print('Tapped on: $title');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFPageViewer(
                title: title,
                pdfURL: invitation,
              ),
            ),
          );
        },
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(8.0),
          color: Palette.themeShadeColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (full.isNotEmpty) // Check if 'full' is not empty
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        margin: const EdgeInsets.only(
                            right:
                                8.0), // Add some space between the "FULL" label and the title
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'FULL',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    Expanded(
                      // Use Expanded to ensure the title can take up the remaining space
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Palette.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                // if (full.isNotEmpty)
                //   Align(
                //     alignment: Alignment.topRight,
                //     child: Container(
                //       padding: const EdgeInsets.all(6.0),
                //       decoration: BoxDecoration(
                //         color: Colors.red,
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //       child: Text(
                //         'FULL',
                //         style: TextStyle(
                //             color: Colors.white, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // Text(
                //   title,
                //   style: TextStyle(
                //     color: Palette.indigo,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //   ),
                // ),
                SizedBox(height: 10),
                buildInfoRow(
                    context, 'Host Country: ', hostCountries, hostCountryCodes),
                SizedBox(height: 10),
                buildSimpleInfoRow('Host District: ', hostDistrict,
                    FontAwesomeIcons.locationDot),
                SizedBox(height: 10),
                buildSimpleInfoRow('Age Range: ', '$ageMin - $ageMax years',
                    FontAwesomeIcons.cakeCandles),
                SizedBox(height: 10),
                buildSimpleInfoRow(
                    'Contribution: ', contribution, FontAwesomeIcons.euroSign),
                SizedBox(height: 10),
                buildSimpleInfoRow('Date: ', '$startDate - $endDate',
                    FontAwesomeIcons.calendarDays),
              ],
            ),
          ),
        ));
  }

  Widget buildInfoRow(BuildContext context, String label, List<String> values,
      List<String> codes) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(FontAwesomeIcons.solidFlag, size: 16, color: Palette.lightIndigo),
        SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  color: Palette.indigo, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Aligns the flags to the right
            children: [
              for (int i = 0; i < codes.length; i++)
                Row(
                  children: [
                    if (i > 0) ...[
                      // Adds a separator if there's more than one flag
                      SizedBox(width: 10),
                      Text('/',
                          style: TextStyle(
                              color: Palette.indigo,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                    ],
                    SvgPicture.asset(
                      'assets/icons/flags/${codes[i]}.svg',
                      width: 30,
                      height: 20,
                    ),
                    SizedBox(width: 5),
                    Text(values[i], style: TextStyle(color: Palette.indigo)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSimpleInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Palette.lightIndigo),
        SizedBox(width: 8),
        Text(label,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              style: TextStyle(color: Palette.indigo)),
        ),
      ],
    );
  }
}
