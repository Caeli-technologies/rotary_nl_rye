// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_database/firebase_database.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final databaseReference = FirebaseDatabase.instance.reference();

  var name;

  getList() async {
    await databaseReference
        .child("stories")
        .once()
        .then((DataSnapshot dataSnapshot) {
      this.setState(() {
        for (var value in dataSnapshot.value.values) {
          name.add(new Post.fromJson(value));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Realtime Database Demo'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('Create Data'),
              color: Colors.redAccent,
              onPressed: () {
                getList();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Read/View Data'),
              color: Colors.redAccent,
              onPressed: () {
                readData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Update Data'),
              color: Colors.redAccent,
              onPressed: () {
                updateData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Delete Data'),
              color: Colors.redAccent,
              onPressed: () {
                deleteData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ],
        ),
      )), //center
    );
  }

  void createData() {
    databaseReference
        .child("flutterDevsTeam1")
        .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});
    databaseReference.child("flutterDevsTeam2").set(
        {'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'});
    databaseReference
        .child("flutterDevsTeam3")
        .set({'name': 'Akshay', 'description': 'Software Engineer'});
    databaseReference
        .child("flutterDevsTeam4")
        .set({'name': 'Aditya', 'description': 'Software Engineer'});
    databaseReference
        .child("flutterDevsTeam5")
        .set({'name': 'Shaiq', 'description': 'Associate Software Engineer'});
    databaseReference
        .child("flutterDevsTeam6")
        .set({'name': 'Mohit', 'description': 'Associate Software Engineer'});
    databaseReference
        .child("flutterDevsTeam7")
        .set({'name': 'Naveen', 'description': 'Associate Software Engineer'});
  }

  void readData() {
    databaseReference.child("stories").once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData() {
    databaseReference.child('flutterDevsTeam1').update({'description': 'CEO'});
    databaseReference
        .child('flutterDevsTeam2')
        .update({'description': 'Team Lead'});
    databaseReference
        .child('flutterDevsTeam3')
        .update({'description': 'Senior Software Engineer'});
  }

  void deleteData() {
    databaseReference.child('flutterDevsTeam1').remove();
    databaseReference.child('flutterDevsTeam2').remove();
    databaseReference.child('flutterDevsTeam3').remove();
  }
}

class Post {
  String name;
  String content;
  Post(this.name, this.content);

  Post.fromJson(var value) {
    this.name = value['name'];
    this.name = value['name'];
  }
}
