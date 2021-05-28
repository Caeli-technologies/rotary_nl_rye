import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:rotary_nl_rye/features/news/models/news.dart';

Stream<DocumentSnapshot<Map<String, dynamic>>> loadNews() {
  print('Stream');
  return FirebaseFirestore.instance.collection('news').doc('today').snapshots();
}

News getNewsFromQuery(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  if (!snapshot.exists) {
    throw 'get News from query is null';
  }
  return News.fromSnapshot(snapshot);
}

Future getData(String url) async {
  http.Response? response;
  try {
    response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  } catch (e) {
    print(e);
    throw 'unable to fetch news json';
  }
  return response.body;
}
