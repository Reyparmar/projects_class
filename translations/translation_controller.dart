import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnfromblogs/utility/preferences_management.dart';

class TranslationController extends GetxController {
  final languageTranslation = GetStorage();

  String get languageCode =>
      languageTranslation.read(PMKeys.languageCode.toString()) ?? 'en';
  String get countryCode =>
      languageTranslation.read(PMKeys.countryCode.toString()) ?? 'US';

  void changeLanguage(var languageCode, var countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);

    languageTranslation.write(PMKeys.languageCode.toString(), languageCode);
    languageTranslation.write(PMKeys.countryCode.toString(), countryCode);
  }
}
