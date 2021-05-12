// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotary_nl_rye/core/prop.dart';
import 'package:rotary_nl_rye/features/stories/presentation/pages/contact_person_details_page.dart';
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
/*
              Container(
                  height: 30,
                  child: Tab(
                    text: DemoLocalizations.of(context).trans('storiesTabBar3'),
                  )),
              Container(
                  height: 30,
                  child: Tab(
                    text: DemoLocalizations.of(context).trans('storiesTabBar4'),
                  )),
*/
            ],
          ),
          Container(
            height: Device.height - 277,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TabBarView(children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => PersonTile(
                  person: personList[index],
                ),
                itemCount: personList.length,
              ),
              Center(
                child: Text("2"),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class PersonTile extends StatelessWidget {
  final Person person;
  const PersonTile({
    this.person,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonDetails(person: person)),
          );
        },
        contentPadding: EdgeInsets.all(0),
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Palette
                  .imageBackgroundColor, //fill the image still needs to chagnge
            ),
            child: Image.asset(
              person.imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(person.name,
            style: TextStyle(
              color: Palette.indigo,
            )),
        subtitle: Text(
          person.role,
          style: TextStyle(
            color: Palette.indigo,
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Palette.indigo,
        ),
      ),
    );
  }
}

//TODO:This needs to be in other file.
//Mock Data
class Person {
  final String name;
  final String role;
  final String bio;
  final String place;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final Map<String, dynamic> exchangeInfo;
  Person(
      {this.name,
      this.role,
      this.bio,
      this.place,
      this.imageUrl,
      this.email,
      this.phoneNumber,
      this.exchangeInfo});
}

List<Person> personList = [
  Person(
      name: "Ruben Talstra",
      role: "Flutter Dev",
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
      role: "Flutter Dev",
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
      role: "Flutter Dev",
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
      role: "Flutter Dev",
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
      role: "Flutter Dev",
      place: "India",
      bio:
          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
      imageUrl: "assets/image/2.PNG",
      email: "believer@example.com",
      phoneNumber: "888 444 7676",
      exchangeInfo: {}),
];
