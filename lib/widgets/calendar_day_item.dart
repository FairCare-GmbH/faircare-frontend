import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_data_cubit.dart';
import 'package:faircare/functions/get_week_days_in_month.dart';
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
    return BlocBuilder<PrefsCalendarDaysCubit, List<CalendarModel>>(
      builder: (context, list) {
        return BlocBuilder<PrefsCalendarMonthCubit,
            PrefsCalendarMonthCubitState>(
          builder: (context, state) {
            Color bgColor = MyColors.white;
            Color textColor = MyColors.darkGrey;

            // getting days of weekday
            final days = getDaysInMonth(state.dateTime, weekDay);

            List<CalendarModel> models = [];

            // getting models of previous days
            for (CalendarModel model in list) {
              if (days.contains(model.fromDate)) {
                models.add(model);
              }
            }

            bool greenTours = false;

            bool blueTours = false;

            // checking for assigned tours
            for (CalendarModel model in models) {
              if (!model.hasAssignedTour) {
                greenTours = false;
                break;
              }
              greenTours = true;
            }

            // checking for available days

            for (DateTime day in days) {
              final dayExists = models.any(
                (e) => e.fromDate.isAtSameMomentAs(day),
              );
              if (!dayExists) {
                blueTours = false;
                break;
              }
              final model = models.singleWhere(
                (e) => e.fromDate.isAtSameMomentAs(day),
              );
              if (model.tourType == 1 && !model.hasAssignedTour) {
                blueTours = true;
              } else {
                blueTours = false;
                break;
              }
            }

            if (!blueTours) {
              for (DateTime day in days) {
                final dayExists = models.any(
                  (e) => e.fromDate.isAtSameMomentAs(day),
                );
                if (!dayExists) {
                  blueTours = false;
                  break;
                }
                final model = models.singleWhere(
                  (e) => e.fromDate.isAtSameMomentAs(day),
                );
                if (model.tourType == 2 && !model.hasAssignedTour) {
                  blueTours = true;
                } else {
                  blueTours = false;
                  break;
                }
              }
            }

            if (!blueTours) {
              for (DateTime day in days) {
                final dayExists = models.any(
                  (e) => e.fromDate.isAtSameMomentAs(day),
                );
                if (!dayExists) {
                  blueTours = false;
                  break;
                }
                final model = models.singleWhere(
                  (e) => e.fromDate.isAtSameMomentAs(day),
                );
                if (model.tourType == 3 && !model.hasAssignedTour) {
                  blueTours = true;
                } else {
                  blueTours = false;
                  break;
                }
              }
            }

            // applying colors

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
              child: InkWell(
                onTap: () {
                  if (greenTours) return;
                  final cubit =
                      BlocProvider.of<PrefsCalendarDaysCubit>(context);

                  if (models.isEmpty) {
                    for (final day in days) {
                      cubit.updateData(day, 1);
                    }
                  }

                  if (models[0].tourType == 1) {
                    for (final day in days) {
                      cubit.updateData(day, 2);
                    }
                  } else if (models[0].tourType == 2) {
                    for (final day in days) {
                      cubit.updateData(day, 3);
                    }
                  } else if (models[0].tourType == 3) {
                    for (final day in days) {
                      cubit.updateData(day, 4);
                    }
                  } else if (models[0].tourType == 4) {
                    for (final day in days) {
                      cubit.updateData(day, 1);
                    }
                  }
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
