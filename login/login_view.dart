import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: whiteBoxColor,
        body: LayoutBuilder(
          builder: (context, constraint) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    headerPart(),
                    Expanded(child: loginCard(controller)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerPart() {
    return Container(
      height: Get.height * .40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(45.0)),
        color: purpleColor,
      ),
      child: Center(
        child: SizedBox(
          height: 90,
          width: 90,
          child: Image.asset(
            AppAssets.appLogo,
            // fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget loginCard(LoginController controller) {
    return Container(
      color: purpleColor,
      height: Get.height * .60,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0)),
          color: whiteBoxColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Your\nMobile Number',
                      style: const TextStyle().bold.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We will send you a confirmation code',
                      style: const TextStyle().bold.copyWith(fontSize: 14, color: msgTextColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: const TextStyle().normal,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: controller.mobileCtrl,
                      focusNode: controller.mobileFocus,
                      maxLength: 10,
                      decoration: const InputDecoration()
                          .txtFieldStyle2(
                              hintText: 'Enter number',
                              labelName: 'Enter mobile number',
                              labelColor: darkGreenColor)
                          .copyWith(
                            suffixIcon: SizedBox(
                              height: 45,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Image.asset(
                                  AppAssets.callIcon,
                                  width: 14,
                                  height: 14,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              minHeight: 50,
                              maxHeight: 50,
                            ),
                          ),
                    ),
                    TextFormField(
                      style: const TextStyle().light,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: controller.passwordCtrl,
                      focusNode: controller.passwordFocus,
                      decoration: const InputDecoration()
                          .txtFieldStyle2(
                              hintText: 'Enter Password',
                              labelName: 'Password',
                              labelColor: darkGreenColor)
                          .copyWith(
                              suffixIcon: SizedBox(
                                height: 45,
                                child: InkWell(
                                  onTap: () => controller.tapOnShowPassword(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Icon(
                                        controller.isShowPassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: unselectedColor),
                                  ),
                                ),
                              ),
                              suffixIconConstraints:
                                  const BoxConstraints(minHeight: 50, maxHeight: 50)),
                      obscureText: controller.isShowPassword,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () =>controller.tapOnForgotPassword(),
                        child: Text(
                          'Forgot password?',
                          style: const TextStyle().normal.copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.isBusy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: purpleColor,
                    ),
                  )
                : InkWell(
                    onTap: () => controller.clickOnLogin(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              grTopColor,
                              grBottomColor,
                            ],
                          )),
                      child: Center(
                        child: Text(
                          'Login',
                          style: const TextStyle().bold.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
