import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUrl {
  final String? id;
  final String? headerUrl;
  final String? jsonUrl;
  final String? students;
  final DocumentReference? reference;

  FireStoreUrl({this.jsonUrl, this.headerUrl, this.students})
      : id = null,
        reference = null;

  FireStoreUrl.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        students = snapshot.data()!['students'],
        reference = snapshot.reference,
        headerUrl = snapshot.data()!['header'],
        jsonUrl = snapshot.data()!['json'];

  factory FireStoreUrl.fromJson(Map<String, dynamic> json) => FireStoreUrl(
      headerUrl: json["headerUrl"],
      jsonUrl: json["jsonUrl"],
      students: json["students"]);

  Map<String, dynamic> toJson() {
    return {
      "students": students,
      "headerUrl": headerUrl,
      "jsonUrl": jsonUrl,
    };
  }
}
