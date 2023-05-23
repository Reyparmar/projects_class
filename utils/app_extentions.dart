import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mate/repository/auth_service/firebase_auth_service.dart';
import 'package:mate/repository/chat_service/firestore_service.dart';
import 'package:mate/repository/model/get_user_profile_response.dart';
import 'package:mate/src/utils/shared_pre.dart';

import 'constants.dart';

extension TextStyles on TextStyle {
  TextStyle get medium => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Medium',
      );

  TextStyle get bold => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Bold',
        fontWeight: FontWeight.w800,
      );

  TextStyle get Regular => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'Regular',
      );

  TextStyle get light => const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 16,
        fontFamily: 'Regular',
      );

  TextStyle get italic => const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontSize: 16,
        fontFamily: 'Regular',
      );

  TextStyle get semiBold => const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontFamily: 'SemiBold',
      );

  TextStyle get cabinSketchBold => const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'cabinSketchBold',
      );
}

extension InputDec on InputDecoration {
  InputDecoration txtFieldStyle({
    required String hintText,
    required String labelName,
  }) =>
      InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(
          15,
          15,
          15,
          15,
        ),
        constraints: const BoxConstraints(
          minHeight: 30,
        ),
        filled: true,
        counter: const Offstage(),
        fillColor: AppColor.btnColor,
        hintText: hintText,
        hintStyle: TextStyle().bold.copyWith(
              color: AppColor.hintTxtColor,
            ),
        labelText: labelName,
        labelStyle: const TextStyle().bold,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
          borderSide: BorderSide(
            color: AppColor.txtFieldColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
          borderSide: BorderSide(
            color: AppColor.txtFieldColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
          borderSide: BorderSide(
            color: AppColor.txtFieldColor,
          ),
        ),
      );

  InputDecoration searchTxtFieldStyle({
    double? maxHeight,
    double? iconSize,
    String? hint,
  }) =>
      InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 23,
        ),
        constraints: BoxConstraints(
          minHeight: maxHeight ?? 60,
          maxHeight: maxHeight ?? 60,
        ),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.transparent,
        hintText: hint ?? 'Search',
        hintStyle: const TextStyle().bold.copyWith(
              fontSize: 14,
              color: AppColor.hintTxtColor,
            ),
        // suffixIcon: Container(
        //     margin: const EdgeInsets.only(right: 10), child: Image.asset(AppAssets.searchIcon)),
        suffixIconConstraints: BoxConstraints(
          minWidth: 40,
          minHeight: 14,
          maxWidth: 40,
          maxHeight: iconSize ?? 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      );

  InputDecoration txtFieldStyle2({required String hintText}) => InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle().bold.copyWith(
              fontSize: 20,
              color: AppColor.textColor,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '\u{20B9} ',
            style: TextStyle().bold.copyWith(
                  fontSize: 20,
                  color: AppColor.textColor,
                ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      );

  InputDecoration txtFieldStyle5({required String hintText}) => InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle().bold.copyWith(
              fontSize: 20,
              color: AppColor.textColor,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.black,
          ),
        ),
      );

  InputDecoration profileTxtField(
          {required String hintText,
          required String labelName,
          required String icon,
          Color? iconColor,
          bool? bottomAlwaysPurple}) =>
      InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
        constraints: const BoxConstraints(
          minHeight: 45,
        ),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Light',
          fontSize: 13,
          color: AppColor.hintTxtColor,
          fontWeight: FontWeight.w300,
        ),
        labelText: labelName,
        labelStyle: const TextStyle().Regular.copyWith(
              fontSize: 12,
            ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Image.asset(
            icon,
            color: iconColor,
            height: 30,
            width: 16,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 30,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: bottomAlwaysPurple ?? false ? AppColor.purpleColor : AppColor.hintTxtColor,
            width: 1.25,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: bottomAlwaysPurple ?? false ? AppColor.purpleColor : AppColor.hintTxtColor,
            width: 1.25,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.25,
          ),
        ),
      );

  InputDecoration iconTxtFieldStyle(
          {double? iconSize, String? hint, required IconData icon, required VoidCallback onSendTap}) =>
      InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.white,
        hintText: hint ?? 'Search',
        hintStyle: const TextStyle().medium.copyWith(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
        suffixIcon: InkWell(
          onTap: onSendTap,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Icon(
                icon,
                color: AppColor.redColor,
              ),
            ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
        ),
      );

  InputDecoration txtFieldStyle3(
          {required String hintText, required String labelName, Color? labelColor, bool? bottomAlwaysPurple}) =>
      InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(
          5,
          15,
          5,
          10,
        ),
        constraints: const BoxConstraints(
          minHeight: 45,
        ),
        filled: true,
        counter: const Offstage(),
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Light',
          fontSize: 13,
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      );
}

void unfocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatDate(String date, String format, String expectFormat, {bool? isUtc}) {
  if (date.isEmpty || date.toLowerCase() == 'null') return 'N/A';
  DateTime parse = DateFormat(format).parse(date, isUtc ?? false);
  return DateFormat(expectFormat).format(parse.toLocal());
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 2) {
      return ('${(difference.inDays / 7).floor()} week ago');
    } else if ((difference.inDays / 7).floor() == 1) {
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
}

void logoutCall() async {
  final data = await SharedPre.getObj(SharedPre.userProfile);
  final user = GetUserProfileData.fromJson(data);
  FireStoreService.instance.userLogout(userId: user.id ?? '');
  SharedPre.clearAll();
  FirebaseAuthService().signOut();
}
