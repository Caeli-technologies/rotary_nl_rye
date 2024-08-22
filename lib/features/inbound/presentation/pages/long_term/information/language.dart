// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
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
          'Language',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        children: <Widget>[
          buildContentText(
              'There’s no hiding it: Dutch is a very difficult language to learn. However, we do expect you to master the language and that within months after your arrival you will be fluent in our language. The MDJC will organize a DOC (Dutch Orientation Course) in September for the August group and one in February for the newbies. It will last 6 days and the program will focus on learning the Dutch language and will also give you an insight into our culture. You will work in small groups. Your fellow students will be all the other exchange students, so lots of fun included.'),
          buildContentText(
              'Your first host family will also help you to learn Dutch and you will receive books to start learning the language as soon as you are in the Netherlands.'),
          buildRotaryImage(),
          buildUpdateText(),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Padding buildContentText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
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
