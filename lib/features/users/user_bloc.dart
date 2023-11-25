import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/features/ratings/nurse_rating.model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserDataInitial()) {
    on<GetUserData>(
      (event, emit) async {
        try {
          emit(UserDataLoading());
          emit(UserDataLoaded(
              ratings: NurseRatingModel.fromJson(await Api.request(
                  '/nurses/my/ratings',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': DateTime.now().subtract(const Duration(days: 185)),
                'to': DateTime.now()
              }))));
        } catch (e, s) {
          if (kDebugMode) {
            print(e);
            print(s);
          }
          emit(UserDataError(e.toString()));
        }
      },
    );
  }
}

abstract class UserEvent {
  UserEvent();
}

class GetUserData extends UserEvent {}

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
