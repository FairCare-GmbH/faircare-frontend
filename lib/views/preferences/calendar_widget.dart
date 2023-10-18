import 'dart:math';

import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
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
          children: const [
            DayItem('Mo', color: MyColors.green),
            DayItem('Di'),
            DayItem('Mi', color: MyColors.red),
            DayItem('Do'),
            DayItem('Fr'),
            DayItem('Sa', color: MyColors.prime),
            DayItem('So'),
          ],
        ),
        TableCalendar(
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          focusedDay: DateTime.now(),
          rowHeight: 54,
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
      ],
    );
  }

  final list = [
    ...List.generate(
      31,
      (index) => {
        'type': Random().nextInt(4), // f, s, fs etc
        'state': Random().nextInt(4), // free, vacation etc
      },
    ),
  ];

  final tours = [
    ...List.generate(31, (index) => ['F', 'S', 'FS', 'U'][Random().nextInt(4)]),
  ];

  Color getColor(int state) {
    if (state == 0) return MyColors.darkGrey;
    if (state == 1) return MyColors.green;
    if (state == 2) return MyColors.prime;
    if (state == 3) return MyColors.red;
    return MyColors.border;
  }

  Widget? myCalendarBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    final item = list[day.day - 1];
    final type = item['type']!;
    final state = item['state']!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: getColor(state),
        ),
      ),
      child: Stack(
        children: [
          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: MyColors.black,
                fontSize: 16,
              ),
            ),
          ),

          // S
          if (type == 2 || type == 3)
            Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(
                painter: TopRightTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if (type == 2 || type == 3)
            Positioned(
              top: 0,
              right: 0,
              child: Text(
                'S',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),

          // U
          if (type == 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomPaint(
                painter: BottomRightTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if (type == 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                'U',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),

          // F
          if (type == 1 || type == 3)
            Positioned(
              bottom: 0,
              left: 0,
              child: CustomPaint(
                painter: BottomLeftTriangle(getColor(state)),
                child: Container(height: 18),
              ),
            ),
          if (type == 1 || type == 3)
            Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                'F',
                style: style(color: MyColors.white, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }

  Widget? myOutsideBuilder(
      BuildContext context, DateTime day, DateTime focusedDay) {
    return Container();
  }
}

class DayItem extends StatelessWidget {
  const DayItem(this.text, {this.color, Key? key}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: style(
              color: color == null ? MyColors.darkGrey : MyColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class TopRightTriangle extends CustomPainter {
  final Color color;

  TopRightTriangle(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - size.height, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BottomRightTriangle extends CustomPainter {
  final Color color;

  BottomRightTriangle(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BottomLeftTriangle extends CustomPainter {
  final Color color;

  BottomLeftTriangle(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = color;
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.height, size.height);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
