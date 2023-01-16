// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

// 🌎 Project imports:

class WhichCountriesPage extends StatefulWidget {
  @override
  _WhichCountriesPageState createState() => _WhichCountriesPageState();
}

class _WhichCountriesPageState extends State<WhichCountriesPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
        title: 'Met welke landen?',
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
                child: Text(
                  'Europese landen, maar ook Canada, VS en Taiwan.',
                  style: TextStyle(fontSize: 14.0),
                ),
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
                        text: 'aanmelden via het emailadres ',
                      ),
                      TextSpan(
                        text: 'interesse@rotaryyep.nl.',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString('mailto:interesse@rotaryyep.nl');
                          },
                      )
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
