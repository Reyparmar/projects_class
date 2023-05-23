import 'package:flutter/material.dart';
import 'package:mate/src/utils/constants.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColor.purpleColor,
      ),
    );
  }
}
