part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginEmptyFieldsState extends LoginState {}

class LoginInvalidEmailState extends LoginState {}

class LoginInvalidPasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailState extends LoginState {
  final String error;

  const LoginFailState(this.error);
}

class LogoutLoadingState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LogoutFailState extends LoginState {
  final String error;

  const LogoutFailState(this.error);
}
