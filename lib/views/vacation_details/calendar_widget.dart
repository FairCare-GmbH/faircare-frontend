import 'dart:math';

import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/calendar_day_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class VacationDetailsCalendarWidget extends StatefulWidget {
  const VacationDetailsCalendarWidget({Key? key}) : super(key: key);

  @override
  State<VacationDetailsCalendarWidget> createState() =>
      _VacationDetailsCalendarWidgetState();
}

class _VacationDetailsCalendarWidgetState
    extends State<VacationDetailsCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Oktober 2023',
                style: style(
                  fontSize: 16,
                  color: MyColors.prime,
                ),
              ),
            ),
            const Icon(Icons.chevron_left),
            const HorizontalSpacer(12),
            const Icon(Icons.chevron_right),
          ],
        ),
        const VerticalSpacer(12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CalendarWeekDay('Mo', color: MyColors.green),
            CalendarWeekDay('Di'),
            CalendarWeekDay('Mi', color: MyColors.red),
            CalendarWeekDay('Do'),
            CalendarWeekDay('Fr'),
            CalendarWeekDay('Sa', color: MyColors.prime),
            CalendarWeekDay('So'),
          ],
        ),
        SizedBox(
          width: 350,
          child: TableCalendar(
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: DateTime.now(),
            rowHeight: 50,
            headerVisible: false,
            availableGestures: AvailableGestures.horizontalSwipe,
            onPageChanged: (focusedDay) {},
            calendarBuilders: CalendarBuilders(
              defaultBuilder: myCalendarBuilder,
              holidayBuilder: myCalendarBuilder,
              todayBuilder: myCalendarBuilder,
              selectedBuilder: myCalendarBuilder,
              outsideBuilder: myOutsideBuilder,
            ),
            daysOfWeekVisible: false,
            onDaySelected: (selectedDay, focusedDay) {},
          ),
        ),
      ],
    );
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

  Color getColor(int state) {
    if (state == 0) return MyColors.border;
    if (state == 1) return MyColors.green;
    if (state == 2) return MyColors.prime;
    if (state == 3) return MyColors.red;
    if (state == 4) return MyColors.darkGrey;
    return MyColors.border;
  }

  Color getBgColor(int state) {
    if (state == 0) return MyColors.white;
    if (state == 1) return MyColors.green.withOpacity(0.2);
    if (state == 2) return MyColors.prime.withOpacity(0.2);
    if (state == 3) return MyColors.red.withOpacity(0.2);
    if (state == 4) return MyColors.white;
    return MyColors.white;
  }

  Color getDateColor(int state) {
    if (state == 0) return MyColors.darkGrey;
    if (state == 1) return MyColors.green;
    if (state == 2) return MyColors.prime;
    if (state == 3) return MyColors.red;
    if (state == 4) return MyColors.darkGrey;
    return MyColors.darkGrey;
  }

  Widget? myCalendarBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final item = list[day.day - 1];
    final date = item['date']!;
    final type = item['type']!;
    final state = item['state']!;

    return SizedBox(
      width: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // S
          if ((type == 2 || type == 3) && state != 0)
            Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(
                painter: TopRightTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if ((type == 2 || type == 3) && state != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Text(
                'S',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),

          // U
          if ((type == 0) && state != 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomPaint(
                painter: BottomRightTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if ((type == 0) && state != 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                'U',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),

          // F
          if ((type == 1 || type == 3) && state != 0)
            Positioned(
              bottom: 0,
              left: 0,
              child: CustomPaint(
                painter: BottomLeftTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if ((type == 1 || type == 3) && state != 0)
            Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                'F',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),

          Container(
            decoration: BoxDecoration(
              color: date == 29 || date == 31
                  ? MyColors.blueGreyDark
                  : date == 30
                      ? MyColors.blueGrey
                      : getBgColor(state),
              border: Border.all(
                color: getColor(state),
                width: 0.1,
              ),
            ),
          ),

          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: date == 29 || date == 30 || date == 31
                    ? MyColors.white
                    : getDateColor(state),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? myOutsideBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return SizedBox(
      width: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.border,
              border: Border.all(
                color: MyColors.grey,
                width: 0.1,
              ),
            ),
          ),

          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: MyColors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
