import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/tour_model.dart';

import '../../api/api.dart';

part 'my_tours_event.dart';

part 'my_tours_state.dart';

class MyToursBloc extends Bloc<MyToursEvent, MyToursState> {
  MyToursBloc() : super(MyToursInitial()) {
    on<GetMyTours>(
      (event, emit) async {
        try {
          emit(MyToursLoading());
          final tours = (await Api.request<List>(
                  '/tour-plans/${Api.getUser()!.id}',
                  options: Options(method: 'GET')))
              .map((e) => TourModel.fromJson(e))
              .toList(growable: false);
          emit(MyToursLoaded(tours));
        } catch (e) {
          emit(MyToursError(e.toString()));
        }
      },
    );
  }
}
