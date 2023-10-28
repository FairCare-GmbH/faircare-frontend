import 'dart:math';

import 'package:flutter/material.dart';

class VacationCalendarWidget extends StatefulWidget {
  const VacationCalendarWidget({Key? key}) : super(key: key);

  @override
  State<VacationCalendarWidget> createState() => _VacationCalendarWidgetState();
}

class _VacationCalendarWidgetState extends State<VacationCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  final list = [
    ...List.generate(
      31,
      (i) => {
        'date': i + 1,
        'type': Random().nextInt(4), // f, s, fs etc
        'state': Random().nextInt(5), // free, vacation etc
      },
    ),
  ];
}
