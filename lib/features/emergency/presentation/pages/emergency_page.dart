// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergency_card_item.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: MediaQuery.of(context).platformBrightness,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Emergency',
            textScaler: TextScaler.linear(1.7),
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          // padding: const EdgeInsets.only(top: 60),
          padding: EdgeInsets.only(left: 16, top: 5, right: 16),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '112 for ambulance, fire brigade or police:',
                style: TextStyle(
                    color: Palette.titleText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Image(
                  image: AssetImage('assets/image/112_logo.png'),
                  fit: BoxFit.cover),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Neem direct contact op met Inbound coördinator en daaronder de Outbound coördinatoren:',
                style: TextStyle(
                  color: Palette.bodyText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            EmergencyCardItem(
              title: 'Patty van Vierzen',
              function: 'Inbound Coordinator',
              mobileNumber: '06 34 02 14 03',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),
            EmergencyCardItem(
              title: 'Toon ter Ellen',
              function: 'Inbound Coordinator',
              mobileNumber: '06 13 60 29 87',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),
            EmergencyCardItem(
              title: 'Marga Oosterveld',
              function: 'Outbound Coordinator',
              mobileNumber: '06 29 58 68 13',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),
            EmergencyCardItem(
              title: 'Judith Siebring',
              function: 'Outbound Coordinator',
              mobileNumber: '06 52 68 22 75',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Within Rotary Youth Exchange:',
                style: TextStyle(
                  color: Palette.bodyText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            EmergencyCardItem(
              title: 'Barbara Tusveld',
              function: 'Chair exchange program',
              mobileNumber: '06 55 12 85 29',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),
            EmergencyCardItem(
              title: 'Clasine Scheepers',
              function: 'Secretary Board',
              mobileNumber: '06 52 71 09 77',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),

            EmergencyCardItem(
              title: 'Hilleke van der Veer',
              function: 'National counselor',
              mobileNumber: '06 38 30 04 27',
              icon: FontAwesomeIcons.phone,
              index: 0,
            ),

            // Confidants (not connected to Rotary) in case of f.e. sexual harassment:
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Confidants (not connected to Rotary) in case of f.e. sexual harassment, Police could also be notified in case of breaking a law:',
                style: TextStyle(
                  color: Palette.bodyText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            EmergencyCardItem(
              title: 'Pauline Memelink',
              function: 'Lawyer',
              mobileNumber: '06 24 23 56 24',
              email: 'p.memelink@t-mobilethuis.nl',
              icon: FontAwesomeIcons.phone,
              index: 1,
            ),
            EmergencyCardItem(
              title: 'Reinout Vriesendorp',
              function: 'Doctor\'s office',
              mobileNumber: '0182 612 676',
              email: 'info@medischcentrumwest.org',
              icon: FontAwesomeIcons.phone,
              index: 1,
            ),

            //
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Note:',
                style: TextStyle(
                  color: Palette.bodyText,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '- Make sure you always have your present host parent\'s phone numbers and home address at hand!',
                style: TextStyle(color: Palette.bodyText, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '- Also, your host parents know how to assist you in case you need to see a doctor, have to go to the hospital or visit a dentist.',
                style: TextStyle(color: Palette.bodyText, fontSize: 14.0),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
