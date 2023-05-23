import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mate/src/utils/app_extentions.dart';

class TimerWidget extends StatefulWidget {
  final int timeInMinute;
  final double? textSize;
  final Color? color;

  const TimerWidget({
    Key? key,
    required this.timeInMinute,
    this.textSize,
    this.color,
  }) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;
  int? time;

  @override
  void initState() {
    time = widget.timeInMinute;
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          time = (time ?? 1) - 1;
          print("-----------------------------${DateTime.now()}--------");
          print("-----------------------------${time}--------");
        });
      }
    });
    super.initState;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Auto Checkout In:',
          style: TextStyle().bold.copyWith(
                fontSize: 8,
              ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '$time Minute',
          style: TextStyle().medium.copyWith(
                fontSize: 8,
              ),
        ),
      ],
    );
  }
}
