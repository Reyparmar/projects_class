import 'dart:async';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/response/otp_verify_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/login/login_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends AppBaseController {
  final LoginController loginController = Get.find<LoginController>();
  int secondsRemaining = 59;
  bool enableResend = false;
  Timer? timer;

  final TextEditingController otpController = TextEditingController();

  bool isOneMinuteDone = false;
  UserData? userData;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        update();
      } else {
        enableResend = true;
        update();
      }
    });
    super.onInit();
  }

  void getUserData() async {
    var obj = await SharedPre.getObjs(SharedPre.userData);
    userData = UserData.fromJson(obj);
  }

  void resendCode() async {
    secondsRemaining = 59;
    enableResend = false;
    update();
    await loginController.clickOnLogin();
    getUserData();
  }

  String addZero() {
    if (secondsRemaining < 10) {
      return '0';
    }
    return '';
  }

  void tapOnVerify(String password) async {
    setBusy(true);
    try {
      if (_validate()) {
        otpVerifyAPI(password);
      }
    } catch (e) {
      ShowMessage.showSnackBar('Catch', 'Something went wrong');
    } finally {
      setBusy(false);
    }
  }

  void otpVerifyAPI(String pass) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.mobileNo] = userData?.mobile.toString() ?? '';
      body[RequestKeys.password] = pass;
      body[RequestKeys.otp] = otpController.value.text;
      OtpVerifyResponse res = await api.otpVerify(body);
      if (res.status == 200) {
        loginController.mobileCtrl.clear();
        loginController.passwordCtrl.clear();
        UserData? userData = UserData();
        userData = res.data;
        SharedPre.setValue(SharedPre.userData, userData?.toJson());
        if (userData!.profileStatus == 0) {
          Get.offAndToNamed(AppRoutes.setupProfile);
        } else {
          Get.offAndToNamed(AppRoutes.home);
        }
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Catch Server Res', '$e');
    } finally {}
  }

  bool _validate() {
    if (otpController.value.text.isEmpty) {
      ShowMessage.showSnackBar('Field Empty', 'Please Enter OTP');
      return false;
    }
    return true;
  }
}
