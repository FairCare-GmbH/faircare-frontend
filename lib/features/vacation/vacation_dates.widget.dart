import 'package:faircare/features/vacation/vacation.cubit.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/heading.dart';
import '../preferences/state/preferences.bloc.dart';
import '../tours/tour_list_item.widget.dart';

class VacationDatesWidget extends StatelessWidget {
  const VacationDatesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacationCubit, VacationCubitState>(
      builder: (context, state) {
        return BlocBuilder<PreferencesBloc, PreferenceState>(
            builder: (context, prefsState) {
          final startDate = state.startDate;
          final endDate = state.endDate;

          int vacationDays = 0;
          List<TourModel> tours = [];

          if (startDate != null &&
              endDate != null &&
              prefsState is PreferenceLoaded) {
            vacationDays = endDate.difference(startDate).inDays + 1;

            tours = prefsState.tours
                .where((e) =>
                    e.tourDate.isSameDayOrAfter(state.startDate!) &&
                    e.tourDate.isSameDayOrBefore(state.endDate!))
                .toList(growable: false);
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
                              ? DateFormat('dd.MM.yyyy')
                                  .format(state.startDate!)
                              : '-',
                          style: style(
                            fontSize: 16,
                            color: FCColors.prime,
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
                            color: FCColors.prime,
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
                    '$vacationDays', //TODO how many vacation dates
                    style: style(
                      fontSize: 16,
                      color: FCColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const VerticalSpacer(16),

              // offered tours
              const Subheading('Folgende Touren werden dabei abgegeben:'),
              const VerticalSpacer(12),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (a, b) => const VerticalSpacer(10),
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  return TourListItemWidget(
                      tour: tours[index],
                      displayType: '',
                      refreshCallback: () =>
                          BlocProvider.of<PreferencesBloc>(context)
                            ..add(GetPreferenceData()));
                },
              ),
            ],
          );
        });
      },
    );
  }
}
