import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/prop.dart';

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
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                child: Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(context, "Hoe schrijf ik mezelf in",
                  FontAwesomeIcons.pencilAlt, null),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(context, "Waar moet ik aan voldoen",
                  FontAwesomeIcons.exclamation, null),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(
                  context,
                  "Wat moet ik doen voor de selectiedag",
                  FontAwesomeIcons.voteYea,
                  null),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(
                  context,
                  "Wat moet ik doen voor het selectieweekend",
                  FontAwesomeIcons.clipboardCheck,
                  null),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(
                  context,
                  "Hoe maak ik een goede top 3 van landen waar ik naar toe wil ",
                  FontAwesomeIcons.globe,
                  null),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildOutboundOptionRow(context, "Hoe bereid ik me voor",
                  FontAwesomeIcons.toolbox, null),
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

  GestureDetector buildOutboundOptionRow(
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
