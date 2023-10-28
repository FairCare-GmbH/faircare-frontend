import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VacationCalendarHeader extends StatelessWidget {
  const VacationCalendarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrefsCalendarMonthCubit, PrefsCalendarMonthCubitState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<PrefsCalendarMonthCubit>(context);

        return Row(
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
        );
      },
    );
  }
}
