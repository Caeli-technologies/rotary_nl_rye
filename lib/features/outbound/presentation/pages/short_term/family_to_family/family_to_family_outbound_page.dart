// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'information/comply_with.dart';
import 'information/countries_preference.dart';
import 'information/how_to_sign_up.dart';

class FamilyToFamilyOutboundPage extends StatefulWidget {
  @override
  _FamilyToFamilyOutboundPageState createState() =>
      _FamilyToFamilyOutboundPageState();
}

class _FamilyToFamilyOutboundPageState
    extends State<FamilyToFamilyOutboundPage> {
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
          'Family to Family',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Kandidaten \n\nWat leuk dat je geïnteresseerd in de mogelijkheden van Rotary voor uitwisseling. Wereldwijd gaan er jaarlijks zo’n 8.000 studenten via Rotary op jaaruitwisseling, een hele organisatie.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20),
              Divider(height: 15, thickness: 2),
              _buildOutboundOptionRow(context, 'Hoe schrijf ik mezelf in',
                  FontAwesomeIcons.pencil, HowToSignUpPage()),
              Divider(height: 15, thickness: 2),
              _buildOutboundOptionRow(context, 'Waar moet ik aan voldoen',
                  FontAwesomeIcons.exclamation, ComplyWithPage()),
              Divider(height: 15, thickness: 2),
              _buildOutboundOptionRow(context, 'Landenvoorkeur',
                  FontAwesomeIcons.flag, CountriesPreferencePage()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOutboundOptionRow(
    BuildContext context,
    String title,
    IconData icon,
    Widget pushTo,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pushTo),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        leading: FaIcon(icon, color: Palette.lightIndigo, size: 27),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Palette.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Palette.grey),
      ),
    );
  }
}
