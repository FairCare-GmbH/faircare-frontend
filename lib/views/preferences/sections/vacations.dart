import 'package:faircare/blocs/preferences/vacation_requests/vacation_requests_bloc.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/views/preferences/vacation_item.dart';
import 'package:faircare/views/request_vacation/request_vacation.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vacations/vacation_cubit.dart';

class Vacations extends StatelessWidget {
  const Vacations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => VacationRequestsBloc()..add(GetVacationRequests())),
      ],
      child: BlocBuilder<VacationRequestsBloc, VacationRequestsState>(
        builder: (context, state) {
          if (state is VacationRequestsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Subheading('Urlaubsanträge'),
                const VerticalSpacer(12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (a, b) => const VerticalSpacer(10),
                  itemCount: state.vacations.length,
                  itemBuilder: (_, i) {
                    return VacationItem(state.vacations[i]);
                  },
                ),
                const VerticalSpacer(12),
                Button(
                  'Urlaub beantragen',
                  onPressed: () {
                    navigate(context, const VacationPage()).then((value) {
                      if (value == true) {
                        BlocProvider.of<VacationRequestsBloc>(context)
                            .add(GetVacationRequests());
                      }
                    });
                  },
                ),
              ],
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
