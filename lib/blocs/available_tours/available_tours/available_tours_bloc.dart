import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';

import '../../../api/api.dart';

part 'available_tours_event.dart';

part 'available_tours_state.dart';

class AvailableToursBloc
    extends Bloc<AvailableToursEvent, AvailableToursState> {
  AvailableToursBloc() : super(AvailableToursInitial()) {
    on<GetAvailableTours>(
      (event, emit) async {
        try {
          emit(AvailableToursLoading());
          final tours = (await Api.request<List>('/tour-plans',
                  options: Options(method: 'GET')))
              .map((e) => TourModel.fromJson(e))
              .where((e) => e.ownerNurseId != Api.getUser()!.id)
              .toList(growable: false);
          emit(AvailableToursLoaded(tours));
        } catch (e) {
          emit(AvailableToursError(e.toString()));
        }
      },
    );
  }
}
