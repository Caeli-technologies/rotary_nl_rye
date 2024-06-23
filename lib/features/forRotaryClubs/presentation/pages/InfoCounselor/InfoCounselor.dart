// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/pdf_viewer_share.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/info_list_tile.dart';

class InfoCounselorPage extends StatefulWidget {
  @override
  _InfoCounselorPageState createState() => _InfoCounselorPageState();
}

class _InfoCounselorPageState extends State<InfoCounselorPage> {
  final List<Map<String, dynamic>> infoOptions = [
    {
      'title': 'Handboek Counselor',
      'icon': FontAwesomeIcons.handsHoldingChild,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/2024/handboek-counselor-versie-2024-2025-def.pdf'),
    },
    {
      'title': 'First Night Questions',
      'icon': FontAwesomeIcons.question,
      'page': PDFPageWithShare(
          pdfUrl:
              'https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rotary-club-info/questions-first-night-host-family.pdf'),
    },
    {
      'title': 'Travel rules within and outside the Netherlands',
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
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Info Counselor',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: infoOptions.length,
        itemBuilder: (BuildContext context, int index) {
          final option = infoOptions[index];
          return InfoListTile(
            title: option['title'],
            icon: option['icon'],
            page: option['page'],
          );
        },
      ),
    );
  }
}
