// 🎯 Dart imports:
import 'dart:async';

// 🌎 Project imports:
import 'package:rotary_nl_rye/core/domain/entities/image.dart';

abstract class HeaderImageRepository {
  Future<HeaderImage?> get headerImage;
}
