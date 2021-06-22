import 'crud.dart';
import 'database.dart';

class FileRepository {
  final crud = Crud();

  Future<List<FileStatus>> getAllFileStatus({String? query}) =>
      crud.getFileStatus(query: query);

  Future<int> insertFileStatus(FileStatus fileStatus) =>
      crud.addFileStatus(fileStatus);

  Future<int> updateFileStatus(FileStatus fileStatus) =>
      crud.updateFileStatus(fileStatus);

  Future<int> deleteFileStatusById(int id) => crud.deleteFileStatus(id);

  //We are not going to use this in the demo
  Future deleteAllFileStatus() => crud.deleteAllFileStatus();
}
