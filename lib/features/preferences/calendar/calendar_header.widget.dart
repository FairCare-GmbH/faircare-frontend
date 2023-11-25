import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/calendar_month.cubit.dart';

class CalendarHeaderWidget extends StatelessWidget {
  const CalendarHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarMonthCubit, PrefsCalendarMonthCubitState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<CalendarMonthCubit>(context);

        return Row(
          children: [
            Expanded(
              child: Text(
                '${months[state.getDate().month - 1]} ${state.getDate().year}',
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
