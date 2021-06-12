import 'dart:convert';

import 'package:rotary_nl_rye/core/bloc/api.dart';
import 'package:rotary_nl_rye/features/news/models/firestore_url.dart';

bool firstStart = true;

class Repository {
  firstRun() async {
    firstStart = await apiProvider.getBoolValuesSF('firstRun');
    switch (firstStart) {
      case true:
        print('first run');
        await apiProvider.fetchUrls().then((value) {
          apiProvider.writeFile(
              content: value.toJson(), fileName: fireStoreUrlFile);
        });
        apiProvider.addBoolToSF(key: 'firstRun', value: false);
        break;
      case false:
        print('non first run');
        DateTime x = DateTime.parse(apiProvider.getStringValuesSF(dbCreate));
        if (x.difference(DateTime.now()).inHours > dbPurge) {
          apiProvider.dbBloc.deleteAllFileStatus();
          await apiProvider.fetchUrls().then((value) {
            apiProvider.writeFile(
                content: value.toJson(), fileName: fireStoreUrlFile);
          });
          apiProvider.addStringToSF(
              key: dbCreate, value: DateTime.now().toString());
        }
    }
  }

  fetchNews() async {
    FireStoreUrl url;
    String x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    print("x ${x.toString()}");
    url = FireStoreUrl.fromJson(json.decode(x));
    return await apiProvider.getDataNews(url.jsonUrl!);
  }

  fetchHeader() async {
    FireStoreUrl url;
    String x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    url = FireStoreUrl.fromJson(json.decode(x));
    return url.headerUrl!;
  }

  fetchStudentList() async {
    FireStoreUrl url;
    String x = await apiProvider.readFile(fileName: fireStoreUrlFile);
    url = FireStoreUrl.fromJson(json.decode(x));
    return await apiProvider.getDataStudentList(url.students!);
  }
}
