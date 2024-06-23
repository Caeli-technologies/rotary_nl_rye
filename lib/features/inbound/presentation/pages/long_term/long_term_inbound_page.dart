// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/long_term/class_of/class_of.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'information/flight_and_arrival.dart';
import 'information/insurance.dart';
import 'information/language.dart';
import 'information/travel.dart';
import 'information/welcome_in_the_netherlands.dart';

class LongTermExchangeInboundPage extends StatefulWidget {
  @override
  _LongTermExchangeInboundPageState createState() =>
      _LongTermExchangeInboundPageState();
}

class _LongTermExchangeInboundPageState
    extends State<LongTermExchangeInboundPage> {
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
          'Long Term Inbound',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        children: [
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(context, 'Class of 2023-2024',
              FontAwesomeIcons.peopleGroup, ClassOfPageInbounds()),
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(context, 'Welcome to the Netherlands!',
              FontAwesomeIcons.doorOpen, WelcomeInTheNetherlandsPage()),
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(context, 'Flight and Arrival',
              FontAwesomeIcons.plane, FlightAndArrivalPage()),
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(
              context, 'Language', FontAwesomeIcons.language, LanguagePage()),
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(
              context, 'Insurance', FontAwesomeIcons.umbrella, InsurancePage()),
          Divider(
            height: 15,
            thickness: 2,
          ),
          buildInboundOptionRow(
              context, 'Travel', FontAwesomeIcons.passport, TravelPage()),
          Divider(
            height: 15,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Widget buildInboundOptionRow(
      BuildContext context, String title, IconData icon, Widget pushTo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pushTo));
      },
      child: ListTile(
        leading: FaIcon(icon, color: Palette.lightIndigo, size: 27),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 15, color: Palette.grey, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Palette.grey),
      ),
    );
  }
}
