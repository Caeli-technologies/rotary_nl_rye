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
  // temp solluction
  final Cache cache = new Cache();

  await cache.clear();

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
