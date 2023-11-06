import 'package:faircare/blocs/vacations/vacation_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class VacationDates extends StatelessWidget {
  const VacationDates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacationCubit, VacationCubitState>(
      builder: (context, state) {
        final startDate = state.startDate;
        final endDate = state.endDate;

        int vacationDays = 0;

        if (startDate != null && endDate != null) {
          vacationDays = endDate.difference(startDate).inDays + 1;
          if (vacationDays < 0) vacationDays = 0;
        }

        return Column(
          children: [
            // from-to dates
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Von',
                        style: style(fontSize: 16),
                      ),
                      const HorizontalSpacer(8),
                      Text(
                        state.startDate != null
                            ? DateFormat('dd.MM.yyyy').format(state.startDate!)
                            : '-',
                        style: style(
                          fontSize: 16,
                          color: MyColors.prime,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Bis',
                        style: style(fontSize: 16),
                      ),
                      const HorizontalSpacer(8),
                      Text(
                        state.endDate != null
                            ? DateFormat('dd.MM.yyyy').format(state.endDate!)
                            : '-',
                        style: style(
                          fontSize: 16,
                          color: MyColors.prime,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const VerticalSpacer(16),

            // selected vacation dates
            Row(
              children: [
                Text(
                  'Ausgewählte Urlaubstage',
                  style: style(fontSize: 16),
                ),
                const HorizontalSpacer(12),
                Text(
                  '$vacationDays',//TODO how many vacation dates
                  style: style(
                    fontSize: 16,
                    color: MyColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const VerticalSpacer(16),
          ],
        );
      },
    );
  }
}
