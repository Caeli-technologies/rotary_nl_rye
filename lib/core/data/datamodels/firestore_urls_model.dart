import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUrlsModel {
  final String? id;
  final DocumentReference? reference;
  final String? headerUrl;
  final String? jsonUrl;
  final String? studentsUrl;

  FireStoreUrlsModel({this.headerUrl, this.jsonUrl, this.studentsUrl})
      : id = null,
        reference = null;

  FireStoreUrlsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        reference = snapshot.reference,
        headerUrl = snapshot.data()!['students'],
        jsonUrl = snapshot.data()!['header'],
        studentsUrl = snapshot.data()!['json'];

  factory FireStoreUrlsModel.fromJson(Map<String, dynamic> json) => FireStoreUrlsModel(
      headerUrl: json["header"],
      jsonUrl: json["json"],
      studentsUrl: json["students"]);

  Map<String, dynamic> toJson() {
    return {
      "students": studentsUrl,
      "header": headerUrl,
      "json": jsonUrl,
    };
  }
}
