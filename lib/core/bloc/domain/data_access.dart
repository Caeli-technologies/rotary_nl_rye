abstract class DataAccess {
  Future<List<dynamic>> getAll();
  Future<dynamic> get(dynamic item);
  Future<void> add(dynamic item);
  Future<void> update(dynamic item);
  Future<void> delete(dynamic item);

  //We are not going to use this in the demo
  Future<void> deleteAll();
}