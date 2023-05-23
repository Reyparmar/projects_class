import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends AppBaseController {
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final FocusNode mobileFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool isShowPassword = true;

  Future<void> clickOnLogin() async {
    mobileFocus.unfocus();
    passwordFocus.unfocus();
    String? deviceID = await getDeviceIdentifier();
    setBusy(true);
    try {
      if (_isValidate()) {
        Map<String, String> body = {};
        body[RequestKeys.mobile] = mobileCtrl.text.trim();
        body[RequestKeys.password] = passwordCtrl.text.trim();
        body[RequestKeys.deviceId] = deviceID ?? 'abcde874556';
        LoginResponse res = await api.loginApi(body);
        if (res.status == 200) {
          UserData? userData = UserData();
          userData = res.data;
          SharedPre.setValue(SharedPre.userData, userData?.toJson());
          SharedPre.setValue(SharedPre.isLogin, true);
          if (userData?.mobileVerifyStatus == 0) {
            Get.toNamed(AppRoutes.otp, arguments: [mobileCtrl.text.trim(), passwordCtrl.text.trim()]);
          } else if (userData?.profileStatus == 0) {
            Get.offAndToNamed(AppRoutes.setupProfile);
          } else {
            mobileCtrl.clear();
            passwordCtrl.clear();
            Get.offAndToNamed(AppRoutes.home);
          }
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  void tapOnShowPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  bool _isValidate() {
    if (mobileCtrl.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterMobileTxt.tr,
      );
      return false;
    }
    if (passwordCtrl.text.isEmpty) {
      ShowMessage.showSnackBar(
        AppString.requiredFieldTxt.tr,
        AppString.pleaseEnterPasswordTxt.tr,
      );
      return false;
    }
    return true;
  }

  void tapOnForgotPassword() {
    mobileFocus.unfocus();
    passwordFocus.unfocus();
    Get.toNamed(AppRoutes.forgotPassword)?.then((value) {
      mobileCtrl.clear();
      passwordCtrl.clear();
      return null;
    });
  }
}
