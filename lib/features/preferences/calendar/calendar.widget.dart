import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../vacation/vacation.cubit.dart';
import '../state/calendar_month.cubit.dart';
import '../state/preferences.bloc.dart';
import 'calendar_header.widget.dart';
import 'calendar_week_days.widget.dart';

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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CalendarMonthCubit()),
        ],
        child:
            BlocBuilder<CalendarMonthCubit, PrefsCalendarMonthCubitState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<CalendarMonthCubit>(context);

            return BlocBuilder<PreferencesBloc, PreferenceState>(
              builder: (context, prefs) {
                if (prefs is PreferenceLoaded) {
                  return Column(
                    children: [
                      const CalendarHeaderWidget(),
                      const VerticalSpacer(4),
                      CalendarWeekDaysWidget(isVacationPlanner: isVacationPlanner),
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
                          onPageChanged: (focusedDay) =>
                              cubit.setMonth(focusedDay),
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
        ));
  }

  Widget? myCalendarBuilder(
      DateTime day, PreferenceLoaded state, BuildContext context) {
    final pref = state.getDayPref(day);
    final Color fBgColor = pref.isFAssigned && pref.isU
        ? FCColors.red
        : pref.isFAssigned
            ? FCColors.green
            : FCColors.prime;
    final Color sBgColor = pref.isU && pref.isSAssigned
        ? FCColors.red
        : pref.isSAssigned
            ? FCColors.green
            : FCColors.prime;
    final Color uBgColor = pref.isUAssigned
        ? FCColors.orange
        : (pref.isFAssigned || pref.isSAssigned)
            ? FCColors.red
            : FCColors.grey;
    final Color bgColor = pref.isU
        ? uBgColor.withOpacity(0.2)
        : (pref.isFAssigned || pref.isSAssigned)
            ? FCColors.green.withOpacity(0.2)
            : (pref.isF || pref.isS)
                ? FCColors.prime.withOpacity(0.2)
                : FCColors.border;
    Color color = pref.isU
        ? uBgColor
        : (pref.isFAssigned || pref.isSAssigned)
            ? FCColors.green
            : (pref.isF || pref.isS)
                ? FCColors.prime
                : FCColors.darkGrey;

    Color? vacationColor;

    if (isVacationPlanner) {
      final cubit = BlocProvider.of<VacationCubit>(context);
      if (cubit.state.startDate != null) {
        if (cubit.state.startDate!.isSameDay(day)) {
          vacationColor = FCColors.darkGrey.withOpacity(.6);
          color = FCColors.white;
        }

        if (cubit.state.endDate != null) {
          if (cubit.state.endDate!.isSameDay(day)) {
            vacationColor = FCColors.darkGrey.withOpacity(.6);
            color = FCColors.white;
          }
          if (cubit.state.startDate!.isBefore(day) &&
              cubit.state.endDate!.isAfter(day)) {
            vacationColor = FCColors.grey.withOpacity(.3);
            color = FCColors.white;
          }
        }
      }
    }

    return InkWell(
      onTap: () {
        if (isVacationPlanner) {
          if (pref.isU) return;
          final cubit = BlocProvider.of<VacationCubit>(context);
          final selection = cubit.state;

          if (selection.startDate == null) {
            cubit.setStartDate(day);
          } else if (selection.startDate!.isBefore(day) ||
              selection.startDate!.isSameDay(day)) {
            if (selection.endDate != null &&
                selection.endDate!.isSameDay(day)) {
              cubit.setStartEndDate(day, null);
            } else {
              final vacationDays =
                  day.difference(selection.startDate!).inDays + 1;
              for (var i = 0; i < vacationDays; i++) {
                if (state
                    .getDayPref(selection.startDate!.add(Duration(days: i)))
                    .isU) {
                  cubit.setStartEndDate(day, null);
                  return;
                }
              }
              cubit.setEndDate(day);
            }
          } else {
            cubit.setStartEndDate(day, null);
          }
        } else if (pref.incrementDay()) {
          BlocProvider.of<PreferencesBloc>(context)
              .add(UpdatePreferenceList(state.preferences));
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
                color: day.isToday
                    ? FCColors.prime.withOpacity(0.1)
                    : !pref.isInPast
                        ? bgColor
                        : FCColors.border,
                border: Border.all(
                  color: FCColors.black,
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
            if ((!pref.isU && pref.isS) || pref.isSAssigned)
              Positioned(
                top: 0,
                right: 0,
                child: CustomPaint(
                  painter: TopRightTriangle(
                      pref.isInPast ? sBgColor.withOpacity(.5) : sBgColor),
                  child: Container(height: 18),
                ),
              ),
            if ((!pref.isU && pref.isS) || pref.isSAssigned)
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  'S',
                  style: style(color: FCColors.white, fontSize: 10),
                ),
              ),

            // U
            if (pref.isU)
              Positioned(
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  painter: BottomRightTriangle(
                      pref.isInPast ? uBgColor.withOpacity(.5) : uBgColor),
                  child: Container(height: 18),
                ),
              ),
            if (pref.isU)
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  'U',
                  style: style(color: FCColors.white, fontSize: 10),
                ),
              ),

            // F
            if ((!pref.isU && pref.isF) || pref.isFAssigned)
              Positioned(
                bottom: 0,
                left: 0,
                child: CustomPaint(
                  painter: BottomLeftTriangle(
                      pref.isInPast ? fBgColor.withOpacity(.5) : fBgColor),
                  child: Container(height: 18),
                ),
              ),
            if ((!pref.isU && pref.isF) || pref.isFAssigned)
              Positioned(
                bottom: 0,
                left: 0,
                child: Text(
                  'F',
                  style: style(color: FCColors.white, fontSize: 10),
                ),
              ),

            // date
            Center(
              child: Text(
                DateFormat('d').format(day),
                style: style(
                  color: pref.isInPast ? FCColors.darkGrey : color,
                  fontWeight: day.isToday ? FontWeight.bold : FontWeight.normal,
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
              color: FCColors.border,
              border: Border.all(
                color: FCColors.grey,
                width: 0.1,
              ),
            ),
          ),

          // date
          Center(
            child: Text(
              DateFormat('d').format(day),
              style: style(
                color: FCColors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
