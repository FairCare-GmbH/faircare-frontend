import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/hours_slider.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/loading_indicator.dart';
import '../state/preferences.bloc.dart';

class DesiredHoursWidget extends StatelessWidget {
  const DesiredHoursWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferenceState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<PreferencesBloc>(context);

        if (state is PreferenceLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // working hours
              const Subheading('Gewünschte Arbeitszeit in Stunden'),
              const VerticalSpacer(0),

              // select hours range
              HoursSlider(
                min: 0,
                max: 70,
                selectedRange: RangeValues(
                  state.userModel.weeklyHourMinimum.toDouble(),
                  state.userModel.weeklyHourMaximum.toDouble(),
                ),
                onChanged: (val) {
                  bloc.add(UpdatePreferenceUser(state.userModel.copyWith(
                      weeklyHourMinimum: val.start.toInt(),
                      weeklyHourMaximum: val.end.toInt())));
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
                          color: e ==
                                  hoursTypes[state
                                              .userModel.weeklyHourMaximum <=
                                          5
                                      ? 0
                                      : (state.userModel.weeklyHourMaximum <= 34
                                          ? 1
                                          : 2)]
                              ? FCColors.prime
                              : FCColors.grey,
                          onTap: () {
                            bloc.add(UpdatePreferenceUser(state.userModel
                                .copyWith(
                                    weeklyHourMinimum: e == hoursTypes[0]
                                        ? 1
                                        : (e == hoursTypes[1] ? 20 : 35),
                                    weeklyHourMaximum: e == hoursTypes[0]
                                        ? 5
                                        : (e == hoursTypes[1] ? 34 : 50))));
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
                  text: 'Entspricht einem geschätzen durchschnittlichen '
                      'Monatsgehalt von ca. ',
                  children: [
                    TextSpan(
                      text: ''
                          '${state.userModel.weeklyHourMinimum * 24 * 4} € - '
                          '${state.userModel.weeklyHourMaximum * 28 * 4} €',
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
        } else if (state is PreferenceError) {
          if (kDebugMode) {
            print(state.error);
            print(state.stack);
          }
          return Text(state.error.toString());
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
