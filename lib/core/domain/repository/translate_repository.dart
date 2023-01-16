import 'dart:ui';

abstract class TranslateRepository {
  Future<String?> getTranslation(String text, {Locale? sourceLang, Locale? targetLang});
}
