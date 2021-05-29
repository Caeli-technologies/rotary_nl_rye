// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/data/utils.dart';
import 'package:rotary_nl_rye/features/stories/models/country.dart';
import 'package:rotary_nl_rye/features/stories/models/exchange_student.dart';

import 'exchange_students_page.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

//TODO preload-svgs
//
//https://kangabru.xyz/2020/05/29/zero-to-hero-2.html#preload-svgs

class _CountriesPageState extends State<CountriesPage> {
  List<ExchangeStudent> exchangeStudents = [];

  Future readJson() async {
    // final String response =
    //     await rootBundle.loadString('assets/test/stories.json');
    final data = await getDataStudents(
        "https://rotary.caeli-tech.com/rebounds/studentList.json");
    setState(() {
      exchangeStudents = data;
    });
  }

  @override
  void initState() {
    readJson(); // TODO: implement initState
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
                item: countries[index],
                descriptionPage: ExchangeStudentsPage(
                  country: countries[index],
                  students: exchangeStudents
                      .where(
                          (element) => element.country == countries[index].name)
                      .toList(),
                )),
            itemCount: countries.length,
          ),
        ),
      );
    }
  }
}

List<Country> countries = [
  Country(
      name: "Canada", imageUrl: "assets/icons/flags/ca.svg", description: ""),
  Country(
      name: "Mexico", imageUrl: "assets/icons/flags/mx.svg", description: ""),
  Country(name: "Peru", imageUrl: "assets/icons/flags/pe.svg", description: ""),
  Country(
      name: "Ecuador", imageUrl: "assets/icons/flags/ec.svg", description: ""),
  Country(
      name: "Chili", imageUrl: "assets/icons/flags/cl.svg", description: ""),
  Country(
      name: "Argentina",
      imageUrl: "assets/icons/flags/ar.svg",
      description: ""),
  Country(
      name: "South Africa",
      imageUrl: "assets/icons/flags/za.svg",
      description: ""),
  Country(
      name: "New Zealand",
      imageUrl: "assets/icons/flags/nz.svg",
      description: ""),
  Country(
      name: "Indonesia",
      imageUrl: "assets/icons/flags/id.svg",
      description: ""),
  Country(
      name: "Thailand", imageUrl: "assets/icons/flags/th.svg", description: ""),
  Country(
      name: "United States of America",
      imageUrl: "assets/icons/flags/us.svg",
      description: ""),
  Country(
      name: "India", imageUrl: "assets/icons/flags/in.svg", description: ""),
  Country(
      name: "Taiwan", imageUrl: "assets/icons/flags/tw.svg", description: ""),
  Country(
      name: "Finland", imageUrl: "assets/icons/flags/fi.svg", description: ""),
  Country(
      name: "Brazil", imageUrl: "assets/icons/flags/br.svg", description: ""),
  Country(
      name: "South Korea",
      imageUrl: "assets/icons/flags/kr.svg",
      description: ""),
  Country(
      name: "Colombia", imageUrl: "assets/icons/flags/co.svg", description: ""),
  Country(
      name: "Italy", imageUrl: "assets/icons/flags/it.svg", description: ""),
  Country(name: "Japan", imageUrl: "assets/icons/flags/jp.svg", description: "")
];

// List<ExchangeStudent> exchangeStudents = [
//   ExchangeStudent(
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     name: "Ruben Talstra",
//     description: "Long Exchange Year 2018-2019",
//     country: "Finland",
//     bio:
//         "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
//     imageUrl: "assets/image/1.PNG",
//     exchangeInfo: {},
//   ),
//   ExchangeStudent(
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     name: "_Bnkn_",
//     description: "Short Exchange Year 2018-2019",
//     country: "Japan",
//     bio:
//         "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
//     imageUrl: "assets/image/2.PNG",
//     exchangeInfo: {},
//   ),
//   ExchangeStudent(
//     name: "Sceptile",
//     description: "Long Exchange Year 2018-2019",
//     country: "Chili",
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     bio:
//         "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
//     imageUrl: "assets/image/3.PNG",
//     exchangeInfo: {},
//   ),
//   ExchangeStudent(
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     name: "Ton Ann",
//     description: "Long Exchange Year 2018-2019",
//     country: "Indonesia",
//     bio:
//         "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
//     imageUrl: "assets/image/1.PNG",
//     exchangeInfo: {},
//   ),
//   ExchangeStudent(
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     name: "Believer",
//     description: "Short Exchange Year 2018-2019",
//     country: "India",
//     bio:
//         "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
//     imageUrl: "assets/image/2.PNG",
//
//   ),
//   ExchangeStudent(
//     sponsorDistrict: "1590",
//     hostDistrict: "7820",
//     name: "Yvan",
//     description: "Short Exchange Year 2018-2019",
//     country: "Canada",
//     imageUrl: "assets/image/2.PNG",
//     )
// ];
