// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_view.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergency_card_item.dart';
import 'package:rotary_nl_rye/features/emergency/presentation/widgets/emergency_section.dart';
import '../../../../core/presentation/uniform_widgets/note.dart';
import '../../../../core/presentation/uniform_widgets/rotary_scaffold.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return RotaryScaffold(
        title: 'Emergency',
        returnButtonShown: false,
        body: RotaryListView(
          listTiles: [
            Text(
              '112 for ambulance, fire brigade or police:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Image(
                image: AssetImage('assets/image/112_logo.png'),
                fit: BoxFit.cover),
            EmergencySection(
              title: 'Within Rotary Youth Exchange:',
              items: [
                EmergencyCardItem(
                  name: 'Barbara Tusveld',
                  function: 'Chairperson',
                  mobileNumber: '0655128529',
                ),
                EmergencyCardItem(
                  name: 'Clasine Scheepers',
                  function: 'Inbound Coordinator',
                  mobileNumber: '0652710977',
                ),
                EmergencyCardItem(
                  name: 'Ben Mureau',
                  function: 'Insurance and Visa',
                  mobileNumber: '0651911244',
                ),
                EmergencyCardItem(
                  name: 'Hilleke van der Veer',
                  function: 'National counselor',
                  mobileNumber: '0638300427',
                ),
              ],
            ),
            EmergencySection(
              title:
                  'Confidants (not connected to Rotary) in case of f.e. sexual harassment:',
              items: [
                EmergencyCardItem(
                  name: 'Pauline Memelink',
                  function: 'Lawyer',
                  mobileNumber: '0624235624',
                  email: 'p.memelink@t-mobilethuis.nl',
                ),
                EmergencyCardItem(
                  name: 'Reinout Vriesendorp',
                  function: 'Doctor\'s office',
                  mobileNumber: '0182612676',
                  email: 'info@medischcentrumwest.org',
                ),
              ],
            ),
            Note(
              texts: [
                'Make sure you always have your present host parent\'s phone numbers and home address at hand!',
                'Also, your host parents know how to assist you in case you need to see a doctor, have to go to the hospital or visit a dentist.'
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ));
  }
}
