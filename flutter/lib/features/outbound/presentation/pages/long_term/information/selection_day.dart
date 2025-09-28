// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class SelectionDayPage extends StatefulWidget {
  @override
  _SelectionDayPageState createState() => _SelectionDayPageState();
}

class _SelectionDayPageState extends State<SelectionDayPage> {
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
          'Selectie dag',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          buildSectionTitle('Wat moet ik doen voor de selectie dag:'),
          buildContentText('- Ik zou gewoon je best en doen en jezelf zijn.'),
          buildSectionTitle('Dit is wat je deze dag kan verwachten:'),
          buildContentText(
              '- Je krijgt een interview, een groepsgesprek, een discussie en een test over je kennis van Nederland.'),
          buildContentText(
              '- Dit zijn een paar voorbeeld vragen uit het interview tijdens de selectie dag. We gaan je niet alles vertellen, maar zo krijg je een beetje een idee.'),
          buildSectionTitle('Voorbeeld vragen:'),
          buildContentText(
              '- Wat betekent volgens jou het zijn van Ambassadeur voor Rotary'),
          buildContentText('- Wie is je rolmodel, voor wie heb je bewondering'),
          buildContentText('- Wat was de gelukkigste/mooiste dag in je leven'),
          buildContentText('- Op welke eigenschap ben je het meest trots'),
          buildContentText(
              '- Wat denk je dat het moeilijkste is als je een jaar in het buitenland bent'),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContentText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildFooter() {
    return Column(
      children: [
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
              'Update: 31 May 2021',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
