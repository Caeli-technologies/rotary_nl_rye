import 'package:cloud_firestore/cloud_firestore.dart';

class FbRemote {
  final String collection;

  FbRemote({required this.collection});

  Future<List> get() async {
    List<QueryDocumentSnapshot> documents = [];

    // TODO fetch changes from remote
    try {
      // it should only fetch changed documents from firebase and apply the changes to the cache
      // https://firebase.google.com/docs/firestore/query-data/listen)

      // fetches all documents from local
      await FirebaseFirestore.instance.collection(collection).orderBy('name').get(GetOptions(source: Source.cache)).then((QuerySnapshot querySnapshot) {
        documents = querySnapshot.docs;
        print('from cache');
      });

      // fetches all documents from remote if cache is empty
      if (documents.toString() == '[]') {
        await FirebaseFirestore.instance.collection(collection).orderBy('name').get(GetOptions(source: Source.server)).then((QuerySnapshot querySnapshot) {
          documents = querySnapshot.docs;
          print('from remote');
        });
      }
      return documents;
    } catch (_) {
      return [];
    }
  }
}
