// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/pages/organization_contact_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/pages/rotex_contact_details_page.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/data/MDJC.dart';
import 'package:rotary_nl_rye/features/contact/data/long_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/data/rotex_list.dart';
import 'package:rotary_nl_rye/features/contact/data/short_term_organization_list.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/rotex.dart';
import 'package:rotary_nl_rye/features/widgets/list_tiles.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: MediaQuery.of(context).platformBrightness,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            'Contact List',
            style: TextStyle(
              color: Palette.indigo,
              fontWeight: FontWeight.bold,
              fontSize: 24, // Adjusted for readability
            ),
          ),
          bottom: TabBar(
            labelColor: Palette.selectedLabelColor,
            unselectedLabelColor: Palette.unselectedLabelColor,
            indicatorWeight: 4.0,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4.0,
                color: Color(0xff0081ff),
              ),
            ),
            tabs: const [
              Tab(text: 'MDJC'),
              Tab(text: 'Long Term'),
              Tab(text: 'Short Term'),
              Tab(text: 'Rotex'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: TabBarView(
            children: [
              _buildContactList(
                  mdjcList, (item) => OrganizationDetails(person: item)),
              _buildContactList(longTermOrganizationList,
                  (item) => OrganizationDetails(person: item)),
              _buildContactList(shortTermOrganizationList,
                  (item) => OrganizationDetails(person: item)),
              _buildContactList(
                  rotexList, (item) => RotexDetails(person: item)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactList(
      List<dynamic> list, Widget Function(dynamic) detailsPageBuilder) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        if (item is Organization) {
          return ContactListTile(
            item: item,
            contactDetailsPage: detailsPageBuilder(item),
          );
        } else if (item is Rotex) {
          return RotexContactListTile(
            item: item,
            rotexContactDetailsPage: detailsPageBuilder(item),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
