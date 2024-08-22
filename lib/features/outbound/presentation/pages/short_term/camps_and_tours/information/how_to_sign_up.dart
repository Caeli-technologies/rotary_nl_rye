// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher_string.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class HowToSignUpPage extends StatefulWidget {
  @override
  _HowToSignUpPageState createState() => _HowToSignUpPageState();
}

class _HowToSignUpPageState extends State<HowToSignUpPage> {
  @override
  initState() {
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
          'Hoe schrijf ik mezelf in',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: RichText(
                text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14),
                    children: [
                  TextSpan(
                    text: 'Je stuurt een gezellig email bericht naar: ',
                  ),
                  TextSpan(
                    text: 'zomerkamp@rotaryyep.nl.',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrlString('mailto:zomerkamp@rotaryyep.nl');
                      },
                  ),
                  TextSpan(
                    text:
                        ' Dan krijg je van ons een bevestiging dat we je mail hebben ontvangen. ',
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 30),
            child: Center(
              child: CupertinoButton.filled(
                onPressed: () {
                  launchUrlString(
                      'mailto:interesse@rotaryyep.nl?subject=interrese%20in%20Camps%20and%20Tours');
                },
                child: Text('Verstuur een Email'),
              ),
            ),
          ),
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
