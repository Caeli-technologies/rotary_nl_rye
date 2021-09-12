import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotary_nl_rye/core/domain/entities/exchange_student.dart';
import 'package:rotary_nl_rye/core/domain/exchangeStudents.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/models/country.dart';

import 'exchange_students_page.dart';

class CountriesPage extends StatefulWidget {
  // final List<ExchangeStudent> students;
  //
  // const CountriesPage({required this.students});

  @override
  _CountriesPageState createState() => _CountriesPageState();
}

//TODO preload-svgs
//
//https://kangabru.xyz/2020/05/29/zero-to-hero-2.html#preload-svgs

class _CountriesPageState extends State<CountriesPage> {
  final studentBloc = new StudentsBloc();

  @override
  void initState() {
    studentBloc.getExchangeStudentList();
    super.initState();
  }

  @override
  void dispose() {
    studentBloc.disposeStudent(); // TODO: implement dispose
    super.dispose();
  }

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
        leading: Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
          "Countries",
          textScaleFactor: 1.4,
          style: TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: StreamBuilder<List<ExchangeStudent>>(
            stream: studentBloc.studentList,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                // print(
                // 'snapshot has data ${snapshot.data.toString()}');

                return ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  itemBuilder: (context, index) => SVGListTile(
                      item: countries[index],
                      descriptionPage: ExchangeStudentsPage(
                        country: countries[index],
                        students: snapshot.data!
                            .where((element) =>
                                element.country == countries[index].name)
                            .toList(),
                      )),
                  itemCount: countries.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

List<Country> countries = [
  Country(
    name: "Argentina",
    imageUrl: "assets/icons/flags/ar.svg",
    description: "",
  ),
  Country(
    name: "Australia",
    imageUrl: "assets/icons/flags/au.svg",
    description: "",
  ),
  Country(
    name: "Brazil",
    imageUrl: "assets/icons/flags/br.svg",
    description: "",
  ),
  Country(
    name: "Canada",
    imageUrl: "assets/icons/flags/ca.svg",
    description: "",
  ),
  Country(
    name: "Chili",
    imageUrl: "assets/icons/flags/cl.svg",
    description: "",
  ),
  Country(
    name: "Colombia",
    imageUrl: "assets/icons/flags/co.svg",
    description: "",
  ),
  Country(
    name: "Ecuador",
    imageUrl: "assets/icons/flags/ec.svg",
    description: "",
  ),
  Country(
    name: "Finland",
    imageUrl: "assets/icons/flags/fi.svg",
    description: "",
  ),
  Country(
    name: "India",
    imageUrl: "assets/icons/flags/in.svg",
    description: "",
  ),
  Country(
    name: "Indonesia",
    imageUrl: "assets/icons/flags/id.svg",
    description: "",
  ),
  Country(
    name: "Italy",
    imageUrl: "assets/icons/flags/it.svg",
    description: "",
  ),
  Country(
    name: "Japan",
    imageUrl: "assets/icons/flags/jp.svg",
    description: "",
  ),
  Country(
    name: "Mexico",
    imageUrl: "assets/icons/flags/mx.svg",
    description: "",
  ),
  Country(
    name: "New Zealand",
    imageUrl: "assets/icons/flags/nz.svg",
    description: "",
  ),
  Country(
    name: "Peru",
    imageUrl: "assets/icons/flags/pe.svg",
    description: "",
  ),
  Country(
    name: "South Africa",
    imageUrl: "assets/icons/flags/za.svg",
    description: "",
  ),
  Country(
    name: "South Korea",
    imageUrl: "assets/icons/flags/kr.svg",
    description: "",
  ),
  Country(
    name: "Taiwan",
    imageUrl: "assets/icons/flags/tw.svg",
    description: "",
  ),
  Country(
    name: "Thailand",
    imageUrl: "assets/icons/flags/th.svg",
    description: "",
  ),
  Country(
    name: "United States of America",
    imageUrl: "assets/icons/flags/us.svg",
    description: "",
  ),
];
