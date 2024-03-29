// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
// import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/forRotaryClubs/presentation/pages/InfoCounselor/InfoCounselor.dart';
import 'package:rotary_nl_rye/features/forRotaryClubs/presentation/pages/InfoGastgezin/InfoGastgezin.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'AlgemeneInformatie/algemeneInfo.dart';
import 'Jeugdcommissaris/jeugd_commissaris.dart';
import 'belangrijkeDocumenten/important_documents.dart';

class ForRotaryClubsPage extends StatefulWidget {
  @override
  _ForRotaryClubsPageState createState() => _ForRotaryClubsPageState();
}

class _ForRotaryClubsPageState extends State<ForRotaryClubsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: UniformBackButton(),
        title: Text('voor Rotary Clubs',
            textScaler: TextScaler.linear(1.2),
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          final List<OptionRowData> options = [
            OptionRowData('Algemene Informatie', FontAwesomeIcons.info,
                AlgemeneInfoPage()),
            OptionRowData('Info voor de Jeugdcommissaris',
                FontAwesomeIcons.solidUser, InfoForJeugdcommissarisPage()),
            OptionRowData('Info Gastgezin', FontAwesomeIcons.peopleRoof,
                InfoGastgezinPage()),
            OptionRowData('Info Counselor', FontAwesomeIcons.handsHoldingChild,
                InfoCounselorPage()),
            OptionRowData('Belangrijke Documenten',
                FontAwesomeIcons.triangleExclamation, ImportantDocumentsPage()),
          ];

          return Column(
            children: [
              if (index == 0)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Text(
                    'Wat leuk dat jullie als Rotary club van plan zijn om een jaarstudent te sponsoren en daarmee dus ook een jaar lang een kind binnen jullie club te ontvangen en te begeleiden. Misschien zijn jullie benaderd door een scholier van buiten jullie of mogelijk vanuit de wens van één van jullie clubleden.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              Divider(height: 20, thickness: 2),
              buildInboundOptionRow(context, options[index]),
            ],
          );
        },
      ),
    );
  }

  GestureDetector buildInboundOptionRow(
      BuildContext context, OptionRowData data) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => data.pushTo)),
      child: ListTile(
        leading: FaIcon(data.icon, color: Palette.lightIndigo, size: 27),
        title: Text(data.title,
            style: TextStyle(
                fontSize: 15,
                color: Palette.grey,
                fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, color: Palette.grey),
      ),
    );
  }
}

class OptionRowData {
  final String title;
  final IconData icon;
  final Widget pushTo;

  OptionRowData(this.title, this.icon, this.pushTo);
}
