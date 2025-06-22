// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'information/camps_tours.dart';
import 'information/family_to_family.dart';
import 'information/long_term_exchange.dart';
import 'promo/podcast_page.dart';
import 'promo/video_page.dart';

class ProgramPage extends StatelessWidget {
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
          textScaler: TextScaler.linear(1.7),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          _buildHeader('Interesse?'),
          _buildText(
              'Wil je:\n- Andere culturen leren?\n- Een andere taal leren,\n- Vrienden krijgen over de hele wereld\n- Ambasseur van Nederland zijn voor Rotary\n'
              '\n'
              'Ben je tussen 15 en 18½ jaar oud op het moment van vertrek. Sociaal en avontuurlijk, flexibel en klaar om het bekende achter je te laten en nieuwe dingen te ontdekken? '
              'Dan zit je bij ons goed! Met de steun van Rotary kunnen gemiddeld meer dan 40 jongeren deelnemen aan de jaarlijkse uitwisseling en ruim 50 jongeren aan onze zomerkampen en korte uitwisselingen.'
              'Ben je ouder maakt niet uit. Met de New Generation Service Exchange kun je deelnemen tussen de 18 en 30 jaar.'),
          _buildRichText(context),
          SizedBox(height: 10),
          _buildSectionHeader('Promo'),
          Divider(height: 15, thickness: 2),
          _buildProgramOptionRow(context, 'Podcast', 'For everyone',
              FontAwesomeIcons.hashtag, PodcastPage()),
          _buildProgramOptionRow(context, 'Video', 'For everyone',
              FontAwesomeIcons.hashtag, VideoPage()),
          SizedBox(height: 20),
          _buildSectionHeader('Long Term Exchange Program'),
          Divider(height: 15, thickness: 2),
          _buildProgramOptionRow(
              context,
              'Long Term Exchange Program',
              'Year Exchange',
              FontAwesomeIcons.hashtag,
              LongTermExchangeProgramPage()),
          SizedBox(height: 10),
          _buildSectionHeader('Short Term Exchange Program'),
          Divider(height: 15, thickness: 2),
          _buildProgramOptionRow(
              context,
              'FAMILY TO FAMILY',
              'Exchange between families',
              FontAwesomeIcons.hashtag,
              FamilyToFamilyProgramPage()),
          _buildProgramOptionRow(context, 'CAMPS & TOURS', 'Summer Camps',
              FontAwesomeIcons.hashtag, CampsAndToursProgramPage()),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(
            color: Palette.titleText,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(color: Palette.bodyText, fontSize: 14.0),
      ),
    );
  }

  Widget _buildRichText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
          text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
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
    );
  }

  Widget _buildSectionHeader(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildProgramOptionRow(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget pushTo,
  ) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CachedNetworkImage(
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
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  inherit: true,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    inherit: true,
                    fontSize: 14.0,
                    color: Palette.descriptionText,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pushTo),
          );
        },
      ),
    );
  }
}
