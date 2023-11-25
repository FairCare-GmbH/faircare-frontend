import 'package:faircare/global/global.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'request_vacation.view.dart';
import '../preferences/state/preferences.bloc.dart';
import 'vacation_item.widget.dart';

class VacationsListWidget extends StatelessWidget {
  const VacationsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferenceState>(
      builder: (context, state) {
        if (state is PreferenceLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Subheading('Urlaubsanträge'),
              const VerticalSpacer(12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (a, b) => const VerticalSpacer(10),
                itemCount: state.vacationRequests.length,
                itemBuilder: (_, i) {
                  return VacationItemWidget(state.vacationRequests[i]);
                },
              ),
              const VerticalSpacer(12),
              Button(
                'Urlaub beantragen',
                onPressed: () {
                  navigate(context, const RequestVacationView()).then((value) {
                    if (value == true) {
                      BlocProvider.of<PreferencesBloc>(context)
                          .add(GetPreferenceData());
                    }
                  });
                },
              ),
            ],
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
