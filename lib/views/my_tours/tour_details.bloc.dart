import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/my_tours/tour_visit.model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';
import '../../models/patient.model.dart';

class TourDetailsBloc extends Bloc<TourDetailsEvent, TourDetailsState> {
  TourDetailsBloc() : super(TourDetailsInitial()) {
    on<GetTourDetails>(
      (event, emit) async {
        try {
          emit(TourDetailsLoading());
          final data = await Api.request('/tours/${event.tourId}',
              options: Options(method: 'GET'));

          final stops = (data['stops'] as List)
              .map((e) => TourDetailsItem(
                  visit: TourVisitModel.fromJson(e['visit']),
                  patient: e['patient'] != null
                      ? PatientModel.fromJson(e['patient'])
                      : null))
              .toList(growable: false);

          emit(TourDetailsLoaded(
              tour: TourModel.fromJson(data['tour']), visits: stops));
        } catch (e, s) {
          if (kDebugMode) {
            print(e.toString());
            print(s);
          }
          emit(TourDetailsError(e.toString()));
        }
      },
    );
  }
}

abstract class TourDetailsEvent {
  TourDetailsEvent();
}

class GetTourDetails extends TourDetailsEvent {
  final int tourId;

  GetTourDetails(this.tourId);
}

abstract class TourDetailsState {
  TourDetailsState();
}

class TourDetailsInitial extends TourDetailsState {}

class TourDetailsLoading extends TourDetailsState {}

class TourDetailsItem {
  final TourVisitModel visit;
  final PatientModel? patient;

  TourDetailsItem({required this.visit, required this.patient});
}

class TourDetailsLoaded extends TourDetailsState {
  final TourModel tour;
  final List<TourDetailsItem> visits;

  TourDetailsLoaded({required this.tour, required this.visits});
}

class TourDetailsError extends TourDetailsState {
  final String error;

  TourDetailsError(this.error);
}
