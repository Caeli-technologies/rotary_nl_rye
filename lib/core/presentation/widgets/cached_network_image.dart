import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rotary_nl_rye/core/data/initData.dart';

class CachedNetworkImageRotary extends StatelessWidget {
  final String imageUrl;

  CachedNetworkImageRotary({Key? key, required this.imageUrl})
      : super(key: key);

  final CacheManager cacheManager = new CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(microseconds: 10),
    maxNrOfCacheObjects: 20,
  ));

  bool _tooOld = false;

  @override
  void initState() {
    Repo().isTooOld().then((ob) => _tooOld = ob);
    if (_tooOld) {
      cacheManager.emptyCache();
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return CachedNetworkImage(
      // height: 55,
      // width: 55,
      imageUrl: imageUrl,
      cacheManager: cacheManager,
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
