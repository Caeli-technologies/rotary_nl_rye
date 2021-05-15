import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName {
  final String collection, documentId;

  GetUserName(this.documentId, this.collection);

  void call() {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collection);
    final document = users.doc(documentId).get();
  }
}
