import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String? id;
  final String? headerUrl;
  final String? jsonUrl;
  final String? students;
  final DocumentReference? reference;

  News()
      : id = null,
        headerUrl = null,
        jsonUrl = null,
        students = null,
        reference = null;

  News.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        students = snapshot.data()!['students'],
        reference = snapshot.reference,
        headerUrl = snapshot.data()!['header'],
        jsonUrl = snapshot.data()!['json'];
}
