import 'package:flutter/material.dart';
import 'package:mate/src/utils/app_extentions.dart';
import 'package:mate/src/utils/constants.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnName;
  final double? textSize;
  final double? btnRadius;
  final Color? color, textColor;
  final double? height, width;
  final TextStyle? textStyle;

  const AppButton(
      {Key? key,
      required this.onPressed,
      required this.btnName,
      this.textSize,
      this.textStyle,
      this.textColor,
      this.btnRadius,
      this.color,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(btnRadius ?? 0),
          color: color ?? AppColor.purpleColor,
        ),
        height: height,
        padding: EdgeInsets.all(5),
        width: width,
        alignment: Alignment.center,
        child: Text(
          btnName,
          style: textStyle ?? TextStyle().bold.copyWith(fontSize: textSize ?? 20, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
