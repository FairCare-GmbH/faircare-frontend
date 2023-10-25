import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/widgets/calendar_day_item.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<PreferencesCalendarCubit, PreferencesCalendarState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PreferencesCalendarCubit>(context);

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${state.month} ${state.dateTime.year}',
                    style: style(
                      fontSize: 16,
                      color: MyColors.prime,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => cubit.previousMonth(),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.chevron_left),
                  ),
                ),
                InkWell(
                  onTap: () => cubit.nextMonth(),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.chevron_right),
                  ),
                ),
              ],
            ),
            const VerticalSpacer(4),
            const Row(
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
            ),
            SizedBox(
              width: 350,
              child: TableCalendar(
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: state.dateTime,
                rowHeight: 50,
                headerVisible: false,
                availableGestures: AvailableGestures.horizontalSwipe,
                onPageChanged: (focusedDay) {
                  cubit.setMonth(focusedDay);
                },
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
      },
    );
  }

  final list = [
    ...List.generate(
      31,
      (i) {
        int dayOfWeek = (i + 1) % 7;
        if (dayOfWeek == 0) dayOfWeek = 7;

        return CalendarModel(
          id: i,
          nurseId: i,
          fromDate: DateTime(2023, 10, i + 1),
          toDate: DateTime(2023, 10, i + 1),
          dayOfWeek: dayOfWeek,
          tourType: 0,
          hasAssignedTour: true,
        );
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
    final type = item.tourType;
    // final state = item['state']!;

    return SizedBox(
      width: 50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // S
          if ((type == 2 || type == 3))
            Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(
                painter: TopRightTriangle(getColor(type)),
                child: Container(height: 18),
              ),
            ),
          if ((type == 2 || type == 3))
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
                painter: BottomRightTriangle(getColor(type)),
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
          if ((type == 1 || type == 3))
            Positioned(
              bottom: 0,
              left: 0,
              child: CustomPaint(
                painter: BottomLeftTriangle(getColor(type)),
                child: Container(height: 18),
              ),
            ),
          if ((type == 1 || type == 3))
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
              color: getBgColor(type),
              border: Border.all(
                color: MyColors.black,
                width: 0.1,
              ),
            ),
          ),

          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: getDateColor(type),
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

// var type = Random().nextInt(4);
// var state = Random().nextInt(5);
// return {
//   'date': i + 1,
//   'type': type, // f, s, fs etc
//   'state': state, // free, vacation etc
// };
