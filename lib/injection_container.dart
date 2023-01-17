// 📦 Package imports:
import 'package:get_it/get_it.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/caching/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/caching/shared_preferences_cache.dart';
import 'package:rotary_nl_rye/core/data/repository/exchange_students.dart';
import 'package:rotary_nl_rye/core/data/repository/header_image_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/news_repository_impl.dart';
import 'package:rotary_nl_rye/core/data/repository/stories_repository_impl.dart';
import 'core/domain/repository/exchange_student_repository.dart';
import 'core/domain/repository/header_image_repository.dart';
import 'core/domain/repository/news_repository.dart';
import 'core/domain/repository/stories_repository.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  /// Data layer

  // Repository
  sl.registerLazySingleton<ExchangeStudentRepository>(() => ExchangeStudentsRepositoryImpl(sl()));
  sl.registerLazySingleton<HeaderImageRepository>(() => HeaderImageRepositoryImpl());
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(sl()));
  sl.registerLazySingleton<StoriesRepository>(() => StoriesRepositoryImpl(sl()));

  // Cache
  sl.registerLazySingleton<Cache>(() => SharedPreferencesCache());
}
