part of 'user_bloc.dart';

abstract class UserState {
  UserState();
}

class UserDataInitial extends UserState {}

class UserDataLoading extends UserState {}

class UserDataLoaded extends UserState {
  final NurseRatingModel ratings;

  UserDataLoaded({required this.ratings});
}

class UserDataError extends UserState {
  final String error;

  UserDataError(this.error);
}
