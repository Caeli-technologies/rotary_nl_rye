// class CountryModel extends Equatable {
//   final int id;
//   final String name, imagePath;
//
//   CountryModel({required this.id, required this.name, required this.imagePath});
//
//   @override
//   List<Object?> get props => [id, name, imagePath];
//
//   factory CountryModel.fromJson(Map<String, dynamic> json) {
//     return CountryModel(
//         id: (json['id'] as num).toInt(),
//         name: json['name'],
//         imagePath: json['imagePath']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'id': id, 'name': name, 'imagePath': imagePath};
//   }
//}
