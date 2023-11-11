import 'package:faircare/widgets/calendar_week_day.widget.dart';
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
        CalendarWeekDayWidget('Mo', 1, isVacationPlanner),
        CalendarWeekDayWidget('Di', 2, isVacationPlanner),
        CalendarWeekDayWidget('Mi', 3, isVacationPlanner),
        CalendarWeekDayWidget('Do', 4, isVacationPlanner),
        CalendarWeekDayWidget('Fr', 5, isVacationPlanner),
        CalendarWeekDayWidget('Sa', 6, isVacationPlanner),
        CalendarWeekDayWidget('So', 7, isVacationPlanner),
      ],
    );
  }
}
