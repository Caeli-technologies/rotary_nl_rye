import 'package:rotary_nl_rye/core/bloc/database/database.dart';

import '../api.dart';

class Crud {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> addFileStatus(FileStatus fileStatus) async {
    final db = await dbProvider.database;
    var result = db.insert(filesTABLE, fileStatus.toDatabaseJson());
    return result;
  }

  Future<List<FileStatus>> getFileStatus(
      {List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(filesTABLE,
            columns: columns,
            where: 'fileName LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(filesTABLE, columns: columns);
    }

    List<FileStatus> files = result.isNotEmpty
        ? result.map((item) => FileStatus.fromDatabaseJson(item)).toList()
        : [];
    return files;
  }

  Future<int> updateFileStatus(FileStatus fileStatus) async {
    final db = await dbProvider.database;

    var result = await db.update(filesTABLE, fileStatus.toDatabaseJson(),
        where: "id = ?", whereArgs: [fileStatus.id]);

    return result;
  }

  Future<int> deleteFileStatus(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(filesTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllFileStatus() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      filesTABLE,
    );

    return result;
  }
}
