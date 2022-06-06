// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/image.dart';

abstract class HeaderImageRepository {
  Stream<HeaderImage> get headerImage;

  Future<void> dispose();
}
