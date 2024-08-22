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

class HowToSignUpPage extends StatelessWidget {
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        children: <Widget>[
          Text(
            'Je stuurt een gezellig email bericht naar:',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16),
              children: [
                TextSpan(
                  text: 'interesse@rotaryyep.nl.',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchUrlString(
                          'mailto:interesse@rotaryyep.nl?subject=interrese%20in%20F2F');
                    },
                ),
                TextSpan(
                  text:
                      ' Dan krijg je van ons een bevestiging dat we je mail hebben ontvangen.',
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: CupertinoButton.filled(
              onPressed: () {
                launchUrlString(
                    'mailto:interesse@rotaryyep.nl?subject=interrese%20in%20F2F');
              },
              child: Text('Verstuur een Email'),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Image.asset(
              'assets/image/rotary_blue.png',
              height: 55.0,
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Update: 31 May 2021',
              style: TextStyle(color: Color(0xFF777777)),
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
