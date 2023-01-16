// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:

import '../../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class CountriesPreferencePage extends StatefulWidget {
  @override
  _CountriesPreferencePageState createState() =>
      _CountriesPreferencePageState();
}

class _CountriesPreferencePageState extends State<CountriesPreferencePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Landenvoorkeur',
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 15, right: 20),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Als je mee wilt doen aan het Family to Family programma geef je op of je voor het noordelijk of zuidelijk halfrond gaat. Bij de landenkeuze dien je drie landen op 2 continenten op te geven. Hierbij gelden de Verenigde Staten en Canada als één bestemming. De reden hiervoor is dat we niet alle kandidaten in de VS en Canada kunnen plaatsen. Daarbij komt dat als jij de juiste instelling hebt voor een Family to Family uitwisseling het uiteindelijk niet uitmaakt naar welk land je gaat.',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'Kies voor Europa! Binnen Europa, ook al ligt dit naast de deur, vinden de mooiste uitwisselingen plaats en ontstaan de mooiste vriendschappen met het voordeel dat je deze vrienden makkelijker kunt herbezoeken. De reiskosten zijn veel lager.',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "Voorbeeld vragen:",
              //     style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "- Wat betekent volgens jou het zijn van Ambassadeur voor Rotary",
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "- Wie is je rolmodel, voor wie heb je bewondering",
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "- Wat was de gelukkigste/mooiste dag in je leven",
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "- Op welke eigenschap ben je het meest trots",
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Text(
              //     "- Wat denk je dat het moeilijkste is als je een jaar in het buitenland bent",
              //     style: TextStyle(fontSize: 14.0),
              //   ),
              // ),

              // the end dont touch XD
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Image.asset(
                    'assets/image/rotary_blue.png',
                    height: 55.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Center(
                  child: Text(
                    'Update: 8 Sep 2021',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
