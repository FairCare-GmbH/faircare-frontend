import 'dart:math';

import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/calendar_day_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
