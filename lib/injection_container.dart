// @dart=2.9
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:rotary_nl_rye/core/network/network_info.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/countries_remote_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/different.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/stories_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/update_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/repositories/countries_repository_impl.dart';
import 'package:rotary_nl_rye/features/stories/data/repositories/stories_respository_impl.dart';
import 'package:rotary_nl_rye/features/stories/domain/repositories/countries_repository.dart';
import 'package:rotary_nl_rye/features/stories/domain/repositories/stories_repository.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_countries.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';
import 'package:rotary_nl_rye/features/stories/presentation/bloc/countries_bloc.dart';
import 'package:rotary_nl_rye/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Stories
  // Bloc
  sl.registerFactory(() => StoriesBloc(getStories: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetStories(sl()));

  // Repository
  sl.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
      storiesRemoteDataSource: sl(),
      storiesLocalDataSource: sl(),
      updateLocalDataSource: sl(),
      networkInfo: sl()));

  // Data Sources
  sl.registerLazySingleton<StoriesRemoteDataSource>(
      () => StoriesRemoteDataSourceImpl(firebaseDatabase: sl()));
  sl.registerLazySingleton<StoriesLocalDataSource>(
      () => StoriesLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<UpdateLocalDataSource>(
      () => UpdateLocalDataSourceImpl(sharedPreferences: sl()));

  /// Features - Stories/Countries
  // Bloc
  sl.registerFactory(() => CountriesBloc(getCountries: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetCountries(sl()));

  // Repository
  sl.registerLazySingleton<CountriesRepository>(() => CountriesRepositoryImpl(
      countriesRemoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<CountriesRemoteDataSource>(
          () => CountriesRemoteDataSourceImpl());

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());

  final FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  sl.registerLazySingleton(() => firebaseDatabase);
}
