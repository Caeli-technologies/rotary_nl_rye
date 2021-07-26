import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';

class FireStoreUrls {
  static Future<String> getUrl(String key) async {
    FirebaseAuth.instance.signInAnonymously();
    try {
      final urls = await FirebaseFirestore.instance
          .collection(Config.fbDataCollectionKey)
          .doc(Config.fbDataDocumentKey)
          .get();
      return urls.data()![key];
    } catch (e) {
      throw 'unable to fetch and parse FirestoreUrl $e';
    }
  }
}
