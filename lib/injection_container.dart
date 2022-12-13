// 📦 Package imports:
import 'package:get_it/get_it.dart';
import 'package:rotary_nl_rye/core/data/repository/exchange_students.dart';
import 'package:rotary_nl_rye/core/data/repository/header_image_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/news_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/stories_repository_impl.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/shared_preferences_cache.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  /// Data layer

  // Repository
  sl.registerLazySingleton(() => ExchangeStudentsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => HeaderImageRepositoryImpl());
  sl.registerLazySingleton(() => NewsRepositoryImpl(sl()));
  sl.registerLazySingleton(() => StoriesRepositoryImpl(sl()));

  // Cache
  sl.registerLazySingleton(() => SharedPreferencesCache());
}
