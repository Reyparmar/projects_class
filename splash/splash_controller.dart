import 'dart:async';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends AppBaseController {
  @override
  void onReady() {
    super.onReady();
    _runTimer();
  }

  void _runTimer() async {
    Timer(
      const Duration(seconds: 2),
      () async {
        bool isExpired = false;

        /// comment blow line for No Expiry App
        isExpired = DateTime.now().isAfter(DateTime.parse('2023-06-13 23:59:00.000'));

        if (isExpired) {
          SystemNavigator.pop();
        } else {
          final isLogin = await SharedPre.getBoolValue(SharedPre.isLogin);

          if (isLogin) {
            var obj = await SharedPre.getObjs(SharedPre.userData);
            UserData userdata = UserData.fromJson(obj);

            if (userdata.mobileVerifyStatus == 0) {
              Get.offAllNamed(AppRoutes.login);
            } else if (userdata.profileStatus == 0) {
              Get.offAllNamed(AppRoutes.home);
            } else {
              Get.offAllNamed(AppRoutes.home);
            }
          } else {
            Get.offAllNamed(AppRoutes.login);
          }
        }
      },
    );
  }
}
