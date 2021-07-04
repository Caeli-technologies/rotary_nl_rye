import 'dart:async';

import 'package:rotary_nl_rye/core/bloc/database/data_access_impl.dart';
import 'package:rotary_nl_rye/core/bloc/database/file_status_entity.dart';
import 'package:rotary_nl_rye/core/bloc/domain/data_access.dart';

class DbBloc {
  final DataAccess _dataAccess = new SqlLiteAccess();
  final _fileController = StreamController<List<FileStatus>>.broadcast();

  get fileStatus => _fileController.stream;

  DbBloc() {
    getFileStatus();
  }

  getAllFileStatus() async {
    return await _dataAccess.getAll();
  }

  getFileStatus({String? query}) async {
    _fileController.sink
        .add(await _dataAccess.getAll() as List<FileStatus>);
  }

  addFileStatus(FileStatus fileStatus) async {
    await _dataAccess.add(fileStatus);
  }

  updateFileStatus(FileStatus fileStatus) async {
    await _dataAccess.update(fileStatus);
  }

  deleteFileStatusById(dynamic item) {
    _dataAccess.delete(item);
  }

  deleteAllFileStatus() {
    _dataAccess.deleteAll();
  }

  dispose() {
    _fileController.close();
  }
}
