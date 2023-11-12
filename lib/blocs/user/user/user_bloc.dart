import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/nurse_rating.model.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../api/api.dart';

part 'user_event.dart';

part 'user_state.dart';

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
