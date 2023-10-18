import 'dart:math';

import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/calendar_day_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
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
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
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

          Positioned(
            top: -0.35,
            right: -0.35,
            left: -0.35,
            bottom: -0.35,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColor(state),
                  width: 0.7,
                ),
              ),
            ),
          ),

          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: getDateColor(state),
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
          Positioned(
            top: -0.35,
            right: -0.35,
            left: -0.35,
            bottom: -0.35,
            child: Container(
              decoration: BoxDecoration(
                color: MyColors.border,
                border: Border.all(
                  color: MyColors.grey,
                  width: 0.7,
                ),
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
