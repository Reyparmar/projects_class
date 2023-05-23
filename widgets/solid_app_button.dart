import 'package:flutter/material.dart';
import 'package:mate/src/utils/app_extentions.dart';
import 'package:mate/src/utils/constants.dart';
import 'package:sizer/sizer.dart';

class SolidAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String btnName;
  final double? textSize, btnRadius, height, width, elevation;
  final EdgeInsetsGeometry? padding;
  final Color? color, textColor;
  final TextStyle? textStyle;

  const SolidAppButton(
      {Key? key,
      required this.onPressed,
      required this.btnName,
      this.textSize,
      this.textStyle,
      this.textColor,
      this.btnRadius,
      this.padding,
      this.color,
      this.width,
      this.height,
      this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColor.purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            btnRadius ?? 0,
          ),
        ),
        elevation: elevation ?? 0,
      ),
      child: Container(
        width: width ?? 100.w,
        height: height,
        padding: padding ?? EdgeInsets.all(14),
        child: Text(
          btnName,
          style: textStyle ??
              TextStyle().bold.copyWith(
                    fontSize: textSize ?? 20,
                    color: textColor ?? Colors.white,
                  ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
