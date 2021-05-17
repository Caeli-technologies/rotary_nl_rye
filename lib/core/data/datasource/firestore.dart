import 'package:cloud_firestore/cloud_firestore.dart';

class FbRemote {
  final String collection;

  FbRemote({required this.collection});

  Future<List> get() async {
    List<QueryDocumentSnapshot> documents = [];

    try {
      final ds = await FirebaseFirestore.instance.collection(collection).orderBy('name').get(GetOptions(source: Source.cache)).then((QuerySnapshot querySnapshot) {
        documents = querySnapshot.docs;
      });
      if (ds == null) {
        FirebaseFirestore.instance.collection(collection).orderBy('name').get(GetOptions(source: Source.server)).then((QuerySnapshot querySnapshot) {
          documents = querySnapshot.docs;
        });
      }
      return ds;
    } catch (_) {
      return [];
    }
  }
}
