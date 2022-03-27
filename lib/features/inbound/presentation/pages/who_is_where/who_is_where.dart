import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/data/year_list.dart';
import 'package:rotary_nl_rye/features/uniform_widgets/back_button.dart';

import 'students/district_list_page.dart';

class WhoIsWherePage extends StatefulWidget {
  @override
  _WhoIsWherePageState createState() => _WhoIsWherePageState();
}

class _WhoIsWherePageState extends State<WhoIsWherePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            MediaQuery.of(context).platformBrightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: UniformBackButton(),
        title: Text(
          'Who is Where?',
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: false,
        itemBuilder: (context, index) => InboundYearListTile(
            item: yearList[index],
            districtListPage: DistrictsListPage(
              year: yearList[index],
            )),
        itemCount: yearList.length,
      ),
    );
  }
}
