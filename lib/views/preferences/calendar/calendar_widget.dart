import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_data_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/extensions.dart';
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
                      onPageChanged: (focusedDay) => cubit.setMonth(focusedDay),
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

  Color getColor(CalendarModel? model) {
    if (model == null) return MyColors.grey;
    if (model.tourType == 0) return MyColors.grey;
    if (model.tourType == 4) return MyColors.grey;
    if (model.hasAssignedTour) return MyColors.green;
    if (!model.hasAssignedTour) return MyColors.prime;
    return MyColors.border;
  }

  Color getBgColor(CalendarModel? model) {
    if (model == null) return MyColors.border;
    if (model.tourType == 0) return MyColors.grey.withOpacity(0.2);
    if (model.tourType == 4) return MyColors.grey.withOpacity(0.2);
    if (model.hasAssignedTour) return MyColors.green.withOpacity(0.2);
    if (!model.hasAssignedTour) return MyColors.prime.withOpacity(0.2);
    return MyColors.white;
  }

  Color getDateColor(CalendarModel? model) {
    if (model == null) return MyColors.grey;
    if (model.tourType == 0) return MyColors.grey;
    if (model.tourType == 4) return MyColors.grey;
    if (model.hasAssignedTour) return MyColors.green;
    if (!model.hasAssignedTour) return MyColors.prime;
    return MyColors.darkGrey;
  }

  Widget? myCalendarBuilder(DateTime day, CalendarModel? model) {
    final type = model?.tourType;

    return InkWell(
      onTap: () {
        final cubit = BlocProvider.of<PrefsCalendarDaysCubit>(context);

        if (model == null) return cubit.updateData(day, 1);

        if (model.tourType == 0) return;
        if (model.hasAssignedTour) return;

        if (model.tourType == 1) cubit.updateData(model.fromDate, 2);
        if (model.tourType == 2) cubit.updateData(model.fromDate, 3);
        if (model.tourType == 3) cubit.updateData(model.fromDate, 4);
        if (model.tourType == 4) cubit.updateData(model.fromDate, 1);
      },
      child: SizedBox(
        width: 50,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // background
            Container(
              decoration: BoxDecoration(
                color: getBgColor(model),
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
                  painter: TopRightTriangle(getColor(model)),
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
                  painter: BottomRightTriangle(getColor(model)),
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
                  painter: BottomLeftTriangle(getColor(model)),
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
                  color: getDateColor(model),
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
