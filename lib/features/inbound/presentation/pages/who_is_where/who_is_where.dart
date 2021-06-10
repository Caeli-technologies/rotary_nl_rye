import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/inbound/data/year_list.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(
              Icons.arrow_back,
              color: Palette.accentColor,
              size: 30.0,
            ),
            shape: new CircleBorder(),
            elevation: 2.0,
            fillColor: Palette.themeShadeColor,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
        title: Text(
          "Who is Where?",
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
