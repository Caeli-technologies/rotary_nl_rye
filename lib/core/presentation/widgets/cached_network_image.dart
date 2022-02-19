import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedNetworkImageRotary extends StatelessWidget {
  final String imageUrl;

  const CachedNetworkImageRotary({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    var key = 'customCacheKey';
    return CachedNetworkImage(
      // height: 55,
      // width: 55,
      imageUrl: imageUrl,
      cacheManager: CacheManager(
        Config(
          key,
          stalePeriod: const Duration(microseconds: 10),
          maxNrOfCacheObjects: 20,
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        // decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(14),
        //       image: DecorationImage(
        //           image: imageProvider, fit: BoxFit.contain),
        //     ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
