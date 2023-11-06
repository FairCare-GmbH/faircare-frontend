import 'package:faircare/widgets/calendar_week_day.dart';
import 'package:flutter/material.dart';

class MyCalendarWeekDays extends StatelessWidget {
  final bool isVacationPlanner;

  const MyCalendarWeekDays({this.isVacationPlanner = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalendarWeekDay('Mo', 1, isVacationPlanner),
        CalendarWeekDay('Di', 2, isVacationPlanner),
        CalendarWeekDay('Mi', 3, isVacationPlanner),
        CalendarWeekDay('Do', 4, isVacationPlanner),
        CalendarWeekDay('Fr', 5, isVacationPlanner),
        CalendarWeekDay('Sa', 6, isVacationPlanner),
        CalendarWeekDay('So', 7, isVacationPlanner),
      ],
    );
  }
}
