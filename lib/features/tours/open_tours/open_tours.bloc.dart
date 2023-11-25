import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:flutter/foundation.dart';

import '../../../api/api.dart';


class OpenToursBloc extends Bloc<OpenToursEvent, OpenToursState> {
  OpenToursBloc() : super(OpenToursInitial()) {
    on<GetOpenTours>(
      (event, emit) async {
        try {
          final user = Api.getUser()!;
          if (state is! OpenToursLoaded) {
            emit(OpenToursLoading());
          }
          final tours = (await Api.request<List>('/tours',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': event.from,
                'to': event.to,
                'centerLongitude': user.longitude,
                'centerLatitude': user.latitude,
                'geoRadius': user.maximumCareRadius
              }))
              .map((e) => TourModel.fromJson(e))
              .where((e) => e.ownerNurseId != Api.getUser()!.id)
              .toList(growable: false);
          emit(OpenToursLoaded(tours, event.from, event.to, event.searchType));
        } catch (e, s) {
          if (kDebugMode) {
            print(e.toString());
            print(s);
          }
          emit(OpenToursError(e.toString()));
        }
      },
    );
  }
}

abstract class OpenToursEvent {
  OpenToursEvent();
}

class GetOpenTours extends OpenToursEvent {
  final DateTime from;
  final DateTime to;
  final int searchType;

  GetOpenTours(
      {required this.from, required this.to, required this.searchType});
}

abstract class OpenToursState {
  OpenToursState();
}

class OpenToursInitial extends OpenToursState {}

class OpenToursLoading extends OpenToursState {}

class OpenToursLoaded extends OpenToursState {
  final List<TourModel> tours;
  final DateTime from;
  final DateTime to;
  final int searchType;

  OpenToursLoaded(this.tours, this.from, this.to, this.searchType);
}

class OpenToursError extends OpenToursState {
  final String error;

  OpenToursError(this.error);
}
