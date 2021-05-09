// @dart=2.9
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:rotary_nl_rye/core/network/network_info.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/stories_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/stories_remote_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/update_local_data_source.dart';
import 'package:rotary_nl_rye/features/stories/data/repositories/stories_respository_impl.dart';
import 'package:rotary_nl_rye/features/stories/domain/repositories/stories_repository.dart';
import 'package:rotary_nl_rye/features/stories/domain/usecases/get_stories.dart';
import 'package:rotary_nl_rye/features/stories/presentation/bloc/stories_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

 // service locator
final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Stories
  // Bloc
  sl.registerFactory(() => StoriesBloc(
      getStories: sl()
  ));

  // Use cases
  sl.registerLazySingleton(() => GetStories(sl()));

  // Repository
  sl.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(
      storiesRemoteDataSource: sl(),
      storiesLocalDataSource: sl(),
      updateLocalDataSource: sl(),
      networkInfo: sl()
  ));
  
  // Data Sources
  sl.registerLazySingleton<StoriesRemoteDataSource>(() => StoriesRemoteDataSourceImpl());
  sl.registerLazySingleton<StoriesLocalDataSource>(() => StoriesLocalDataSourceImpl(
      sharedPreferences: sl()
  ));
  sl.registerLazySingleton<UpdateLocalDataSource>(() => UpdateLocalDataSourceImpl(
      sharedPreferences: sl()
  ));

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DataConnectionChecker());
}