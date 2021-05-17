import 'package:rotary_nl_rye/core/data/datasource/firestore.dart';
import 'package:rotary_nl_rye/features/stories/data/models/country_model.dart';

abstract class CountriesRemoteDataSource {
  /// Fetches countries data from firestore.
  Future<List<CountryModel>> getCountries();
}

class CountriesRemoteDataSourceImpl implements CountriesRemoteDataSource {

  @override
  Future<List<CountryModel>> getCountries() async {
    List docs = await FbRemote(collection: "/countries").get();
    List<CountryModel> countries = [];

    // docs to countries
    docs.forEach((document) {
      countries.add(new CountryModel.fromDoc(document));
      print(CountryModel.fromDoc(document));
    });

    return Future.value(countries);
  }
}
