import 'package:rotary_nl_rye/features/stories/data/models/update_model.dart';

abstract class UpdateLocalDataSource {
  /// Fetches the [UpdateModel]
  ///
  /// Throws [CacheException] if no cached data is present.
  @override
  Future<bool> get timeSpanIsGreaterThen24h;

  Future<void> cacheUpdate(UpdateModel updateToCache);
}

/*class UpdateLocalDataSourceImpl implements UpdateLocalDataSource {
  final timeNow = DateTime.now().millisecondsSinceEpoch;
  fianl oneDay =
  Future<bool> get timeSpanIsGreaterThen24h => ;
}*/