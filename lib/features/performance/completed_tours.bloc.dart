import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class CompletedToursBloc
    extends Bloc<CompletedToursEvent, CompletedToursState> {
  CompletedToursBloc() : super(CompletedToursInitial()) {
    on<GetCompletedTours>(
      (event, emit) async {
        try {
          if (state is! CompletedToursLoaded) {
            emit(CompletedToursLoading());
          }
          final tours = (await Api.request<List>('/tours/mine/completed',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': event.from,
                'to': event.to,
              }))
              .map((e) => TourModel.fromJson(e))
              .toList(growable: false);
          emit(CompletedToursLoaded(
              tours, event.from, event.to, event.searchType));
        } catch (e, stack) {
          if(kDebugMode){
            print(e);
            print(stack);
          }
          emit(CompletedToursError(e.toString()));
        }
      },
    );
  }
}

abstract class CompletedToursEvent {
  CompletedToursEvent();
}

class GetCompletedTours extends CompletedToursEvent {
  final DateTime from;
  final DateTime to;
  final int searchType;

  GetCompletedTours(
      {required this.from, required this.to, required this.searchType});
}

abstract class CompletedToursState {
  CompletedToursState();
}

class CompletedToursInitial extends CompletedToursState {}

class CompletedToursLoading extends CompletedToursState {}

class CompletedToursLoaded extends CompletedToursState {
  final List<TourModel> tours;
  final DateTime from;
  final DateTime to;
  final int searchType;

  CompletedToursLoaded(this.tours, this.from, this.to, this.searchType);
}

class CompletedToursError extends CompletedToursState {
  final String error;

  CompletedToursError(this.error);
}
