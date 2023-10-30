import 'package:faircare/widgets/calendar_week_day.dart';
import 'package:flutter/material.dart';

class VacationCalendarWeekDays extends StatelessWidget {
  const VacationCalendarWeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AbsorbPointer(
      absorbing: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CalendarWeekDay('Mo', 1),
          CalendarWeekDay('Di', 2),
          CalendarWeekDay('Mi', 3),
          CalendarWeekDay('Do', 4),
          CalendarWeekDay('Fr', 5),
          CalendarWeekDay('Sa', 6),
          CalendarWeekDay('So', 7),
        ],
      ),
    );
  }
}