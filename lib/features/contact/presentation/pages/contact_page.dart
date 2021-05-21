// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rotary_nl_rye/core/presentation/pages/person_details_page.dart';
import 'package:rotary_nl_rye/core/presentation/pages/person_details_page_test.dart';
import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/rotex.dart';

import '../contact_search.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

//TODO needs to look like the story page. nut then only for contacts of the organication and Rotex (https://rotex.org/who-we-are/)
class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: ContactSearch(organizationList));
              },
              icon: FaIcon(
                FontAwesomeIcons.search,
                color: Palette.lightIndigo,
              ),
            )
          ],
          bottom: TabBar(
            labelColor: const Color(0xff525c6e),
            unselectedLabelColor: const Color(0xffacb3bf),
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
                child: Text("Organization"),
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
                  item: organizationList[index],
                  contactDetailsPage:
                      PersonDetails1(person: organizationList[index])),
              itemCount: organizationList.length,
            ),
            ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) => ImageListTile(
                  item: rotexList[index],
                  descriptionPage: PersonDetails1(person: rotexList[index])),
              itemCount: rotexList.length,
            )
          ]),
        ),
      ),
    );
  }
}

List<Organization> organizationList = [
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'yes',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'no',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'no',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'no',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'no',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
  Organization(
    name: "Barbara Tusveld",
    rotarian: 'no',
    bio:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
    imageUrl: "assets/image/1.PNG",
    email1: "ruben@example.com",
    email2: "ruben@example.com",
    phoneNumber1: "888 444 7676",
    phoneNumber2: "888 444 7676",
    club: '',
    district: '1590',
    role: 'Chair long term Rotary Youth Exchange',
    exchangeInfo: {
      "place": "Canada",
      "travelDates": ["March 2020", "May 2020"]
    },
  ),
];

List<Rotex> rotexList = [
  Rotex(
      name: "Ruben Talstra",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "Netherlands",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/1.PNG",
      email: "ruben@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {
        "place": "Canada",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Rotex(
      name: "_Bnkn_",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "Germany",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "bnkn@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Rotex(
      name: "Sceptile",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "Germany",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/3.PNG",
      email: "sceptile@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Rotex(
      name: "Ton Ann",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "France",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/1.PNG",
      email: "tonann@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
  Rotex(
      name: "Believer",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "India",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "believer@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {}),
  Rotex(
      name: "Yvan",
      rotarian: 'no',
      description: "Flutter Dev",
      place: "Nice Place",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "yvan@example.com",
      phoneNumber: "888 444 7676",
      role: '',
      district: '',
      exchangeInfo: {
        "place": "Japan",
        "travelDates": ["March 2020", "May 2020"]
      }),
];
