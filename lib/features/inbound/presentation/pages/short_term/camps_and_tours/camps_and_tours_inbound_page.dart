import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class CampsAndToursInboundPage extends StatefulWidget {
  @override
  _CampsAndToursInboundPageState createState() =>
      _CampsAndToursInboundPageState();
}

class _CampsAndToursInboundPageState extends State<CampsAndToursInboundPage> {
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
          'Camps & Tours Inbound',
          textScaleFactor: 1.2,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              //   child: Text(
              //     "Kandidaten \n\nWat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor jaaruitwisseling. Wereldwijd gaan er jaarlijks zo’n 8.000 studenten via Rotary op jaaruitwisseling, een hele organisatie. Wie weet ben jij komend schooljaar een van die studenten.",
              //     style: TextStyle(fontSize: 16.0),
              //   ),
              // ),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildInboundOptionRow(context, "Welcome to the Netherlands!",
              //     FontAwesomeIcons.doorOpen, WelcomeInTheNetherlandsPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildInboundOptionRow(context, "Flight and Arrival",
              //     FontAwesomeIcons.plane, FlightAndArrivalPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildInboundOptionRow(context, "Language",
              //     FontAwesomeIcons.language, LanguagePage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),

              // buildInboundOptionRow(context, "Insurance",
              //     FontAwesomeIcons.umbrella, InsurancePage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildInboundOptionRow(
              //     context, "Travel", FontAwesomeIcons.passport, TravelPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // // the end
              // SizedBox(
              //   height: 20,
              // ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildInboundOptionRow(
    BuildContext context,
    String title,
    IconData icon,
    pushTo,
  ) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            child: FaIcon(
              icon,
              color: Palette.lightIndigo,
              size: 27,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 120,
              child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
        onTap: () {
          if (pushTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          }
        },
      ),
    ));
  }
}
