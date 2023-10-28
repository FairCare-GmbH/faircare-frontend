import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_data_cubit.dart';
import 'package:faircare/blocs/vacations/vacation_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/views/preferences/calendar/calendar_header.dart';
import 'package:faircare/views/preferences/calendar/calendar_week_days.dart';
import 'package:faircare/views/request_vacation/calendar/calendar_header.dart';
import 'package:faircare/views/request_vacation/calendar/calendar_week_days.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/triangles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class VacationCalendarWidget extends StatefulWidget {
  const VacationCalendarWidget({Key? key}) : super(key: key);

  @override
  State<VacationCalendarWidget> createState() => _VacationCalendarWidgetState();
}

class _VacationCalendarWidgetState extends State<VacationCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCalendarMonthCubit, PrefsCalendarMonthCubitState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PrefsCalendarMonthCubit>(context);

        return Column(
          children: [
            const VacationCalendarHeader(),
            const VerticalSpacer(4),
            const VacationCalendarWeekDays(),
            BlocBuilder<VacationCubit, VacationCubitState>(
              builder: (context, vacationState) {
                return BlocBuilder<PrefsCalendarDaysCubit, List<CalendarModel>>(
                  builder: (context, list) {
                    if (list.isNotEmpty) {
                      return SizedBox(
                        width: 350,
                        child: TableCalendar(
                          firstDay: DateTime(2023),
                          lastDay: DateTime(2030),
                          focusedDay: state.dateTime,
                          rowHeight: 50,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          headerVisible: false,
                          availableGestures: AvailableGestures.horizontalSwipe,
                          onPageChanged: (focusedDay) =>
                              cubit.setMonth(focusedDay),
                          calendarBuilders: CalendarBuilders(
                            defaultBuilder: (_, day, __) => myCalendarBuilder(
                              day,
                              getDayData(list, day),
                            ),
                            todayBuilder: (_, day, __) => myCalendarBuilder(
                              day,
                              getDayData(list, day),
                            ),
                            outsideBuilder: myOutsideBuilder,
                          ),
                          daysOfWeekVisible: false,
                          onDaySelected: (selectedDay, focusedDay) {},
                        ),
                      );
                    }
                    return const LoadingIndicator();
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  CalendarModel? getDayData(List<CalendarModel> list, DateTime day) {
    CalendarModel? data;
    try {
      data = list.singleWhere(
        (e) => e.fromDate.isSameDay(day),
      );
    } catch (e) {
      data = null;
    }
    return data;
  }

  Color getColor(CalendarModel? model, VacationCubitState state) {
    if (model == null) return MyColors.grey;

    if (state.startDate == model.fromDate) return Colors.transparent;
    if (state.endDate == model.fromDate) return Colors.transparent;
    if (state.startDate != null &&
        state.endDate != null &&
        model.fromDate.isBefore(state.endDate!) &&
        model.fromDate.isAfter(state.startDate!)) {
      return Colors.transparent;
    }

    if (model.tourType == 0) return MyColors.grey;
    if (model.tourType == 4) return MyColors.grey;
    if (model.hasAssignedTour) return MyColors.green;
    if (!model.hasAssignedTour) return MyColors.prime;
    return MyColors.border;
  }

  Color getBgColor(CalendarModel? model, VacationCubitState state) {
    if (model == null) return MyColors.border;

    if (state.startDate == model.fromDate) return MyColors.blueGreyDark;
    if (state.endDate == model.fromDate) return MyColors.blueGreyDark;
    if (state.startDate != null &&
        state.endDate != null &&
        model.fromDate.isBefore(state.endDate!) &&
        model.fromDate.isAfter(state.startDate!)) {
      return MyColors.darkGrey.withOpacity(0.5);
    }

    if (model.tourType == 0) return MyColors.grey.withOpacity(0.2);
    if (model.tourType == 4) return MyColors.grey.withOpacity(0.2);
    if (model.hasAssignedTour) return MyColors.green.withOpacity(0.2);
    if (!model.hasAssignedTour) return MyColors.prime.withOpacity(0.2);
    return MyColors.white;
  }

  Color getDateColor(CalendarModel? model, VacationCubitState state) {
    if (model == null) return MyColors.grey;

    if (state.startDate == model.fromDate) return MyColors.white;
    if (state.endDate == model.fromDate) return MyColors.white;
    if (state.startDate != null &&
        state.endDate != null &&
        model.fromDate.isBefore(state.endDate!) &&
        model.fromDate.isAfter(state.startDate!)) {
      return MyColors.white;
    }

    if (model.tourType == 0) return MyColors.grey;
    if (model.tourType == 4) return MyColors.grey;
    if (model.hasAssignedTour) return MyColors.green;
    if (!model.hasAssignedTour) return MyColors.prime;
    return MyColors.darkGrey;
  }

  Widget? myCalendarBuilder(DateTime day, CalendarModel? model) {
    final type = model?.tourType;

    final cubit = BlocProvider.of<VacationCubit>(context);

    return InkWell(
      onTap: () {
        if (model == null) return;

        final state = cubit.state;

        if (state.startDate == null) {
          cubit.setStartDate(day);
        } else if (state.endDate == null) {
          cubit.setEndDate(day);
        } else {
          cubit.setStartDate(day);
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
                color: getBgColor(model, cubit.state),
                border: Border.all(
                  color: MyColors.black,
                  width: 0.1,
                ),
              ),
            ),

            // S
            if (type == 2 || type == 3)
              Positioned(
                top: 0,
                right: 0,
                child: CustomPaint(
                  painter: TopRightTriangle(getColor(model, cubit.state)),
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
                  painter: BottomRightTriangle(getColor(model, cubit.state)),
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
                  painter: BottomLeftTriangle(getColor(model, cubit.state)),
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

            // date
            Center(
              child: Text(
                DateFormat('d').format(day),
                style: style(
                  color: getDateColor(model, cubit.state),
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
