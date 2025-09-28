// 🎯 Dart imports:
import 'dart:io';

class HeaderImage {
  final File image;

  HeaderImage({required this.image});

  factory HeaderImage.fromFile(File file) => HeaderImage(image: file);
}
