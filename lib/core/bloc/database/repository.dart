import 'crud.dart';
import 'database.dart';

class FileRepository {
  final crud = Crud();

  Future getAllFileStatus({String? query}) => crud.getFileStatus(query: query);

  Future insertFileStatus(FileStatus fileStatus) =>
      crud.addFileStatus(fileStatus);

  Future updateFileStatus(FileStatus fileStatus) =>
      crud.updateFileStatus(fileStatus);

  Future deleteFileStatusById(int id) => crud.deleteFileStatus(id);

  //We are not going to use this in the demo
  Future deleteAllFileStatus() => crud.deleteAllFileStatus();
}
