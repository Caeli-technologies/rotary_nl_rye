// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
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
          centerTitle: false,
          title: Text(
            DemoLocalizations.of(context)!.trans('questionTitle'),
            textScaleFactor: 1.7,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          //padding: const EdgeInsets.only(top: 60),
          children: <Widget>[
            //TODO add FAQ

            // QuestionCardItem(
            //     icon: FontAwesomeIcons.question,
            //     title: "Expansion Title",
            //     subtitle: "  Sub Title's",
            //     cardTitle: "In Children use can use any flutter Widget",
            //     cardText:
            //         "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
            // QuestionCardItem(
            //     icon: FontAwesomeIcons.question,
            //     title: "Expansion Title",
            //     subtitle: "  Sub Title's",
            //     cardTitle: "In Children use can use any flutter Widget",
            //     cardText:
            //         "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
            // QuestionCardItem(
            //     icon: FontAwesomeIcons.question,
            //     title: "Expansion Title",
            //     subtitle: "  Sub Title's",
            //     cardTitle: "In Children use can use any flutter Widget",
            //     cardText:
            //         "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
            // QuestionCardItem(
            //     icon: FontAwesomeIcons.question,
            //     title: "Expansion Title",
            //     subtitle: "  Sub Title's",
            //     cardTitle: "In Children use can use any flutter Widget",
            //     cardText:
            //         "Children Widgets are expanded/ visible when Expansion Tile Widget is Clicked"),
            // the end
            SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
