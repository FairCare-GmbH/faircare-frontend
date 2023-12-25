import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';
import 'nurse_list_item.dto.dart';

class NewRatingBloc extends Bloc<NewRatingEvent, NewRatingState> {
  NewRatingBloc() : super(NewRatingDataInitial()) {
    on<GetNursesForPatient>(
      (event, emit) async {
        try {
          emit(NewRatingDataLoading());
          emit(NewRatingDataLoaded(
              nurses: (await Api.request<List>(
                      '/nurses/for-patient/${event.patientId}',
                      options: Options(method: 'GET'),
                      queryParameters: {
                'from': DateTime.now().subtract(const Duration(days: 14)),
                'to': DateTime.now()
              }))
                  .map((e) => NurseListItemDto.fromJson(e))
                  .toList()));
        } catch (e, s) {
          if (kDebugMode) {
            print(e);
            print(s);
          }
          emit(UserDataError(e.toString()));
        }
      },
    );

    on<UpdateState>(
      (event, emit) async {
        emit(event.newState);
      },
    );
  }
}

abstract class NewRatingEvent {
  NewRatingEvent();
}

class GetNursesForPatient extends NewRatingEvent {
  final int patientId;

  GetNursesForPatient({required this.patientId});
}

class UpdateState extends NewRatingEvent {
  final NewRatingDataLoaded newState;

  UpdateState({required this.newState});
}

abstract class NewRatingState {
  NewRatingState();
}

class NewRatingDataInitial extends NewRatingState {}

class NewRatingDataLoading extends NewRatingState {}

class NewRatingDataLoaded extends NewRatingState {
  final List<NurseListItemDto> nurses;
  final int rating;
  final int selectedIndex;
  final bool isPatientFeedback;

  NewRatingDataLoaded(
      {required this.nurses,
      this.rating = 0,
      this.selectedIndex = -1,
      this.isPatientFeedback = false});
}

class UserDataError extends NewRatingState {
  final String error;

  UserDataError(this.error);
}
