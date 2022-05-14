// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'information/camps_tours.dart';
import 'information/family_to_family.dart';
import 'information/long_term_exchange.dart';
import 'information/ngse.dart';
import 'information/video_page.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
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
          'Programs',
          textScaleFactor: 1,
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
                  'Interesse?',
                  style: TextStyle(
                      color: Palette.titleText,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Wil je:',
                  style: TextStyle(
                      color: Palette.bodyText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  '- Andere culturen leren?',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  '- Een andere taal leren,',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  '- Vrienden krijgen over de hele wereld',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  '- Ambasseur van Nederland zijn voor Rotary',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Ben je tussen 15 en 18½ jaar oud op het moment van vertrek. \nSociaal en avontuurlijk, flexibel en klaar om het bekende achter je te laten en nieuwe dingen te ontdekken?',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Dan zit je bij ons goed! Met de steun van Rotary kunnen gemiddeld meer dan 40 jongeren deelnemen aan de jaarlijkse uitwisseling en ruim 50 jongeren aan onze zomerkampen en korte uitwisselingen.',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  'Ben je ouder maakt niet uit. Met de New Generation Service Exchange kun je deelnemen tussen de 18 en 30 jaar.',
                  style: TextStyle(color: Palette.bodyText, fontSize: 13.0),
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
                            launchUrlString('mailto:interesse@rotaryyep.nl');
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
                    'Promo Video ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildProgramOptionRow(context, 'Promo Video', 'For everyone',
                  FontAwesomeIcons.hashtag, VideoPage()),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Long Term Exchange Program',
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
                  'Long Term Exchange Program',
                  'Year Exchange',
                  FontAwesomeIcons.hashtag,
                  LongTermExchangeProgramPage()),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Short Term Exchange Program',
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
                  'NGSE',
                  'New Generations Service Exchange',
                  FontAwesomeIcons.hashtag,
                  NGSEProgramPage()),
              buildProgramOptionRow(
                  context,
                  'FAMILY TO FAMILY',
                  'Exchange between families',
                  FontAwesomeIcons.hashtag,
                  FamilyToFamilyProgramPage()),
              buildProgramOptionRow(context, 'CAMPS & TOURS', 'Summer Camps',
                  FontAwesomeIcons.hashtag, CampsAndToursProgramPage()),

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
              child: CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl:
                'https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
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
                        inherit: true,
                        fontSize: 14.0,
                        color: Palette.descriptionText)),
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
