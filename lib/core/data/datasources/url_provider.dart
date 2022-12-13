// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/config.dart';

class UrlProvider {
  static Future<String> _getUrls(String key) async {
    FirebaseAuth.instance.signInAnonymously();
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection(Config.fbDataCollectionKey)
          .doc(Config.fbDataDocumentKey)
          .get();
      return documentSnapshot.data()![key];
    } catch (e) {
      throw 'unable to fetch and parse FirestoreUrl $e';
    }
  }

  static String getStoriesUrl(
      String studentExchangeYear, String studentName) {
    return "https://www.rotary.nl/yep/yep-app/tu4w6b3-6436ie5-63h0jf-9i639i4-t3mf67-uhdrs/rebounds/students/$studentExchangeYear/${studentName.replaceAll(" ", "_").toLowerCase()}.json";
  }

  static Future<String> getExchangeStudentUrl() async {
    return await _getUrls(Config.fbExchangeStudentsKey);
  }

  static Future<String> getImageHeaderUrl() async {
    return await _getUrls(Config.fbImageHeaderKey);
  }

  static Future<String> getNewsUrl() async {
    return await _getUrls(Config.fbNewsKey);
  }
}
