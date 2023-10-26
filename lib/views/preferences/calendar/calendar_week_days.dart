import 'package:faircare/widgets/calendar_day_item.dart';
import 'package:flutter/material.dart';

class MyCalendarWeekDays extends StatelessWidget {
  const MyCalendarWeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalendarWeekDay('Mo'),
        CalendarWeekDay('Di'),
        CalendarWeekDay('Mi'),
        CalendarWeekDay('Do'),
        CalendarWeekDay('Fr'),
        CalendarWeekDay('Sa'),
        CalendarWeekDay('So'),
      ],
    );
  }
}
