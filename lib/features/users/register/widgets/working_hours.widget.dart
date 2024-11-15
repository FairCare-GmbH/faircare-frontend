import 'package:faircare/features/users/register/register_cubit.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/features/users/register/register.model.dart';
import 'package:faircare/widgets/hours_slider.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkingHoursWidget extends StatelessWidget {
  const WorkingHoursWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterModel>(
      builder: (context, state) {
        final cubit = BlocProvider.of<RegisterCubit>(context);

        return Column(
          children: [
            // working hours
            Text(
              'Gewünschte Arbeitszeit in Stunden pro Woche',
              style: style(color: FCColors.grey),
            ),
            const VerticalSpacer(0),

            // select hours range
            HoursSlider(
              min: 0,
              max: 50,
              selectedRange: RangeValues(
                state.weeklyHourMinimum.toDouble(),
                state.weeklyHourMaximum.toDouble(),
              ),
              onChanged: (val) {
                cubit.setMinimumRate(val.start.toInt());
                cubit.setMaximumRate(val.end.toInt());
              },
            ),
            const VerticalSpacer(0),

            // select work type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...hoursTypes
                    .map(
                      (e) => MyTextButton(
                        e,
                        color: state.hoursType == e
                            ? FCColors.prime
                            : FCColors.grey,
                        onTap: () {
                          cubit.setHoursType(e);
                          if (e == hoursTypes[0]) {
                            cubit.setMinimumRate(1);
                            cubit.setMaximumRate(5);
                          } else if (e == hoursTypes[1]) {
                            cubit.setMinimumRate(5);
                            cubit.setMaximumRate(34);
                          } else if (e == hoursTypes[2]) {
                            cubit.setMinimumRate(35);
                            cubit.setMaximumRate(50);
                          }
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
            const VerticalSpacer(16),

            // earnings
            Text.rich(
              TextSpan(
                text: 'Entspricht einem geschätzen '
                    'Monatsgehalt von ca. ',
                children: [
                  TextSpan(
                    text: ''
                        '${state.weeklyHourMinimum * 24 * 4} € - '
                        '${state.weeklyHourMaximum * 24 * 4} €',
                    style: style(
                      color: FCColors.prime,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              style: style(
                color: FCColors.grey,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }
}
