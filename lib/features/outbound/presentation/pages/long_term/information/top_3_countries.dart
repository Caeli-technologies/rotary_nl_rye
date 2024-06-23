// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/programs/presentation/pages/information/long_term_exchange.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class Top3CountriesPage extends StatefulWidget {
  @override
  _Top3CountriesPageState createState() => _Top3CountriesPageState();
}

class _Top3CountriesPageState extends State<Top3CountriesPage> {
  @override
  void initState() {
    super.initState();
  }

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
          'Goede top 3 van landen',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildRichTextSection(
                '1. ',
                'Lees in deze app de verhalen van exchange studenten',
              ),
              buildRichTextSection(
                '2. ',
                'Kijk de video: ',
                linkText: 'Proud to be European',
                linkAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LongTermExchangeProgramPage(),
                    ),
                  );
                },
                suffixText: ' (Onderaan de pagina)',
              ),
              buildRichTextSection(
                '3. ',
                'Kijk op YouTube en google "Rotary Youth Exchange" dan kom je ook heel veel te weten.',
              ),
              buildFooter(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildRichTextSection(String prefixText, String mainText,
      {String? linkText, VoidCallback? linkAction, String? suffixText}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
          children: [
            TextSpan(text: prefixText),
            TextSpan(text: mainText),
            if (linkText != null && linkAction != null)
              TextSpan(
                text: linkText,
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()..onTap = linkAction,
              ),
            if (suffixText != null) TextSpan(text: suffixText),
          ],
        ),
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
