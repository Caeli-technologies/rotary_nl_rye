// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/presentation/pages/person_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/presentation/models/person.dart';
import 'package:rotary_nl_rye/features/stories/presentation/widgets/stories_display.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

//TODO needs to look like the story page. nut then only for contacts of the organication and Rotex (https://rotex.org/who-we-are/)

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //length: 4,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 60),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Contact List',
              textScaleFactor: 2.4,
              style:
                  TextStyle(color: Palette.indigo, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator:
                CircleTabIndicator(color: Palette.accentColor, radius: 2),
            unselectedLabelColor: Palette.lightIndigo,
            labelColor: Palette.accentColor,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            tabs: [
              Container(height: 30, child: Tab(text: 'Organization')),
              Container(
                  height: 30,
                  child: Tab(
                    text: 'Rotex',
                  )),
            ],
          ),
          Container(
            height: Device.height - 277,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TabBarView(children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ImageListTile(
                    item: personList[index],
                    descriptionPage: PersonDetails(person: personList[index])),
                itemCount: personList.length,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => ImageListTile(
                    item: personList[index],
                    descriptionPage: PersonDetails(person: personList[index])),
                itemCount: personList.length,
              )
            ]),
          )
        ],
      ),
    );
  }
}

List<Person> personList = [
  Person(
      name: "Ruben Talstra",
      description: "Flutter Dev",
      place: "Netherlands",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/1.PNG",
      email: "ruben@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {
        "place": "Canada",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Person(
      name: "_Bnkn_",
      description: "Flutter Dev",
      place: "Germany",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "bnkn@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Person(
      name: "Sceptile",
      description: "Flutter Dev",
      place: "Germany",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/3.PNG",
      email: "sceptile@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Person(
      name: "Ton Ann",
      description: "Flutter Dev",
      place: "France",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/1.PNG",
      email: "tonann@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Person(
      name: "Believer",
      description: "Flutter Dev",
      place: "India",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "believer@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {}),
  Person(
      name: "Yvan",
      description: "Flutter Dev",
      place: "Nice Place",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "yvan@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
];
