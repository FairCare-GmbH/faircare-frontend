import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/features/ratings/nurse_rating.model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class RatingsBloc extends Bloc<RatingsEvent, RatingsState> {
  RatingsBloc() : super(RatingsDataInitial()) {
    on<GetRatingsData>(
      (event, emit) async {
        try {
          emit(RatingsDataLoading());
          emit(RatingsDataLoaded(
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

abstract class RatingsEvent {
  RatingsEvent();
}

class GetRatingsData extends RatingsEvent {}

abstract class RatingsState {
  RatingsState();
}

class RatingsDataInitial extends RatingsState {}

class RatingsDataLoading extends RatingsState {}

class RatingsDataLoaded extends RatingsState {
  final NurseRatingModel ratings;

  RatingsDataLoaded({required this.ratings});
}

class UserDataError extends RatingsState {
  final String error;

  UserDataError(this.error);
}
