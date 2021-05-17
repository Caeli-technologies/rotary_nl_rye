import 'package:cloud_firestore/cloud_firestore.dart';

class FbRemote {
  final String collection;

  FbRemote({required this.collection});

  Future<List> get() async {
    List<QueryDocumentSnapshot> documents = [];

    await FirebaseFirestore.instance
        .collection(collection)
        .get()
        .then((QuerySnapshot querySnapshot) {
      documents = querySnapshot.docs;
    });

    return Future.value(documents);
    //throw ServerException();
  }
}
