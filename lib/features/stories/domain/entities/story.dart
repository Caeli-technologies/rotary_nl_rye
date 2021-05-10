import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String country;
  final int arrivalDate;
  final int departureDate;
  final String imagePath;
  final String studentName;
  final String text1;
  final String text2;

  Story(
      {required this.country,
      required this.arrivalDate,
      required this.departureDate,
      required this.imagePath,
      required this.studentName,
      required this.text1,
      required this.text2});

  @override
  List<Object> get props => [
        country,
        arrivalDate,
        departureDate,
        imagePath,
        studentName,
        text1,
        text2
      ];
}
