import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';

import '../datamodels/firestore_urls_model.dart';

class FireStoreUrls {
  Future<FireStoreUrlsModel> getUrls() async {
    FirebaseAuth.instance.signInAnonymously();
    try {
      final urls = await FirebaseFirestore.instance
          .collection(Config.fbDataCollectionKey)
          .doc(Config.fbDataDocumentKey)
          .get();
      return FireStoreUrlsModel.fromSnapshot(urls);
    } catch (e) {
      print(e);
      throw 'unable to fetch and parse FirestoreUrl $e';
    }
  }
}
