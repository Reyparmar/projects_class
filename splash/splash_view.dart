
import 'package:digitalerp/screen/ui/splash/splash_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (ctrl) => Scaffold(
        body: Center(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(AppAssets.splashBg,fit: BoxFit.fill),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(AppAssets.appLogo,scale: 4),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
