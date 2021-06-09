import 'dart:async';

import 'package:rotary_nl_rye/core/bloc/database/database.dart';
import 'package:rotary_nl_rye/core/bloc/database/repository.dart';

class DbBloc {
  final _fileRepository = FileRepository();
  final _fileController = StreamController<List<FileStatus>>.broadcast();

  get fileStatus => _fileController.stream;

  DbBloc() {
    getFileStatus();
  }

  getFileStatus({String? query}) async {
    _fileController.sink
        .add(await _fileRepository.getAllFileStatus(query: query));
  }

  addFileStatus(FileStatus fileStatus) async {
    await _fileRepository.insertFileStatus(fileStatus);
  }

  updateFileStatus(FileStatus fileStatus) async {
    await _fileRepository.updateFileStatus(fileStatus);
  }

  deleteFileStatusById(int id) {
    _fileRepository.deleteFileStatusById(id);
  }

  deleteAllFileStatus() {
    _fileRepository.deleteAllFileStatus();
  }

  dispose() {
    _fileController.close();
  }
}
