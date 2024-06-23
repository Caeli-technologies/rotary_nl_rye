// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class UniformCircleAvatar extends StatelessWidget {
  const UniformCircleAvatar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 55,
      width: 55,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SkeletonAvatar(
        style: SkeletonAvatarStyle(shape: BoxShape.circle),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
