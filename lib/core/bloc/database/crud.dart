import 'package:rotary_nl_rye/core/bloc/database/database.dart';

import '../api.dart';

class Crud {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> addFileStatus(FileStatus fileStatus) async {
    final db = await dbProvider.database;
    try {
      var result = db.insert(filesTABLE, fileStatus.toDatabaseJson());
      print('file status added to db $result');
      return result;
    } catch (e) {
      throw 'unable to add file status to db $e';
    }
  }

  Future<List<FileStatus>> getFileStatus(
      {List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        try {
          result = await db.query(filesTABLE,
              columns: columns,
              where: 'fileName LIKE ?',
              whereArgs: ["%$query%"]);
          print('file status query complete $result');
        } catch (e) {
          throw 'unable to query file status from db $e';
        }
      }
    } else {
      try {
        result = await db.query(filesTABLE, columns: columns);
        print('file status full query compete $result');
      } catch (e) {
        throw 'unable to full query file status from db $e';
      }
    }

    try {
      List<FileStatus> files = result.isNotEmpty
          ? result.map((item) => FileStatus.fromDatabaseJson(item)).toList()
          : [];
      print('parsed file status result from db');
      return files;
    } catch (e) {
      throw 'unable to parse file status result from db $e';
    }
  }

  Future<int> updateFileStatus(FileStatus fileStatus) async {
    final db = await dbProvider.database;

    try {
      var result = await db.update(filesTABLE, fileStatus.toDatabaseJson(),
          where: "id = ?", whereArgs: [fileStatus.id]);
      print('update file status to db done $result');
      return result;
    } catch (e) {
      throw 'unable to update file status to db $e';
    }
  }

  Future<int> deleteFileStatus(int id) async {
    final db = await dbProvider.database;
    try {
      var result =
          await db.delete(filesTABLE, where: 'id = ?', whereArgs: [id]);

      print('delete file status from db done $result');
      return result;
    } catch (e) {
      throw 'unable to add file status to db $e';
    }
  }

  Future deleteAllFileStatus() async {
    final db = await dbProvider.database;
    try {
      var result = await db.delete(
        filesTABLE,
      );
      print('delete file table done $result');
      return result;
    } catch (e) {
      throw 'unable to add file status to db $e';
    }
  }
}
