// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        title: Text(
          'Emergency',
          style: TextStyle(
            color: Palette.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const EmergencySectionTitle(
            title: '112 for ambulance, fire brigade or police:',
          ),
          const Image(
            image: AssetImage('assets/image/112_logo.png'),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const EmergencySectionTitle(
            title:
                'Neem direct contact op met Inbound coördinator en daaronder de Outbound coördinatoren:',
            underline: true,
          ),
          const EmergencyCardItem(
            title: 'Patty van Vierzen',
            function: 'Inbound Coordinator',
            mobileNumber: '06 34 02 14 03',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Toon ter Ellen',
            function: 'Inbound Coordinator',
            mobileNumber: '06 13 60 29 87',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Marga Oosterveld',
            function: 'Outbound Coordinator',
            mobileNumber: '06 29 58 68 13',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Judith Siebring',
            function: 'Outbound Coordinator',
            mobileNumber: '06 52 68 22 75',
            icon: Icons.phone,
            index: 0,
          ),
          const SizedBox(height: 20),
          const EmergencySectionTitle(
            title: 'Within Rotary Youth Exchange:',
            underline: true,
          ),
          const EmergencyCardItem(
            title: 'Barbara Tusveld',
            function: 'Chair exchange program',
            mobileNumber: '06 55 12 85 29',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Clasine Scheepers',
            function: 'Secretary Board',
            mobileNumber: '06 52 71 09 77',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Hilleke van der Veer',
            function: 'National counselor',
            mobileNumber: '06 38 30 04 27',
            icon: Icons.phone,
            index: 0,
          ),
          const EmergencyCardItem(
            title: 'Carlo ter Ellen',
            function: 'National Counselor',
            mobileNumber: '06 53 40 14 77',
            icon: Icons.phone,
            index: 0,
          ),
          const SizedBox(height: 20),
          const EmergencySectionTitle(
            title:
                'Confidants (not connected to Rotary) in case of f.e. sexual harassment, Police could also be notified in case of breaking a law:',
            underline: true,
          ),
          const EmergencyCardItem(
            title: 'Pauline Memelink',
            function: 'Lawyer',
            mobileNumber: '06 24 23 56 24',
            email: 'p.memelink@t-mobilethuis.nl',
            icon: Icons.phone,
            index: 1,
          ),
          const EmergencyCardItem(
            title: 'Reinout Vriesendorp',
            function: 'Doctor\'s office',
            mobileNumber: '0182 612 676',
            email: 'info@medischcentrumwest.org',
            icon: Icons.phone,
            index: 1,
          ),
          const SizedBox(height: 20),
          const EmergencySectionTitle(
            title: 'Note:',
            underline: true,
          ),
          const EmergencyNote(
            text:
                'Make sure you always have your present host parent\'s phone numbers and home address at hand!',
          ),
          const EmergencyNote(
            text:
                'Also, your host parents know how to assist you in case you need to see a doctor, have to go to the hospital or visit a dentist.',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class EmergencySectionTitle extends StatelessWidget {
  final String title;
  final bool underline;

  const EmergencySectionTitle({
    Key? key,
    required this.title,
    this.underline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        title,
        style: TextStyle(
          color: Palette.titleText,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}

class EmergencyNote extends StatelessWidget {
  final String text;

  const EmergencyNote({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(
          color: Palette.bodyText,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
