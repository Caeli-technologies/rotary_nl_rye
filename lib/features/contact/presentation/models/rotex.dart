// 🌎 Project imports:
import 'package:rotary_nl_rye/core/presentation/models/image_list_tile_item.dart';
import 'package:rotary_nl_rye/features/contact/presentation/models/organization.dart';

class Rotex extends Organization {
  final String name;
  final List<String> role;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? linkedinUrl;
  final String? websiteUrl;
  final String? snapchatUrl;
  final String bio;
  final String imageUrl;
  final String? email;
  final String? phoneNumber;

  Rotex({
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.email,
    required this.phoneNumber,
    String? club,
    required this.role,
    this.facebookUrl,
    this.instagramUrl,
    this.websiteUrl,
    this.linkedinUrl,
    this.snapchatUrl,
    String? district,
  }) : super(
          name: name,
          bio: bio,
          imageUrl: imageUrl,
          club: '',
          district: '',
          email: email,
          functions: role,
          phoneNumber: phoneNumber,
        );
}
