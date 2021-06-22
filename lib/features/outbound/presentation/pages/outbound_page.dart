import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import 'long_term/long_term_outbound_page.dart';
import 'short_term/camps_and_tours/camps_and_tours_outbound_page.dart';
import 'short_term/family_to_family/family_to_family_outbound_page.dart';
import 'short_term/ngse/ngse_outbound_page.dart';

class OutboundPage extends StatefulWidget {
  @override
  _OutboundPageState createState() => _OutboundPageState();
}

class _OutboundPageState extends State<OutboundPage> {
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
          "Outbound",
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
                  "Kandidaten \n\nWat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor jaaruitwisseling. Wereldwijd gaan er jaarlijks zo’n 8.000 studenten via Rotary op jaaruitwisseling, een hele organisatie. Wie weet ben jij komend schooljaar een van die studenten.",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 40,
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
                  LongTermExchangeOutboundPage()),
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
                  "NGSE",
                  "New Generations Service Exchange",
                  FontAwesomeIcons.hashtag,
                  NGSEOutboundPage()),
              buildProgramOptionRow(
                  context,
                  "FAMILY TO FAMILY",
                  "Exchange between families",
                  FontAwesomeIcons.hashtag,
                  FamilyToFamilyOutboundPage()),
              buildProgramOptionRow(context, "CAMPS & TOURS", "Summer Camps",
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
                "https://www.rotary.org/sites/all/themes/rotary_rotaryorg/images/favicons/favicon-194x194.png",
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
