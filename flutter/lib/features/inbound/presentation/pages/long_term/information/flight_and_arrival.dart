// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class FlightAndArrivalPage extends StatefulWidget {
  @override
  _FlightAndArrivalPageState createState() => _FlightAndArrivalPageState();
}

class _FlightAndArrivalPageState extends State<FlightAndArrivalPage> {
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
          'Flight and Arrival',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildSectionTitle('Flight'),
          buildBulletPoint(
              'You should obtain a changeable open return airline ticket'),
          buildBulletPoint(
              'Your arrival airport is Amsterdam (Schiphol) Airport'),
          SizedBox(height: 25),
          buildSectionTitle('Arrival'),
          SizedBox(height: 30),
          buildRotaryImage(),
          buildUpdateText(),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Padding buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Text(
        title,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\u2022', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildRotaryImage() {
    return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Center(
          child: Image.asset(
            'assets/image/rotary_blue.png',
            height: 55.0,
          ),
        ));
  }

  Padding buildUpdateText() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: Text(
          'Update: 31 May 2021',
          style: TextStyle(color: Color(0xFF777777)),
        ),
      ),
    );
  }
}
