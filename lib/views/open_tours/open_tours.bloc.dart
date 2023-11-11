import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:flutter/foundation.dart';

import '../../api/api.dart';

class OpenToursBloc extends Bloc<OpenToursEvent, OpenToursState> {
  //TODO handle filters
  OpenToursBloc() : super(OpenToursInitial()) {
    on<GetOpenTours>(
      (event, emit) async {
        try {
          final user = Api.getUser()!;
          emit(OpenToursLoading());
          final tours = (await Api.request<List>('/tours',
                  options: Options(method: 'GET'),
                  queryParameters: {
                'from': DateTime.now(),
                'to': DateTime.now().add(const Duration(days: 90)),
                'centerLongitude': user.longitude,
                'centerLatitude': user.latitude,
                'geoRadius': user.maximumCareRadius
              }))
              .map((e) => TourModel.fromJson(e))
              .where((e) => e.ownerNurseId != Api.getUser()!.id)
              .toList(growable: false);
          emit(OpenToursLoaded(tours));
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

abstract class OpenToursEvent extends Equatable {
  const OpenToursEvent();

  @override
  List<Object> get props => [];
}

class GetOpenTours extends OpenToursEvent {}

abstract class OpenToursState extends Equatable {
  const OpenToursState();

  @override
  List<Object> get props => [];
}

class OpenToursInitial extends OpenToursState {}

class OpenToursLoading extends OpenToursState {}

class OpenToursLoaded extends OpenToursState {
  final List<TourModel> tours;

  const OpenToursLoaded(this.tours);
}

class OpenToursError extends OpenToursState {
  final String error;

  const OpenToursError(this.error);
}
