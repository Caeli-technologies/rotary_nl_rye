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
          textScaleFactor: 1,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 15, right: 20),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Text(
              //     "AANMELDEN?",
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
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
                        text: 'Je stuurt een gezellig email bericht naar: ',
                      ),
                      TextSpan(
                        text: 'interesse@rotaryyep.nl.',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrlString(
                                'mailto:interesse@rotaryyep.nl?subject=interrese%20in%20LongTerm%20Exchange');
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
                  child: Container(
                    child: Center(
                      child: CupertinoButton.filled(
                        onPressed: () {
                          launchUrlString(
                              'mailto:interesse@rotaryyep.nl?subject=interrese%20in%20LongTerm%20Exchange');
                        },
                        child:
                            // Row(
                            //   children: <Widget>[
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 25.0),
                            //       child: FaIcon(
                            //         FontAwesomeIcons.phone,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 20.0),
                            //       child: Text(
                            //         'Call me ',
                            //         style: TextStyle(color: Colors.white, fontSize: 18.0),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            Text('Verstuur een Email'),
                      ),
                    ),
                  )),

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
