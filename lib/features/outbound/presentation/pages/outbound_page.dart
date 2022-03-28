// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'long_term/long_term_outbound_page.dart';
import 'short_term/camps_and_tours/camps_and_tours_outbound_page.dart';
import 'short_term/family_to_family/family_to_family_outbound_page.dart';

class OutboundPage extends StatefulWidget {
  @override
  _OutboundPageState createState() => _OutboundPageState();
}

class _OutboundPageState extends State<OutboundPage> {
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
          'Outbound',
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
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Kandidaten \n\nWat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor uitwisseling. Wereldwijd gaan er jaarlijks zo’n 8.000 studenten via Rotary op uitwisseling, een hele organisatie. Wie weet ben jij komend schooljaar een van die studenten.',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 40,
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
                  LongTermExchangeOutboundPage()),
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
                  // TODO not yet ready
                  // NGSEOutboundPage()
                  null),
              buildProgramOptionRow(
                  context,
                  'FAMILY TO FAMILY',
                  'Exchange between families',
                  FontAwesomeIcons.hashtag,
                  FamilyToFamilyOutboundPage()),
              buildProgramOptionRow(context, 'CAMPS & TOURS', 'Summer Camps',
                  FontAwesomeIcons.hashtag, CampsAndToursOutboundPage()),

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
          } else {
            String title = 'Comming soon';
            String message = 'This page is not yet ready';
            showMaterialDialog(
              context,
              title,
              message,
              null,
            );
          }
        },
      ),
    );
  }
}
