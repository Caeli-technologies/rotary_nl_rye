import 'package:rotary_nl_rye/core/presentation/widgets/image_list_tile.dart';

class Person extends ReboundsStudentsListTile {
  final String name;
  final String description;
  final String bio;
  final String place;
  final String imageUrl;
  final String email;
  final String phoneNumber;
  final Map<String, dynamic> exchangeInfo;
  Person(
      {required this.name,
      required this.description,
      required this.bio,
      required this.place,
      required this.imageUrl,
      required this.email,
      required this.phoneNumber,
      required this.exchangeInfo});
}
