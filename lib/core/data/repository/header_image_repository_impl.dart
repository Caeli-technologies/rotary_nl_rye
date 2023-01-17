// 🎯 Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

// 📦 Package imports:
import 'package:path_provider/path_provider.dart';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/data/datasources/url_provider.dart';
import 'package:rotary_nl_rye/core/domain/entities/image.dart';
import 'package:rotary_nl_rye/core/domain/repository/header_image_repository.dart';
import '../datasources/http.dart';

class HeaderImageRepositoryImpl implements HeaderImageRepository {
  @override
  Future<HeaderImage?> get headerImage async {
    File? file =
    await _getHeaderImageDataLocal();
    if (file == null) {
      final Uint8List? rawData = await _getHeaderImageDataRemote();
      if (rawData == null) {
        return null;
      }
      file = await _cacheHeaderImage(rawData);
    }
    return _parseRaw(file);
  }

  Future<Uint8List?> _getHeaderImageDataRemote() async {
    return await ApiResponse.getFileContent(
        await UrlProvider.getExchangeStudentUrl());
  }

  Future<File?> _getHeaderImageDataLocal() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    return await File(documentDirectory.path + '/images/headerImage.png');
  }

  Future<File> _cacheHeaderImage(final Uint8List bytes) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final File file = new File(documentDirectory.path + '/images/headerImage.png');
    file.writeAsBytesSync(bytes);
    return file;
  }

  HeaderImage _parseRaw(final File file) {
    return HeaderImage(image: file);
  }
}
