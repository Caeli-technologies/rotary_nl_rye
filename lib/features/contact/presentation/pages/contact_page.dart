// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/organization_contact_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/pages/rotex_contact_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_list_tile.dart';
import 'package:rotary_nl_rye/core/presentation/uniform_widgets/rotary_scaffold.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/data/MDJC.dart';
import 'package:rotary_nl_rye/features/contact/data/long_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/data/rotex_list.dart';
import 'package:rotary_nl_rye/features/contact/data/short_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';

import '../../../../core/presentation/uniform_widgets/rotary_list_view.dart';
import '../../../../core/presentation/uniform_widgets/uniform_circle_avatar.dart';
import '../widgets/contact_list_view.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

//TODO needs to look like the story page. nut then only for contacts of the organication and Rotex (https://rotex.org/who-we-are/)
class _ContactPageState extends State<ContactPage> {
  @override
  initState() {
    super.initState();
    Future.wait([
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/icons/custom/rotary-logo-icon.svg'),
        null,
      ),
      precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            'assets/icons/custom/rotex_logo_light.svg'),
        null,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: RotaryScaffold(
        title: 'Contact List',
        returnButtonShown: false,
        /*bottom: TabBar(
            labelColor: Palette.selectedlabelColor,
            unselectedLabelColor: Palette.unselectedLabelColor,
            indicatorPadding: EdgeInsets.all(0.0),
            indicatorWeight: 4.0,
            labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            indicator: ShapeDecoration(
                shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                        style: BorderStyle.solid)),
                gradient: LinearGradient(
                    colors: [Color(0xff0081ff), Color(0xff01ff80)])),
            tabs: <Widget>[
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text('MDJC'),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text('Long Term'),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text('Short Term'),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text('Rotex'),
              ),
            ],
          ),*/
        body: TabBarView(
          children: [
            ContactListView(
              contacts: mdjcList,
              context: context,
            ),
            ContactListView(
              contacts: longTermOrganizationList,
              context: context,
            ),
            ContactListView(
              contacts: shortTermOrganizationList,
              context: context,
            ),
            ContactListView(
              contacts: rotexList,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
