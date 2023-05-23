import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Duration duration = Duration(milliseconds: 300);

class AppRoutes {
  static back() => Get.back();

  static to(Widget screen) => Get.to(
        () => screen,
        transition: Transition.rightToLeft,
        duration: duration,
      );

  static toArguments(Widget screen, List arguments) => Get.to(() => screen,
      transition: Transition.rightToLeft,
      duration: duration,
      arguments: arguments);

  static off(Widget screen) => Get.off(
        () => screen,
        transition: Transition.rightToLeft,
        duration: duration,
      );

  static offAll(dynamic screen) => Get.offAll(
        () => screen,
        transition: Transition.rightToLeft,
        duration: duration,
      );
}
