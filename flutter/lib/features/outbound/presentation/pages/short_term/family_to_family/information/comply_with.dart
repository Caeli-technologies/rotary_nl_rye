// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ComplyWithPage extends StatelessWidget {
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
          'Waar moet ik aan voldoen?',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          Text(
            'Alle jongens en meisjes in de leeftijd van 15 t/m 19* jaar, die open staan voor anderen, van hen willen leren, met hen ervaringen willen uitwisselen, die uit hun eigen vertrouwde omgeving willen stappen en die anderen zonder vooroordelen willen ontmoeten zijn geschikt om aan dit programma deel te nemen.',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(height: 30),
          Center(
            child: Image.asset(
              'assets/image/rotary_blue.png',
              height: 55.0,
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Update: 8 Sep 2021',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
