// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class ComplyWithPage extends StatefulWidget {
  @override
  _ComplyWithPageState createState() => _ComplyWithPageState();
}

class _ComplyWithPageState extends State<ComplyWithPage> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            buildInfoText(
              'Zit je op het VMBO, HAVO of VWO dan kun je na selectie voor deze uitwisseling in aanmerking komen. Je hebt wel een Rotaryclub nodig die jou wil voordragen: een Sponsorclub. Dat betekent niet dat de club jouw kosten betaalt., maar de club is verantwoordelijk voor de terug ontvangst van een jaarkind uit het buitenland. Als jij weggaat komt er ook een buitenlandse scholier terug. Een diploma is geen vereiste om je op te geven; je kunt nl ook je schoolprogramma onderbreken. Soms is dat zelfs een voordeel. In het buitenland worden namelijk vaak strenge leeftijdsgrenzen gesteld om tot een school te worden toegelaten. En om deel te kunnen nemen aan de schoolsporten is het soms beter om nog geen diploma te hebben.',
            ),
            SizedBox(height: 10),
            buildInfoText(
              'Voor de uitzending gelden indicatieve leeftijdsgrenzen, in principe 15-18 jaar. De leeftijdsgrens geldt voor overheidsscholen, soms is er enige rek mogelijk.',
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
                'Update: 31 May 2021',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }
}
