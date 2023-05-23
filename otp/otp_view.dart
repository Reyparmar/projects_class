import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_bottom_button.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'otp_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      init: OtpController(),
      builder: (controller) => Scaffold(
        // backgroundColor: whiteBoxColor,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage(AppAssets.otpBg), fit: BoxFit.fill)),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: myAppBar(
                        title: 'OTP Verification',
                        onBackTap: () => controller.backTap(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Get.height * 0.15,
                bottom: 100,
                right: 0,
                left: 0,
                child: _otpBox(context, controller),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: controller.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: purpleColor),
                      )
                    : AppBottomButton(
                        onPressed: () {
                          controller.tapOnVerify(Get.arguments[1]);
                        },
                        name: 'Verify',
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _withContainer(BuildContext context, OtpController controller) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topBox(controller),
                  _bottomBox(context, controller),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _topBox(OtpController controller) {
    return Container(
      width: Get.width,
      height: Get.height * .16,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(45.0)),
        color: purpleColor,
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        children: [
          const SizedBox(width: 20),
          InkWell(
            onTap: () => controller.backTap(),
            child: Image.asset(
              AppAssets.backIcon,
              height: 28,
              width: 28,
              // fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Text(
              'OTP verification',
              style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

  Widget _bottomBox(BuildContext context, OtpController controller) {
    return Container(
      color: purpleColor,
      height: Get.height * .84,
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(45.0)),
          color: whiteBoxColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: _otpBox(context, controller),
            ),
            controller.isBusy
                ? const Center(
                    child: CircularProgressIndicator(color: purpleColor),
                  )
                : InkWell(
                    onTap: () {
                      controller.tapOnVerify(Get.arguments[1]);
                    },
                    child: Container(
                      width: Get.width,
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            grTopColor,
                            grBottomColor,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Verify',
                          style: const TextStyle().bold.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _otpBox(BuildContext context, OtpController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Text(
            controller.userData?.otp.toString() ?? '',
            style: const TextStyle().bold.copyWith(fontSize: 26, color: Colors.green),
          ),
          Text(
            'Enter code sent\nto your number',
            style: const TextStyle().bold.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                'we sent it to the number ',
                style: const TextStyle().bold.copyWith(fontSize: 14, color: msgTextColor),
              ),
              Text(
                Get.arguments?[0] ?? '9876543210',
                style: const TextStyle().bold,
              ),
            ],
          ),
          const SizedBox(height: 40),
          PinCodeTextField(
            appContext: context,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                inactiveColor: unselectedColor,
                // activeColor: voiletColor,
                selectedColor: purpleColor,
                borderRadius: BorderRadius.circular(5),
                // fieldHeight: 50,
                // fieldWidth: 55,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            controller: controller.otpController,
            keyboardType: TextInputType.number,
            textStyle: const TextStyle().bold.copyWith(fontSize: 41),
            onCompleted: (v) {
              if (kDebugMode) {
                print('Completed');
              }
            },
            onChanged: (value) {
              // setState(() {
              //   currentText = value;
              // });
            },
            beforeTextPaste: (text) {
              if (kDebugMode) {
                print('Allowing to paste $text');
              }
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                if (controller.enableResend) {
                  controller.resendCode();
                }
              },
              child: Text(
                !controller.enableResend
                    ? 'Resent code in 00:${controller.addZero()}${controller.secondsRemaining}'
                    : 'Resent Code',
                style: const TextStyle().bold.copyWith(
                      color: orangeColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
