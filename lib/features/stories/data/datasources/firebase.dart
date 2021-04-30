// @dart=2.9
import 'package:firebase_database/firebase_database.dart';

class FirebaseDB {
  static final firebaseDbRef = FirebaseDatabase.instance.reference();

  static Future<Map> get() async{
    Map result = {};

    await firebaseDbRef.once().asStream().forEach((element) {
      print(element.value);
      result = element.value as Map;
    });

    return result;
  }

  static Future<List> getTable(String tableName) async {
    List result = [];
    Map map = await get();

    result = map[tableName];

    return result;
  }
}