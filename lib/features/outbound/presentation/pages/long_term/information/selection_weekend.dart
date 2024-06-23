// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class SelectionWeekendPage extends StatefulWidget {
  @override
  _SelectionWeekendPageState createState() => _SelectionWeekendPageState();
}

class _SelectionWeekendPageState extends State<SelectionWeekendPage> {
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
          'Selectie weekend',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          buildSectionTitle('Het weekend dient een aantal doelen:', Colors.red),
          buildContentRichText([
            TextSpan(text: '1. '),
            TextSpan(
                text: 'Elkaar beter leren kennen.',
                style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(
                text:
                    ' De groep leert elkaar beter kennen en wij leren jullie beter '),
            TextSpan(
                text: 'kennen.',
                style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(
                text:
                    ' Wij kunnen zó beter inschatten waar jullie als toekomstige Outbounds naar toe zouden kunnen gaan.'),
          ]),
          buildContentRichText([
            TextSpan(text: '2. '),
            TextSpan(
                text: 'Jezelf presenteren.',
                style: TextStyle(decoration: TextDecoration.underline)),
          ]),
          buildContentRichText([
            TextSpan(text: '3. '),
            TextSpan(
                text: 'Je oriënteren op een top-drie van landen',
                style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(
                text:
                    ' waarnaar je het liefst wilt worden uitgezonden. Zowel Internationaal als Europees.'),
          ]),
          buildContentRichText([
            TextSpan(text: '4. '),
            TextSpan(
                text: 'Selectie:',
                style: TextStyle(decoration: TextDecoration.underline)),
            TextSpan(
                text:
                    ' Je kunt laten zien dat je uit het goede “uitwisselingshout” bent gesneden. Aanwezigheid is verplicht. Het weekend is dan ook onderdeel van de uiteindelijke selectie.'),
          ]),
          buildContentText(
              '*Je krijgt een mail van ons voor het weekend waarin staat wat je moet meenemen, en wat je moet voorbereiden. Het is altijd een topweekend.',
              fontSize: 12.5),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Text(
        text,
        style: TextStyle(
            color: color, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContentRichText(List<TextSpan> children) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
          children: children,
        ),
      ),
    );
  }

  Widget buildContentText(String text, {double fontSize = 14.0}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
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

  @override
  void dispose() {
    super.dispose();
  }
}
