import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/preferences/state/calendar_month.cubit.dart';
import '../features/preferences/state/calendar_week.model.dart';
import '../features/preferences/state/preferences.bloc.dart';


class CalendarWeekDayWidget extends StatelessWidget {
  const CalendarWeekDayWidget(this.text, this.weekDay, this.isVacationPlanner,
      {Key? key})
      : super(key: key);

  final String text;
  final int weekDay;
  final bool isVacationPlanner;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferenceState>(
      builder: (context, prefs) {
        if (prefs is PreferenceLoaded) {
          return BlocBuilder<CalendarMonthCubit,
              PrefsCalendarMonthCubitState>(
            builder: (context, state) {
              CalendarWeekModel pref = prefs.getWeekPref(weekDay);

              final f = pref.getFForDate(state.getDate()) ??
                  pref.getFForDate(
                      DateTime(state.getDate().year, state.getDate().month + 1)
                          .subtract(const Duration(days: 1)));
              final s = pref.getSForDate(state.getDate()) ??
                  pref.getSForDate(
                      DateTime(state.getDate().year, state.getDate().month + 1)
                          .subtract(const Duration(days: 1)));
              final isF = f != null;
              final isS = s != null;

              Color bgColor = (!isF && !isS)
                  ? MyColors.white
                  : (pref.isF || pref.isS)
                      ? MyColors.prime
                      : MyColors.prime.withOpacity(.5);
              Color textColor =
                  (!isF && !isS) ? MyColors.darkGrey : MyColors.white;

              return Flexible(
                child: InkWell(
                  onTap: () {
                    if (isVacationPlanner) return;
                    pref.incrementWeek();
                    BlocProvider.of<PreferencesBloc>(context)
                        .add(UpdatePreferenceList(prefs.preferences));
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
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
