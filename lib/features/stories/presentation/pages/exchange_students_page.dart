// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/settings/presentation/pages/models/contributor.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/person.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/stories_display.dart';

class ExchangeStudentsPage extends StatelessWidget {
  final country, stories;
  const ExchangeStudentsPage({this.country, this.stories});

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
          country.name,
          textScaleFactor: 1.5,
          style: TextStyle(
              color: Palette.indigo, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(shrinkWrap: true, children: [
            Container(
              child: SvgPicture.asset(
                country.imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Palette.themeShadeColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(40.0),
                ),
              ),
              child: Text(
                "Exchange Students",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Palette.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Container(
              height: Device.height - 265,
              child: ListView.builder(
                itemBuilder: (context, index) => ReboundsStudentsListTile(
                  item: exchangeStudents[index],
                  reboundsStudentsListPage: StoriesDisplay(),
                ),
                itemCount: exchangeStudents.length,
              ),
            )
          ]),
        ),
      ),
    );
  }
}

List<Person> exchangeStudents = [
  Person(
    name: "Ruben Talstra",
    description: "Long Exchange Year 2018-2019",
    place: "Netherlands",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email: "ruben@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  ),
  Person(
    name: "_Bnkn_",
    description: "Short Exchange Year 2018-2019",
    place: "Germany",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/2.PNG",
    email: "bnkn@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  ),
  Person(
    name: "Sceptile",
    description: "Long Exchange Year 2018-2019",
    place: "Germany",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/3.PNG",
    email: "sceptile@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  ),
  Person(
    name: "Ton Ann",
    description: "Long Exchange Year 2018-2019",
    place: "France",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email: "tonann@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  ),
  Person(
    name: "Believer",
    description: "Short Exchange Year 2018-2019",
    place: "India",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/2.PNG",
    email: "believer@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  ),
  Person(
    name: "Yvan",
    description: "Short Exchange Year 2018-2019",
    place: "Nice Place",
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/2.PNG",
    email: "yvan@example.com",
    phoneNumber: "888 444 7676",
    exchangeInfo: {},
  )
];
