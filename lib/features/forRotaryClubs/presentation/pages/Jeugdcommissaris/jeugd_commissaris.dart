// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

class InfoForJeugdcommissarisPage extends StatefulWidget {
  @override
  _InfoForJeugdcommissarisPageState createState() =>
      _InfoForJeugdcommissarisPageState();
}

class _InfoForJeugdcommissarisPageState
    extends State<InfoForJeugdcommissarisPage> {
  final List<Map<String, dynamic>> infoOptions = [
    {
      'title': 'Handboek Jeugdcommissaris',
      'icon': FontAwesomeIcons.book,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/handboek-jeugdcommissaris-versie-2024-2025-def.pdf'),
    },
    {
      'title': 'Document huisbezoek',
      'icon': FontAwesomeIcons.personWalkingLuggage,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/huisbezoek-gastgezinnen-24-25-def.pdf'),
    },
    {
      'title': 'Verzamelformulier VOG gegevens',
      'icon': FontAwesomeIcons.passport,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/formulier-aanlevering-vog-aanvragen-2022-2023.pdf'),
    },
    {
      'title': 'Verklaring Jeugd Vrijwilliger (VJV)',
      'icon': FontAwesomeIcons.handsHoldingChild,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/verklaring-jeugd-vrijwilliger-met-addendum-okt22-def.pdf'),
    },
    {
      'title': 'Presentielijst DJC training',
      'icon': FontAwesomeIcons.euroSign,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/presentielijst-training-clubs-gastouders-24-25.pdf'),
    },
    {
      'title': 'Schooldocument',
      'icon': FontAwesomeIcons.school,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/rotary-exchange-voor-middelbare-scholen-2022-2023.pdf'),
    },
    {
      'title': 'Actielijst voorbereiding komst Jaarkind',
      'icon': FontAwesomeIcons.clipboardList,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2023/actielijst-rotary-clubs-2023-2024-voorbereiding-ontvangst-inbound-student-def-1.pdf'),
    },
    {
      'title': 'Rules and Information Inbounds',
      'icon': FontAwesomeIcons.scaleUnbalanced,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/24-25rules-and-information-for-inbound-exchange-students-to-the-netherlands.pdf'),
    },
    {
      'title': 'Reis Regels',
      'icon': FontAwesomeIcons.personWalkingLuggage,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/travel-rules-within-and-outside-the-netherlands-2024-2025.pdf'),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: MediaQuery.of(context).platformBrightness,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: UniformBackButton(),
        title: Text('Info Jeugdcommissaris',
            textScaler: TextScaler.linear(1),
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: infoOptions.length,
        itemBuilder: (context, index) {
          final option = infoOptions[index];
          return Column(
            children: [
              ListTile(
                leading: FaIcon(option['icon'], color: Palette.lightIndigo),
                title: Text(option['title'],
                    style: TextStyle(color: Palette.grey)),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => option['page'])),
                trailing: Icon(Icons.arrow_forward_ios, color: Palette.grey),
              ),
              Divider(height: 20, thickness: 2),
            ],
          );
        },
      ),
    );
  }
}
