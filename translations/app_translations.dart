import 'en_US/en_us_translations.dart';
import 'es_ES/es_es_translations.dart';
import 'hi_IN/hi_in_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translationsKeys = {
    'en_US': enUs,
    'hi_IN': hiIn,
    'es_ES': esES
  };
}
