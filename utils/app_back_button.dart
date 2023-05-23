import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppBackButton({Key? key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon ?? Icons.arrow_back_rounded,
        color: Colors.transparent,
        size: 32.0,
      ),
      onPressed: () {
        if (onPressed == null) {
          Get.back();
        } else {
          onPressed!();
        }
      },
    );
  }
}
