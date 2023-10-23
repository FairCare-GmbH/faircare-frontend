import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/register_model.dart';
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
              style: style(color: MyColors.grey),
            ),
            const VerticalSpacer(0),

            // select hours range
            HoursSlider(
              min: getMinValue(state),
              max: getMaxValue(state),
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
                            ? MyColors.prime
                            : MyColors.grey,
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
                      color: MyColors.prime,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
              style: style(
                color: MyColors.grey,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        );
      },
    );
  }

  double getMinValue(RegisterModel state) {
    if (state.hoursType == hoursTypes[0]) return 1;
    if (state.hoursType == hoursTypes[1]) return 5;
    if (state.hoursType == hoursTypes[2]) return 35;
    return 1;
  }

  double getMaxValue(RegisterModel state) {
    if (state.hoursType == hoursTypes[0]) return 5;
    if (state.hoursType == hoursTypes[1]) return 34;
    if (state.hoursType == hoursTypes[2]) return 50;
    return 1;
  }
}
