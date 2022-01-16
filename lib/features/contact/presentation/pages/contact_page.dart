import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_nl_rye/core/presentation/pages/organization_contact_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/pages/rotex_contact_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/data/long_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/data/short_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/data/rotex_list.dart';

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            "Contact List",
            textScaleFactor: 1.7,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
//TODO  need a search function to it :)
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () {},
          //     icon: FaIcon(
          //       FontAwesomeIcons.search,
          //       color: Palette.lightIndigo,
          //     ),
          //   )
          // ],
          bottom: TabBar(
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
                child: Text("Long Term"),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text("Short Term"),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                color: Palette.themeContactTabShadeColor,
                child: Text("Rotex"),
              ),
            ],
          ),
        ),
        body: Container(
          //height: Device.height - 277,
          margin: EdgeInsets.only(left: 5, right: 5),
          child: TabBarView(children: [
            ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) => ContactListTile(
                  item: longTermOrganizationList[index],
                  contactDetailsPage: OrganizationDetails(
                      person: longTermOrganizationList[index])),
              itemCount: longTermOrganizationList.length,
            ),
            ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) => ContactListTile(
                  item: shortTermOrganizationList[index],
                  contactDetailsPage: OrganizationDetails(
                      person: shortTermOrganizationList[index])),
              itemCount: shortTermOrganizationList.length,
            ),
            ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) => RotexContactListTile(
                  item: rotexList[index],
                  rotexContactDetailsPage:
                      RotexDetails(person: rotexList[index])),
              itemCount: rotexList.length,
            ),
          ]),
        ),
      ),
    );
  }
}
