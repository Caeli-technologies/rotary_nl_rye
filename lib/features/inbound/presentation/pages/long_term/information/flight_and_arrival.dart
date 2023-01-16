// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:

import '../../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class FlightAndArrivalPage extends StatefulWidget {
  @override
  _FlightAndArrivalPageState createState() => _FlightAndArrivalPageState();
}

class _FlightAndArrivalPageState extends State<FlightAndArrivalPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Flight and Arrival',
      body: ListView(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Flight',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
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
                          text: '\u2022',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text:
                            ' You should obtain a changeable open return airline ticket',
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
                          text: '\u2022',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        text:
                            ' Your arrival airport is Amsterdam (Schiphol) Airport',
                      ),
                    ])),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  'Arrival',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
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
