import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/preferences_bloc.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/preferences/calendar/calendar_header.dart';
import 'package:faircare/views/preferences/calendar/calendar_week_days.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../blocs/vacations/vacation_cubit.dart';

class CalendarWidget extends StatelessWidget {
  final bool isVacationPlanner;

  const CalendarWidget({this.isVacationPlanner = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVacationPlanner
        ? BlocBuilder<VacationCubit, VacationCubitState>(
            builder: (context, state) {
            return getCalendar(context);
          })
        : getCalendar(context);
  }

  Widget getCalendar(BuildContext context) {
    return BlocBuilder<PrefsCalendarMonthCubit, PrefsCalendarMonthCubitState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PrefsCalendarMonthCubit>(context);

        return BlocBuilder<PreferencesBloc, PreferenceState>(
          builder: (context, prefs) {
            if (prefs is PreferenceLoaded) {
              return Column(
                children: [
                  const MyCalendarHeader(),
                  const VerticalSpacer(4),
                  MyCalendarWeekDays(isVacationPlanner: isVacationPlanner),
                  SizedBox(
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
                        defaultBuilder: (_, day, __) =>
                            myCalendarBuilder(day, prefs, context),
                        todayBuilder: (_, day, __) =>
                            myCalendarBuilder(day, prefs, context),
                        outsideBuilder: myOutsideBuilder,
                      ),
                      daysOfWeekVisible: false,
                      onDaySelected: (selectedDay, focusedDay) {},
                    ),
                  )
                ],
              );
            } else {
              return const LoadingIndicator();
            }
          },
        );
      },
    );
  }

  Widget? myCalendarBuilder(
      DateTime day, PreferenceLoaded state, BuildContext context) {
    final models = state.getDayData(day);
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
    Color color = isU
        ? uBgColor
        : (isFAssigned || isSAssigned)
            ? MyColors.green
            : (isF || isS)
                ? MyColors.prime
                : MyColors.darkGrey;

    Color? vacationColor;

    if (isVacationPlanner) {
      final cubit = BlocProvider.of<VacationCubit>(context);
      if (cubit.state.startDate != null) {
        if (cubit.state.startDate!.isSameDay(day)) {
          vacationColor = MyColors.darkGrey.withOpacity(.6);
          color = MyColors.white;
        }

        if (cubit.state.endDate != null) {
          if (cubit.state.endDate!.isSameDay(day)) {
            vacationColor = MyColors.darkGrey.withOpacity(.6);
            color = MyColors.white;
          }
          if (cubit.state.startDate!.isBefore(day) &&
              cubit.state.endDate!.isAfter(day)) {
            vacationColor = MyColors.grey.withOpacity(.3);
            color = MyColors.white;
          }
        }
      }
    }

    return InkWell(
      onTap: () {
        if (isVacationPlanner) {
          final cubit = BlocProvider.of<VacationCubit>(context);
          final state = cubit.state;

          if (state.startDate == null) {
            cubit.setStartDate(day);
          } else if (state.startDate!.isBefore(day) ||
              state.startDate!.isSameDay(day)) {
            if (state.endDate != null && state.endDate!.isSameDay(day)) {
              cubit.setStartEndDate(day, null);
            } else {
              cubit.setEndDate(day);
            }
          } else {
            cubit.setStartEndDate(day, null);
          }
        } else {
          BlocProvider.of<PreferencesBloc>(context)
              .add(IncrementPreferenceDay(day));
        }
      },
      child: SizedBox(
        width: 50,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // background
            Container(
              decoration: BoxDecoration(
                color: day.isSameDay(DateTime.now())
                    ? MyColors.prime.withOpacity(0.1)
                    : bgColor,
                border: Border.all(
                  color: MyColors.black,
                  width: 0.1,
                ),
              ),
            ),

            if (vacationColor != null)
              Container(
                decoration: BoxDecoration(
                  color: vacationColor,
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
                  color: day.isSameDay(DateTime.now()) ? MyColors.prime : color,
                  fontWeight: day.isSameDay(DateTime.now())
                      ? FontWeight.bold
                      : FontWeight.normal,
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
