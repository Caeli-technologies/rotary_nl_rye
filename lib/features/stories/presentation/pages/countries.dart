// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/lang/languages.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/country.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/image_list_tile.dart';

import 'exchange_students_page.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5),
            width: 40,
            height: 40,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
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
            "Countries",
            textScaleFactor: 1.4,
            style:
                TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: Device.height - 170,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
            shrinkWrap: false,
            itemBuilder: (context, index) => SVGListTile(
                item: countries[index],
                descriptionPage:
                    ExchangeStudentsPage(person: countries[index])),
            itemCount: countries.length,
          ),
        ),
      );
    }
  }
}

List<Country> countries = [
  Country(
      name: "France", imageUrl: "assets/icons/flags/fr.svg", description: ""),
  Country(
      name: "India", imageUrl: "assets/icons/flags/in.svg", description: ""),
  Country(
      name: "Germany", imageUrl: "assets/icons/flags/de.svg", description: ""),
  Country(name: "USA", imageUrl: "assets/icons/flags/us.svg", description: ""),
  Country(
      name: "Brazil", imageUrl: "assets/icons/flags/br.svg", description: ""),
  Country(name: "Japan", imageUrl: "assets/icons/flags/jp.svg", description: "")
];
