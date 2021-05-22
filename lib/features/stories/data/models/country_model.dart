import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/country.dart';

class CountryModel extends Country {
  @override
  final String id, name, imageUrl;

  CountryModel({required this.id, required this.name, required this.imageUrl})
      : super(id: id, name: name, imageUrl: imageUrl);

  @override
  List<Object?> get props => [id, name, imageUrl];

  factory CountryModel.fromDoc(QueryDocumentSnapshot document) {
    return CountryModel(
        id: document.id,
        name: document['name'],
        imageUrl: document['imageUrl']);
  }

  /*Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imagePath': imagePath};
  }*/
}
