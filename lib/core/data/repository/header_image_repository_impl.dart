import 'dart:async';
import 'dart:convert';

import 'package:rotary_nl_rye/core/data/datasources/cache.dart';
import 'package:rotary_nl_rye/core/data/datasources/config.dart';
import 'package:rotary_nl_rye/core/data/datasources/firestore.dart';
import 'package:rotary_nl_rye/core/domain/entities/image.dart';
import 'package:rotary_nl_rye/core/domain/repository/header_image_repository.dart';

import '../initData.dart';

class HeaderImageRepositoryImpl implements HeaderImageRepository{
  final _controller = StreamController<HeaderImage>.broadcast();
  final Cache cache = new Cache();

  @override
  get headerImage => _controller.stream;

  @override
  Future<void> dispose() async {
    await _controller.close();
  }

  Future<HeaderImage> getHeaderImageData() async {
    await Repo().initData('', '');

    HeaderImage headerImage = await getCachedHeaderImage();
    _controller.sink.add(headerImage);

    return headerImage;
  }

  Future<HeaderImage> getCachedHeaderImage() async {
    final HeaderImage headerImage = json.decode(await cache.getByKey(Config.spImageHeaderKey));
    return headerImage;
  }

  Future<void> cacheImageHeader() async {
    final String url = await FireStoreUrls.getUrl(Config.fbImageHeaderKey);

    await cache.store(Config.spImageHeaderKey, url);
  }
}