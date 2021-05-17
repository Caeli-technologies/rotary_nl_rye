import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String id, name, imageUrl;

  Country({required this.id, required this.name, required this.imageUrl});

  @override
  List<Object?> get props => [id, name, imageUrl];
}
