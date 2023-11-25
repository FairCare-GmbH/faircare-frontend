import 'package:dio/dio.dart';
import 'package:faircare/features/vacation/vacation_dates.widget.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import 'vacation.cubit.dart';
import '../../widgets/snack_bar.dart';
import '../preferences/calendar/calendar.widget.dart';
import '../preferences/state/preferences.bloc.dart';

class RequestVacationView extends StatelessWidget {
  const RequestVacationView({Key? key}) : super(key: key);

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
        body: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => PreferencesBloc()..add(GetPreferenceData())),
              BlocProvider(create: (_) => VacationCubit())
            ],
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // calendar
                const CalendarWidget(isVacationPlanner: true),
                const VerticalSpacer(16),

                const VacationDatesWidget(),

                const VerticalSpacer(12),
                BlocBuilder<VacationCubit, VacationCubitState>(
                    builder: (context, state) {
                  return Button(
                    'Beantragen',
                    onPressed: () {
                      if (state.startDate == null || state.endDate == null) {
                        return;
                      }
                      Api.request('/preferences/mine/vacation-requests',
                          options: Options(method: 'POST'),
                          data: {
                            'fromDate': state.startDate!.ymd.toIso8601String(),
                            'toDate': state.endDate!.ymd.toIso8601String()
                          }).then((value) {
                        showSnackBar(
                          context,
                          'Urlaub beantragt',
                          icon: Icons.save,
                        );
                        Navigator.of(context).pop(true);
                      }).onError((error, stackTrace) {
                        if (error is ApiException) {
                          error.showDialog(context);
                        } else if (kDebugMode) {
                          print(error);
                          print(stackTrace);
                        }
                      });
                    },
                  );
                })
              ],
            )),
      ),
    );
  }
}
