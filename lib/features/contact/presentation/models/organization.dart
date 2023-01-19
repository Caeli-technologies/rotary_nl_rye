// 🌎 Project imports:
import 'contact.dart';

class Organization extends Contact {
  final String district;
  final String club;
  final List<String> functions;

  Organization({
    required String name,
    required String bio,
    required String imageUrl,
    String? email,
    String? phoneNumber,
    required this.club,
    required this.functions,
    required this.district,
  }) : super(
          name: name,
          bio: bio,
          imageUrl: imageUrl,
          email: email,
          phoneNumber: phoneNumber,
        );
}
