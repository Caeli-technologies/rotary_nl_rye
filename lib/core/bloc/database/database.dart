class FileStatus {
  int? id;
  String fileName;
  bool isLocal = false;
  DateTime? lastFetch;

  FileStatus(
      {this.id, required this.fileName, this.isLocal = false, this.lastFetch});

  factory FileStatus.fromDatabaseJson(Map<String, dynamic> data) => FileStatus(
        id: data['id'],
        fileName: data['fileName'],
        //Since sqlite doesn't have boolean type for true/false
        //we will 0 to denote that it is false
        //and 1 for true
        isLocal: data['is_Local'] == 0 ? false : true,
        lastFetch: DateTime.parse(data['lastFetch']),
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "fileName": this.fileName,
        "is_Local": this.isLocal == false ? 0 : 1,
        "lastFetch": this.lastFetch.toString()
      };
}
