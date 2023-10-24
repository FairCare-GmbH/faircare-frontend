part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserDataInitial extends UserState {}

class UserDataLoading extends UserState {}

class UserDataLoaded extends UserState {
  final UserModel user;

  const UserDataLoaded(this.user);
}

class UserDataError extends UserState {
  final String error;

  const UserDataError(this.error);
}
