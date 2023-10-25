import 'package:faircare/blocs/auth/login/login_bloc.dart';
import 'package:faircare/blocs/preferences/calendar_bloc/calendar_bloc.dart';
import 'package:faircare/blocs/preferences/calendar_data_cubit/calendar_data_cubit.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/views/master/master.dart';
import 'package:faircare/widgets/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListeners {
  static final List<BlocListener> authListeners = [
    BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginEmptyFieldsState) {
          showSnackBar(context, 'Complete all fields');
        }
        if (state is LoginLoadingState) {}
        if (state is LoginSuccessState) {
          navigate(context, const MasterPage());
        }
        if (state is LoginFailState) {}
      },
    ),
  ];

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
