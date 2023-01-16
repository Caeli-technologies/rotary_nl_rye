// 🐦 Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/features/programs/presentation/pages/information/long_term_exchange.dart';

import '../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class Top3CountriesPage extends StatefulWidget {
  @override
  _Top3CountriesPageState createState() => _Top3CountriesPageState();
}

class _Top3CountriesPageState extends State<Top3CountriesPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Goede top 3 van landen',
      body: ListView(
        padding: EdgeInsets.only(left: 20, top: 15, right: 20),
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
                            .copyWith(fontSize: 15),
                        children: [
                      TextSpan(
                        text: '1. ',
                      ),
                      TextSpan(
                        text:
                            ' Lees in deze app de verhalen van exchange studenten',
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
                            .copyWith(fontSize: 15),
                        children: [
                      TextSpan(
                        text: '2. ',
                      ),
                      TextSpan(
                        text: ' Kijk de video: ',
                      ),
                      TextSpan(
                        text: 'Proud to be European',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LongTermExchangeProgramPage()),
                            );
                          },
                      ),
                      TextSpan(
                          text: ' (Onderaan de pagina)',
                          style: TextStyle(fontSize: 14)),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 15),
                        children: [
                      TextSpan(
                        text: '3. ',
                      ),
                      TextSpan(
                        text:
                            'Kijk op YouTube en google "Rotary Youth Exchange" dan kom je ook heel veel te weten. ',
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
