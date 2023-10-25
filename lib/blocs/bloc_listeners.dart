import 'package:faircare/blocs/preferences/calendar_bloc/calendar_bloc.dart';
import 'package:faircare/blocs/preferences/calendar_data_cubit/calendar_data_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListeners {
  static final List<BlocListener> prefsListeners = [
    BlocListener<PrefsCalendarBloc, PrefsCalendarState>(
      listener: (context, state) {
        if (state is PrefsCalendarLoaded) {
          BlocProvider.of<PrefsCalendarDataCubit>(context).setInitialData(
            state.data,
          );
        }
      },
    ),
  ];
}
