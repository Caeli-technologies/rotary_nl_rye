import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import 'information/long_term_exchange.dart';

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
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
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
              buildProgramOptionRow(context, "FAMILY TO FAMILY",
                  "Exchange between families", FontAwesomeIcons.hashtag, null),
              buildProgramOptionRow(context, "CAMPS & TOURS", "Summer Camps",
                  FontAwesomeIcons.hashtag, null),
              buildProgramOptionRow(
                  context,
                  "NGSE",
                  "New Generations Service Exchange",
                  FontAwesomeIcons.hashtag,
                  null),
              // the end
              SizedBox(
                height: 20,
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
