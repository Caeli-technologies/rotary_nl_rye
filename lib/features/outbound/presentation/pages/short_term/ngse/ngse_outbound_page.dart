// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class NGSEOutboundPage extends StatefulWidget {
  @override
  _NGSEOutboundPageState createState() => _NGSEOutboundPageState();
}

class _NGSEOutboundPageState extends State<NGSEOutboundPage> {
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
          'NGSE',
          textScaler: TextScaler.linear(1.2),
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
              // SizedBox(
              //   height: 20,
              // ),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(context, "Hoe schrijf ik mezelf in",
              //     FontAwesomeIcons.pencilAlt, HowToSignUpPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(context, "Waar moet ik aan voldoen",
              //     FontAwesomeIcons.exclamation, ComplyWithPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(
              //     context,
              //     "Wat moet ik doen voor de selectiedag",
              //     FontAwesomeIcons.voteYea,
              //     SelectionDayPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(
              //     context,
              //     "Wat moet ik doen voor het selectieweekend",
              //     FontAwesomeIcons.clipboardCheck,
              //     SelectionWeekendPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(
              //     context,
              //     "Hoe maak ik een goede top 3 van landen waar ik naar toe wil ",
              //     FontAwesomeIcons.globe,
              //     Top3CountriesPage()),
              // Divider(
              //   height: 15,
              //   thickness: 2,
              // ),
              // buildOutboundOptionRow(context, "Hoe bereid ik me voor",
              //     FontAwesomeIcons.suitcase, null),
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
          } else {
            String title = 'Comming soon';
            String message = 'This page is not yet ready';
            showMaterialDialog(context, title, message, null);
          }
        },
      ),
    ));
  }
}
