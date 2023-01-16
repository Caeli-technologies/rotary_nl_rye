// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:

import '../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Travel',
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text:
                            'There’s no hiding it: Dutch is a very difficult language to learn. However, we do expect you to master the language and that within months after your arrival you will be fluent in our language. The MDJC will organize a DOC (Dutch Orientation Course) in September for the August group and one in Februari for the newbies. It will last 6 days and the program will focus on learning the Dutch language and will also give you an insight into our culture. You will work in small groups. Your fellow students will be all the other exchange students, so lots of fun included.',
                      ),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                        children: [
                      TextSpan(
                        text:
                            'Your first host family will also help you to learn Dutch and you will receive books to start learning the language as soon as you are in the Netherlands.',
                      ),
                    ])),
              ),
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
                    'Update: 31 May 2021',
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
