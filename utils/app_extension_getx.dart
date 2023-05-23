import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnfromblogs/utility/app_colors.dart';
import 'package:learnfromblogs/utility/app_fonts.dart';
import 'package:sizer/sizer.dart';

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String formatted({String? format}) {
    return DateFormat(format ?? 'dd MMM yyyy, hh:mm a')
        .format(
          DateTime.parse(this.toString()).toLocal(),
        )
        .toString();
  }
}

extension TextStyles on TextStyle {
  TextStyle get bold => TextStyle(
        fontFamily: AppFonts.latoBold,
        color: AppColor.darkBlueColor,
        fontSize: 12.sp,
        decoration: TextDecoration.none,
      );

  TextStyle get regular => TextStyle(
        fontFamily: AppFonts.latoRegular,
        color: AppColor.darkBlueColor,
        fontSize: 12.sp,
        decoration: TextDecoration.none,
      );

  TextStyle get light => TextStyle(
        fontFamily: AppFonts.latoLight,
        color: AppColor.darkBlueColor,
        fontSize: 12.sp,
        decoration: TextDecoration.none,
      );

  TextStyle get italic => TextStyle(
        fontFamily: AppFonts.latoItalic,
        color: AppColor.darkBlueColor,
        fontSize: 12.sp,
        decoration: TextDecoration.none,
      );
}
