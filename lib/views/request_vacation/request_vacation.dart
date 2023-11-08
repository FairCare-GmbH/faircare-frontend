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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import '../../blocs/preferences/calendar_cubit/calendar_cubit.dart';
import '../../blocs/preferences/vacation_requests/vacation_requests_bloc.dart';
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

                const VacationDates(),

                const VerticalSpacer(12),
                BlocBuilder<VacationCubit, VacationCubitState>(
                    builder: (context, state) {
                  return Button(
                    'Beantragen',
                    onPressed: () {
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
