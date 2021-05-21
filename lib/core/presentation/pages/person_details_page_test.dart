//TODO this is just a test. maybe we can build on this.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rotary_nl_rye/core/prop.dart';

class PersonDetails1 extends StatelessWidget {
  final person;
  final List<String> box1 = ['some', 'thing', 'can', 'here'];
  final List<String> data1 = [
    '1',
    '2',
    '3',
    '4'
  ]; //TODO change to font awesome icons :)

  PersonDetails1({required this.person});
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
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(person.imageUrl),
                    radius: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        person.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SvgPicture.asset(
                            'assets/icons/custom/rotary-logo-icon.svg',
                            color: Color(0xFFf7a81b),
                            height: 30),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 30.0, bottom: 30.0),
                  child: Text(
                    "function + District",
                    style: TextStyle(color: Colors.grey[400], fontSize: 15.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 30.0, bottom: 0.0),
                  child: Text(
                    "Hobbies",
                    style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 3.0, left: 25.0, right: 0.0),
                  child: SizedBox(
                    height: 100.0,
                    width: 400.0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: false,
                            itemCount: box1.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 14.0),
                                child: Material(
                                  child: GestureDetector(
                                    child: Container(
                                      height: 200.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.grey[200],
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(box1[index],
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16.0)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                data1[index],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 40.0, right: 35.0, top: 20.0),
                  child: Text(
                    person.bio,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 30.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                            child: Icon(
                          Icons.present_to_all,
                          color: Colors.black,
                          size: 25,
                        )),
                      ),
                      Container(
                        height: 65.0,
                        width: 240.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                color: Colors.blue.shade100, width: 5),
                            color: Colors.blue[400]),
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  'Send a e-mail',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
