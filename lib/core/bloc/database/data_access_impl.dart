import 'package:rotary_nl_rye/core/bloc/database/file_status_entity.dart';

import '../Database.dart';
import '../domain/data_access.dart';

class SqlLiteAccess implements DataAccess{
  final dbProvider = DatabaseProvider.dbProvider;

  final filesTABLE = 'files';
  @override
  Future<void> add(dynamic fileStatus) async {
    final db = await dbProvider.database;
    final file = fileStatus as FileStatus;
    try {
      db.insert(filesTABLE, file.toDatabaseJson());
      print('file status added to db');
    } catch (e) {
      throw 'unable to add file status to db $e';
    }
  }

  @override
  Future<List<dynamic>> getAll(
      /*{List<String>? columns, String? query}*/) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    /*if (query != null) {
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
    } else {*/
      try {
        result = await db.query(filesTABLE);
        print('file status full query compete $result');
      } catch (e) {
        throw 'unable to full query file status from db $e';
      }
    /*}*/

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

  @override
  Future<int> update(dynamic fileStatus) async {
    final db = await dbProvider.database;
    final file = fileStatus as FileStatus;

    try {
      var result = await db.update(filesTABLE, file.toDatabaseJson(),
          where: "id = ?", whereArgs: [file.id]);
      print('update file status to db done $result');
      return result;
    } catch (e) {
      throw 'unable to update file status to db $e';
    }
  }

  @override
  Future<int> delete(dynamic fileStatus) async {
    final db = await dbProvider.database;
    final file = fileStatus as FileStatus;

    try {
      var result =
          await db.delete(filesTABLE, where: 'id = ?', whereArgs: [file.id]);

      print('delete file status from db done $result');
      return result;
    } catch (e) {
      throw 'unable to add file status to db $e';
    }
  }

  @override
  Future deleteAll() async {
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

  @override
  Future get(item) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
