import 'package:cloud_firestore/cloud_firestore.dart';

class GetData {
  final String collection;

  GetData({required this.collection});

  void call() {
    FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['name']);
        print(doc.id);
      });
    });
  }
}
