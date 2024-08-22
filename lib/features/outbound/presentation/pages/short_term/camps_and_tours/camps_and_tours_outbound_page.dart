// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'information/comply_with.dart';
import 'information/how_to_sign_up.dart';
import 'information/which_countries.dart';
import 'widgets/loadCsv.dart';

class CampsAndToursOutboundPage extends StatefulWidget {
  @override
  _CampsAndToursOutboundPageState createState() =>
      _CampsAndToursOutboundPageState();
}

class _CampsAndToursOutboundPageState extends State<CampsAndToursOutboundPage> {
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
          'Camps & Tours',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: SelectableText(
              'Kandidaten \n\nWat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor uitwisseling. Wereldwijd gaan er jaarlijks zo’n 8.000 studenten via Rotary op jaaruitwisseling, een hele organisatie. Wie weet ben jij komend schooljaar een van die studenten.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Divider(height: 15, thickness: 2),
          buildOutboundOptionRow(context, 'Hoe schrijf ik mezelf in',
              FontAwesomeIcons.pencil, HowToSignUpPage()),
          Divider(height: 15, thickness: 2),
          buildOutboundOptionRow(context, 'Voor wie?',
              FontAwesomeIcons.exclamation, ComplyWithPage()),
          Divider(height: 15, thickness: 2),
          buildOutboundOptionRow(context, 'Met welke landen?',
              FontAwesomeIcons.earthEurope, WhichCountriesPage()),
          Divider(height: 15, thickness: 2),
          buildOutboundOptionRow(
              context, 'Landen Lijst', FontAwesomeIcons.list, LoadCsv()),
          Divider(height: 15, thickness: 2),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  GestureDetector buildOutboundOptionRow(
      BuildContext context, String title, IconData icon, Widget pushTo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pushTo),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
        child: ListTile(
          leading: FaIcon(
            icon,
            color: Palette.lightIndigo,
            size: 27,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: Device.width - 120,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Palette.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
