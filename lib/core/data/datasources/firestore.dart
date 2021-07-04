import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../datamodels/firestore_urls_model.dart';

class FireStoreUrls {
  Future<FireStoreUrlsModel> getUrls() async {
    FirebaseAuth.instance.signInAnonymously();
    try {
      final urls = await FirebaseFirestore.instance
          .collection('urls')
          .doc('today')
          .get();
      return FireStoreUrlsModel.fromSnapshot(urls);
    } catch (e) {
      print(e);
      throw 'unable to fetch and parse FirestoreUrl $e';
    }
  }
}
