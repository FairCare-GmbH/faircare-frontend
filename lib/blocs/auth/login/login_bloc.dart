import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/repos/auth/auth_repo.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final auth = AuthRepo();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>(
      (event, Emitter<LoginState> emit) async {
        // starting login user
        try {
          emit(LoginLoadingState());

          final user = await auth.loginUser(
            event.username,
            event.password,
          );
          debugPrint(user.toString());
          //TODO add user to auth repo?
        } catch (e) {
          emit(LoginFailState(e.toString()));
        }
      },
    );

    on<LogoutUserEvent>(
      (event, Emitter<LoginState> emit) async {
        try {
          emit(LogoutLoadingState());
          final result = await auth.logoutUser();
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
