import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String? id;
  final String? headerUrl;
  final String? jsonUrl;
  final DocumentReference? reference;

  News()
      : id = null,
        headerUrl = null,
        jsonUrl = null,
        reference = null;

  News.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        reference = snapshot.reference,
        headerUrl = snapshot.data()!['header'],
        jsonUrl = snapshot.data()!['json'];
}
