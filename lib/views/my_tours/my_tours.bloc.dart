import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class MyToursBloc extends Bloc<MyToursEvent, MyToursState> {
  MyToursBloc() : super(MyToursInitial()) {
    on<GetMyTours>(
      (event, emit) async {
        try {
          emit(MyToursLoading());
          final tours = (await Api.request<List>('/tours/mine',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': DateTime.now().ymd,
                'to': DateTime.now().ymd.add(const Duration(days: 90)),
              }))
              .map((e) => TourModel.fromJson(e))
              .toList(growable: false);
          emit(MyToursLoaded(tours));
        } catch (e, s) {
          if (kDebugMode) {
            print(e.toString());
            print(s);
          }
          emit(MyToursError(e.toString()));
        }
      },
    );
  }
}

abstract class MyToursEvent extends Equatable {
  const MyToursEvent();

  @override
  List<Object> get props => [];
}

class GetMyTours extends MyToursEvent {}

abstract class MyToursState extends Equatable {
  const MyToursState();

  @override
  List<Object> get props => [];
}

class MyToursInitial extends MyToursState {}

class MyToursLoading extends MyToursState {}

class MyToursLoaded extends MyToursState {
  final List<TourModel> tours;

  const MyToursLoaded(this.tours);
}

class MyToursError extends MyToursState {
  final String error;

  const MyToursError(this.error);
}
