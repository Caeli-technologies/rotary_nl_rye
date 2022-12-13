abstract class Cache {
  Future<dynamic> getByKey(String key);

  Future<void> store(String key, dynamic value);

  Future<void> invalidate();
}