import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';

import '../../../api/api.dart';

part 'completed_tours_event.dart';

part 'completed_tours_state.dart';

class CompletedToursBloc
    extends Bloc<CompletedToursEvent, CompletedToursState> {
  CompletedToursBloc() : super(CompletedToursInitial()) {
    on<GetCompletedTours>(
      (event, emit) async {
        try {
          emit(CompletedToursLoading());
          final tours = (await Api.request<List>(
                  '/tour-actuals/${Api.getUser()!.id}',
                  options: Options(method: 'GET')))
              .map((e) => TourModel.fromJson(e))
              .toList(growable: false);
          emit(CompletedToursLoaded(tours));
        } catch (e) {
          emit(CompletedToursError(e.toString()));
        }
      },
    );
  }
}
