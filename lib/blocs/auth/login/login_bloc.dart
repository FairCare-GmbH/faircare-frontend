import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>(
      (event, Emitter<LoginState> emit) async {
        // starting login user
        try {
          emit(LoginSuccessState());
        } catch (e) {
          emit(LoginFailState(e.toString()));
        }
      },
    );

    on<LogoutUserEvent>(
      (event, Emitter<LoginState> emit) async {
        try {
          emit(LogoutLoadingState());
          final result = await Api.logout();
          if (result['status']) {
            emit(LogoutSuccessState());
          } else {
            emit(const LogoutFailState(''));
          }
        } catch (e) {
          emit(LogoutFailState(e.toString()));
        }
      },
    );
  }
}
