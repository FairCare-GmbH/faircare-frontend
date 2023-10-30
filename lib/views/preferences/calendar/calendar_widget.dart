import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_data_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/views/preferences/calendar/calendar_header.dart';
import 'package:faircare/views/preferences/calendar/calendar_week_days.dart';
import 'package:faircare/widgets/loading_indicator.dart';
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
    return BlocBuilder<PrefsCalendarMonthCubit, PrefsCalendarMonthCubitState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PrefsCalendarMonthCubit>(context);

        return Column(
          children: [
            const MyCalendarHeader(),
            const VerticalSpacer(4),
            const MyCalendarWeekDays(),
            BlocBuilder<PrefsCalendarDaysCubit, List<CalendarModel>>(
              builder: (context, list) {
                return SizedBox(
                  width: 350,
                  child: TableCalendar(
                    firstDay: DateTime(2023),
                    lastDay: DateTime(2030),
                    focusedDay: state.getDate(),
                    rowHeight: 50,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerVisible: false,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    onPageChanged: (focusedDay) => cubit.setMonth(focusedDay),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (_, day, __) => myCalendarBuilder(
                        day,
                        PrefsCalendarDaysCubit.getDayData(list, day),
                      ),
                      todayBuilder: (_, day, __) => myCalendarBuilder(
                        day,
                        PrefsCalendarDaysCubit.getDayData(list, day),
                      ),
                      outsideBuilder: myOutsideBuilder,
                    ),
                    daysOfWeekVisible: false,
                    onDaySelected: (selectedDay, focusedDay) {},
                  ),
                );
                return const LoadingIndicator();
              },
            ),
          ],
        );
      },
    );
  }

  Widget? myCalendarBuilder(DateTime day, List<CalendarModel> models) {
    final bool isF = models.any((e) => e.tourType == 1 || e.tourType == 3);
    final bool isFAssigned = isF &&
        models.any((e) => e.assignedTourType == 1 || e.assignedTourType == 3);

    final bool isS = models.any((e) => e.tourType == 2 || e.tourType == 3);
    final bool isSAssigned = isS &&
        models.any((e) => e.assignedTourType == 2 || e.assignedTourType == 3);

    final bool isU = models.any((e) => e.tourType == 0);
    final bool isUApproved = isU && models.any((e) => e.assignedTourType == 0);

    final Color fBgColor = isU && isFAssigned
        ? MyColors.red
        : isFAssigned
            ? MyColors.green
            : MyColors.prime;
    final Color sBgColor = isU && isSAssigned
        ? MyColors.red
        : isSAssigned
            ? MyColors.green
            : MyColors.prime;
    final Color uBgColor = isUApproved
        ? MyColors.orange
        : (isFAssigned || isSAssigned)
            ? MyColors.red
            : MyColors.grey;
    final Color bgColor = isU
        ? uBgColor.withOpacity(0.2)
        : (isFAssigned || isSAssigned)
            ? MyColors.green.withOpacity(0.2)
            : (isF || isS)
                ? MyColors.prime.withOpacity(0.2)
                : MyColors.border;
    final color = isU
        ? uBgColor
        : (isFAssigned || isSAssigned)
            ? MyColors.green
            : (isF || isS)
                ? MyColors.prime
                : MyColors.darkGrey;

    return InkWell(
      onTap: () {
        BlocProvider.of<PrefsCalendarDaysCubit>(context).incrementDay(day);
      },
      child: SizedBox(
        width: 50,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // background
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                  color: MyColors.black,
                  width: 0.1,
                ),
              ),
            ),

            // S
            if (isS)
              Positioned(
                top: 0,
                right: 0,
                child: CustomPaint(
                  painter: TopRightTriangle(sBgColor),
                  child: Container(height: 18),
                ),
              ),
            if (isS)
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  'S',
                  style: style(color: MyColors.white, fontSize: 10),
                ),
              ),

            // U
            if (isU)
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  painter: BottomRightTriangle(uBgColor),
                  child: Container(height: 18),
                ),
              ),
            if (isU)
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  'U',
                  style: style(color: MyColors.white, fontSize: 10),
                ),
              ),

            // F
            if (isF)
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomPaint(
                  painter: BottomLeftTriangle(fBgColor),
                  child: Container(height: 18),
                ),
              ),
            if (isF)
              Positioned(
                bottom: 0,
                left: 0,
                child: Text(
                  'F',
                  style: style(color: MyColors.white, fontSize: 10),
                ),
              ),

            // date
            Center(
              child: Text(
                DateFormat('d').format(day),
                style: style(
                  color: color,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
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
