import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:url_launcher/url_launcher.dart';

import 'information/camps_tours.dart';
import 'information/family_to_family.dart';
import 'information/long_term_exchange.dart';
import 'information/ngse.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
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
          "Programs",
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Interesse?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Wil je:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "- Andere culturen leren?",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  "- Een andere taal leren,",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  "- Vrienden krijgen over de hele wereld",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  "- Ambasseur van Nederland zijn voor Rotary",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "Ben je tussen 15 en 18½ jaar oud op het moment van vertrek. \nSociaal en avontuurlijk, flexibel en klaar om het bekende achter je te laten en nieuwe dingen te ontdekken?",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "Dan zit je bij ons goed! Met de steun van Rotary kunnen gemiddeld meer dan 40 jongeren deelnemen aan de jaarlijkse uitwisseling en ruim 50 jongeren aan onze zomerkampen en korte uitwisselingen.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "Ben je ouder maakt niet uit. Met de New Generation Service Exchange kun je deelnemen tussen de 18 en 30 jaar.",
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 13),
                        children: [
                      TextSpan(
                        text:
                            'Deelname aan ons exchange programma is niet gebonden aan het Rotary clublidmaatschap van een ouder. Jongeren die willen deelnemen aan een uitwisseling kunnen zich opgeven via het emailadres: ',
                      ),
                      TextSpan(
                        text: 'interesse@rotaryyep.nl',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("mailto:interesse@rotaryyep.nl");
                          },
                      ),
                      TextSpan(
                        text:
                            ' Er is wel een selectieprocedure. Van de ouders wordt gevraagd om hun huis op te stellen om jonge buitenlanders voor minimaal 3- maanden in hun gezin op te nemen.',
                      ),
                    ])),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Promo Video ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildProgramOptionRow(context, "Promo Video", "For everyone",
                  FontAwesomeIcons.hashtag, null),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Long Term Exchange Program",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),

              buildProgramOptionRow(
                  context,
                  "Long Term Exchange Program",
                  "Year Exchange",
                  FontAwesomeIcons.hashtag,
                  LongTermExchangeProgramPage()),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Short Term Exchange Program",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildProgramOptionRow(
                  context,
                  "FAMILY TO FAMILY",
                  "Exchange between families",
                  FontAwesomeIcons.hashtag,
                  FamilyToFamilyProgramPage()),
              buildProgramOptionRow(context, "CAMPS & TOURS", "Summer Camps",
                  FontAwesomeIcons.hashtag, CampsAndToursProgramPage()),
              buildProgramOptionRow(
                  context,
                  "NGSE",
                  "New Generations Service Exchange",
                  FontAwesomeIcons.hashtag,
                  NGSEProgramPage()),
              // the end
              SizedBox(
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container buildProgramOptionRow(
    BuildContext context,
    String title,
    subtitle,
    IconData icon,
    pushTo,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png",
                    width: 50.0,
                    height: 50.0,
                  ))),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 150,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                    inherit: true, fontWeight: FontWeight.w700, fontSize: 16.0),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: Device.width - 150,
                child: Text(subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        inherit: true, fontSize: 14.0, color: Colors.black45)),
              ),
            ],
          ),
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
    );
  }
}
