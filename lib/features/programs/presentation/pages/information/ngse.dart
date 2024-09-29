// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class NGSEProgramPage extends StatefulWidget {
  @override
  _NGSEProgramPageState createState() => _NGSEProgramPageState();
}

class _NGSEProgramPageState extends State<NGSEProgramPage> {
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
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildSectionTitle('NGSE: Op zoek naar een stage of werkervaring?'),
          buildParagraph(
              'Op zoek naar een (internationale) stage of werkervaring? Rotary NGSE kan je helpen!'),
          buildParagraph(
              'Het vinden van een passende (internationale) stage binnen je studie valt vaak niet mee. Contacten via je opleiding zijn er weinig of passen niet in het beeld van een stage die jij voor je ziet. Ook leads via familie of vrienden kosten veel tijd maar leveren niet altijd op wat jij hoopt.'),
          buildParagraph(
              'Het wereldwijde netwerk van Rotary kan jou helpen – sinds een aantal jaren heeft Rotary de New Generations Service Exchange (NGSE) opgericht. Een programma gericht op jou als student of als werkzoekende die wel wat aanvulling op zijn/haar cv kan gebruiken. Ben je tussen de 18 en 30 jaar dan kun je je hiervoor aanmelden. De duur van een stage of werkervaring kan variëren - bij internationale stages buiten Europa geldt een duur van drie maanden voor een stage dit i.v.m. het visum. Bij andere stages kan dit variëren afhankelijk van jouw ideeën en die van de Rotary hostclub (ontvangende club).'),
          SizedBox(height: 20),
          buildImage('assets/image/RPFYA.png'),
          buildSectionTitle('AANMELDEN - UITZENDEN EN ONTVANGEN'),
          buildParagraphWithLink(
              'Op de site van Rotary International kun je nog meer info over NGSE vinden: ',
              'https://www.rotary.org/en/our-programs/new-generations-service-exchange'),
          buildSectionTitle('KOSTEN'),
          buildParagraph(
              'Enerzijds verwachten we van jou dat je jouw hostclub helpt met hun (service) projecten tijdens jouw stage bij hen. Zo leer jij hen en zij jou kennen. Hier kunnen mooie verdere contacten uit ontstaan.'),
          buildParagraph(
              'Deelname aan het NGSE programma kost in totaal €150,- ex BTW. De kosten voor reis, visum, inentingen, studie en verzekeringen zijn voor eigen rekening.'),
          buildParagraphWithLink(
              'Wil je meer weten of heb je vragen wat NGSE voor jou kan doen? Stuur een mailtje naar ',
              'interesse@rotaryyep.nl'),
          buildSectionTitle('Testimonies'),
          buildTestimony(
              'Tara Higgins: “When we travel, this amazing thing happens. We let down our guard. You’re constantly exposed to new experiences and new people. I’m so grateful for Rotary for allowing me to experience that.” Tara spent eight weeks in Ireland visiting a number of classrooms to improve her skills as a teacher.'),
          buildTestimony(
              'James Kolasinski: “The experience was beyond what I could have ever hoped for: Not only was the breadth of work experience completely unexpected, the hospitality I experienced was second to none.” James spent a month in Texas, USA, as a medical student in order to better understand international health care systems.'),
          buildEndSection(),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title, {double fontSize = 14.0}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget buildParagraphWithLink(String text, String link) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            TextSpan(
              text: link,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blue,
                  decoration: TextDecoration.underline),
              recognizer: TapGestureRecognizer()
                ..onTap = () => launchUrl(Uri.parse(link)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTestimony(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        text,
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 14.0,
            color: Colors.grey[700]),
      ),
    );
  }

  Widget buildImage(String path) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Image.asset(
        path,
        height: 200.0,
      ),
    );
  }

  Widget buildEndSection() {
    return Column(
      children: <Widget>[
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
              'Update: 29 september 2024',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
