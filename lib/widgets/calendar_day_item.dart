import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_data_cubit/calendar_data_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_data_cubit/calendar_data_cubit.dart';
import 'package:faircare/global/colors.dart';
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
    return BlocBuilder<PrefsCalendarDataCubit, List<CalendarModel>>(
      builder: (context, list) {
        return BlocBuilder<PrefsCalendarCubit, PrefsCalendarCubitState>(
          builder: (context, state) {
            final cubit = BlocProvider.of<PrefsCalendarCubit>(context);
            Color bgColor = MyColors.white;
            Color textColor = MyColors.darkGrey;

            final days = getDaysInMonth(state.dateTime, weekDay);

            List<CalendarModel> models = [];

            for (CalendarModel model in list) {
              if (days.contains(model.fromDate)) {
                models.add(model);
              }
            }

            bool greenTours = false;
            bool blueTours = false;

            for (CalendarModel model in models) {
              if (!model.hasAssignedTour) {
                greenTours = false;
                break;
              }
              greenTours = true;
            }

            for (CalendarModel model in models) {
              if ((model.tourType == 1 ||
                      model.tourType == 2 ||
                      model.tourType == 3) &&
                  !model.hasAssignedTour) {
                blueTours = true;
              } else {
                blueTours = false;
                break;
              }
            }

            if (blueTours) {
              greenTours = false;
              bgColor = MyColors.prime;
              textColor = MyColors.white;
            }

            if (greenTours) {
              bgColor = MyColors.green;
              textColor = MyColors.white;
            }

            return Flexible(
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
            );
          },
        );
      },
    );
  }

  Color getBgColor() {
    return MyColors.white;
  }

  Color getTextColor() {
    return MyColors.darkGrey;
  }
}

List<DateTime> getDaysInMonth(DateTime dateTime, int weekDay) {
  List<DateTime> days = [];

  DateTime firstDay = DateTime(dateTime.year, dateTime.month);
  DateTime lastDay = DateTime(dateTime.year, dateTime.month + 1, 0);

  for (DateTime date = firstDay;
      date.isBefore(lastDay);
      date = date.add(const Duration(days: 1))) {
    if (date.weekday == weekDay) {
      days.add(date);
    }
  }

  return days;
}
