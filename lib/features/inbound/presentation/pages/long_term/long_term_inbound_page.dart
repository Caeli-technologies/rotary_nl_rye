// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/widgets/show_alert_dialog.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/presentation/pages/long_term/class_of/class_of.dart';
import '../../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';
import 'information/flight_and_arrival.dart';
import 'information/insurance.dart';
import 'information/language.dart';
import 'information/travel.dart';
import 'information/welcome_in_the_netherlands.dart';

class LongTermExchangeInboundPage extends StatefulWidget {
  @override
  _LongTermExchangeInboundPageState createState() =>
      _LongTermExchangeInboundPageState();
}

class _LongTermExchangeInboundPageState
    extends State<LongTermExchangeInboundPage> {
  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
      title: 'Long Term Inbound',
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(context, 'Class of 2022-2023',
                  FontAwesomeIcons.peopleGroup, ClassOfPageInbounds()),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(context, 'Welcome to the Netherlands!',
                  FontAwesomeIcons.doorOpen, WelcomeInTheNetherlandsPage()),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(context, 'Flight and Arrival',
                  FontAwesomeIcons.plane, FlightAndArrivalPage()),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(context, 'Language',
                  FontAwesomeIcons.language, LanguagePage()),
              Divider(
                height: 15,
                thickness: 2,
              ),

              buildInboundOptionRow(context, 'Insurance',
                  FontAwesomeIcons.umbrella, InsurancePage()),
              Divider(
                height: 15,
                thickness: 2,
              ),
              buildInboundOptionRow(
                  context, 'Travel', FontAwesomeIcons.passport, TravelPage()),
              Divider(
                height: 15,
                thickness: 2,
              ),
              // the end
              SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildInboundOptionRow(
    BuildContext context,
    String title,
    IconData icon,
    pushTo,
  ) {
    return GestureDetector(
        child: Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.zero,
          child: Container(
            child: FaIcon(
              icon,
              color: Palette.lightIndigo,
              size: 27,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: Device.width - 120,
              child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 15,
                    color: Palette.grey,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Palette.grey,
            ),
          ],
        ),
        onTap: () {
          if (pushTo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pushTo),
            );
          } else {
            String title = 'Comming soon';
            String message = 'This page is not yet ready';
            showMaterialDialog(
              context,
              title,
              message,
              null,
            );
          }
        },
      ),
    ));
  }
}
