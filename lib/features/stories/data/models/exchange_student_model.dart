import 'package:equatable/equatable.dart';

class ExchangeStudentModel extends Equatable {
  final int id;
  final String name, homeDistrict, hostDistrict, imagePath;

  ExchangeStudentModel(
      {required this.id,
      required this.name,
      required this.homeDistrict,
      required this.hostDistrict,
      required this.imagePath});

  @override
  List<Object?> get props => [id, name, homeDistrict, hostDistrict, imagePath];

  factory ExchangeStudentModel.fromJson(Map<String, dynamic> json) {
    return ExchangeStudentModel(
        id: (json['id'] as num).toInt(),
        name: json['name'],
        homeDistrict: json['homeDistrict'],
        hostDistrict: json['hostDistrict'],
        imagePath: json['imagePath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'homeDistrict': homeDistrict,
      'hostDistrict': hostDistrict,
      'imagePath': imagePath
    };
  }
}
