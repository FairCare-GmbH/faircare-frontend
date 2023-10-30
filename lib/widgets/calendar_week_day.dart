import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_data_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarWeekDay extends StatelessWidget {
  const CalendarWeekDay(this.text, this.weekDay, {Key? key}) : super(key: key);

  final String text;
  final int weekDay;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCalendarDaysCubit, List<CalendarModel>>(
      builder: (context, list) {
        return BlocBuilder<PrefsCalendarMonthCubit,
            PrefsCalendarMonthCubitState>(
          builder: (context, state) {
            CalendarModel? weekdayModel = PrefsCalendarDaysCubit.getDayData(
                    list,
                    DateTime(state.getDate().year, state.getDate().month,
                        (7 + weekDay - state.getDate().weekday) % 7 + 1))
                .where(
                    (e) => !e.fromDate.isSameDay(e.toDate) && e.tourType != 0)
                .firstOrNull;

            Color bgColor = weekdayModel == null
                ? MyColors.white
                : weekdayModel.assignedTourType == null
                    ? MyColors.prime
                    : MyColors.green;
            Color textColor =
                weekdayModel == null ? MyColors.darkGrey : MyColors.white;

            return Flexible(
              child: InkWell(
                onTap: () {
                  BlocProvider.of<PrefsCalendarDaysCubit>(context)
                      .incrementWeek(weekDay);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(color: bgColor),
                  child: Center(
                    child: Text(
                      text,
                      style: style(color: textColor),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
