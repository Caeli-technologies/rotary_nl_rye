// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class CountriesPreferencePage extends StatelessWidget {
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
          'Landenvoorkeur',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          Text(
            'Als je mee wilt doen aan het Family to Family programma geef je op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de landenkeuze dien je drie landen op 2 continenten op te geven. Hierbij gelden de Verenigde Staten en Canada als één bestemming. De reden hiervoor is dat we niet alle kandidaten in de VS en Canada kunnen plaatsen. Daarbij komt dat als jij de juiste instelling hebt voor een Family to Family uitwisseling het uiteindelijk niet uitmaakt naar welk land je gaat.',
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(height: 15),
          Text(
            'Kies voor Europa! Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste uitwisselingen plaats en ontstaan de mooiste vriendschappen met het voordeel dat je deze vrienden makkelijker kunt herbezoeken. De reiskosten zijn veel lager.',
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
