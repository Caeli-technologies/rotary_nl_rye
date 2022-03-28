// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/network/network_info.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Stories
  // Bloc
  // sl.registerFactory(() => StoriesBloc(getStories: sl()));

  // Use cases
  // sl.registerLazySingleton(() => GetStories(sl()));

  // temp solluction
  final Cache cache = new Cache();

  await cache.clear();
  // final today = DateTime(now.year, now.month, now.day);
  // final toDaysAgo = DateTime(now.year, now.month, now.day - 2);

  // Repository
  // sl.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
  //     storiesRemoteDataSource: sl(),
  //     storiesLocalDataSource: sl(),
  //     updateLocalDataSource: sl(),
  //     networkInfo: sl()));

  // Data Sources
  // sl.registerLazySingleton<StoriesRemoteDataSource>(
  //     () => StoriesRemoteDataSourceImpl(firebaseDatabase: sl()));
  // sl.registerLazySingleton<StoriesLocalDataSource>(
  //     () => StoriesLocalDataSourceImpl(sharedPreferences: sl()));
  // sl.registerLazySingleton<UpdateLocalDataSource>(
  //     () => UpdateLocalDataSourceImpl(sharedPreferences: sl()));

  /// Features - Stories/Countries
  // Bloc
  // sl.registerFactory(() => CountriesBloc(getCountries: sl()));

  // Use cases
  // sl.registerLazySingleton(() => GetCountries(sl()));

  // Repository
  // sl.registerLazySingleton<CountriesRepository>(() => CountriesRepositoryImpl(
  //     countriesRemoteDataSource: sl()));

  // Data Sources
  // sl.registerLazySingleton<CountriesRemoteDataSource>(
  //         () => CountriesRemoteDataSourceImpl());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // final FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  // sl.registerLazySingleton(() => firebaseDatabase);
}
