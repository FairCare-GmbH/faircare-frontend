import 'package:faircare/blocs/auth/login/login_bloc.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/widgets/snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/navigation/navigation.view.dart';

class BlocListeners {
  static final List<BlocListener> authListeners = [
    BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginEmptyFieldsState) {
          showSnackBar(context, 'Complete all fields');
        }
        if (state is LoginLoadingState) {}
        if (state is LoginSuccessState) {
          navigate(context, const NavigationView());
        }
        if (state is LoginFailState) {}
      },
    ),
  ];
}
