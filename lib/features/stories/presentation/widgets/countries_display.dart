// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';

import '../../../../core/prop.dart';
import '../../domain/entities/country.dart';
import '../bloc/countries_bloc.dart';
import '../pages/exchange_students_page.dart';

class CountriesDisplay extends StatefulWidget {
  final countries;

  CountriesDisplay({this.countries});

  @override
  _CountriesDisplayState createState() => _CountriesDisplayState(countries);
}

class _CountriesDisplayState extends State<CountriesDisplay> {
  final List<Country> _countries;

  _CountriesDisplayState(this._countries);

  @override
  void initState() {
    BlocProvider.of<CountriesBloc>(context).add(BGetCountries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(
            margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
          child: ListView.builder(
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (context, index) => SVGListTile(
                  item: _countries[index],
                  descriptionPage:
                      ExchangeStudentsPage(country: _countries[index])),
              itemCount: _countries
                  .length //_countries != null ? _countries.length : 0,
              ),
        ),
      );
    }
  }
}
