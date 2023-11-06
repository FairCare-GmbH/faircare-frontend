import 'package:dio/dio.dart';
import 'package:faircare/blocs/preferences/preferences_bloc.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/request_vacation/vacation_dates.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import '../../blocs/vacations/vacation_cubit.dart';
import '../../widgets/snack_bar.dart';
import '../preferences/calendar/calendar_widget.dart';

class VacationPage extends StatelessWidget {
  const VacationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: const Icon(CupertinoIcons.back, size: 28),
          ),
          centerTitle: true,
          title: Text(
            'Urlaub beantragen',
            style: style(
              fontSize: 20,
              color: MyColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: BlocProvider<PreferencesBloc>(
            create: (_) => PreferencesBloc()..add(GetPreferenceData()),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // calendar
                const CalendarWidget(isVacationPlanner: true),
                const VerticalSpacer(16),

                const VacationDates(),

                // offered tours
                const Subheading('Folgende Touren werden dabei abgegeben:'),
                const VerticalSpacer(12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (a, b) => const VerticalSpacer(10),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // return TourItem(tourExample1, TourState.assigned);
                  },
                ),
                const VerticalSpacer(12),
                Button(
                  'Beantragen',
                  onPressed: () {
                    final state = BlocProvider.of<VacationCubit>(context).state;
                    Api.request(
                        '/preferences/${Api.getUser()!.id}/vacation-requests',
                        options: Options(method: 'POST'),
                        data: {
                          'fromDate': state.startDate.toString(),
                          'toDate': state.endDate.toString()
                        }).then((value) {
                      showSnackBar(
                        context,
                        'Urlaub beantragt',
                        icon: Icons.save,
                      );
                      pop(context);
                    }).onError((error, stackTrace) {
                      if (error is ApiException) error.showDialog(context);
                    });
                  },
                ),
              ],
            )),
      ),
    );
  }
}
