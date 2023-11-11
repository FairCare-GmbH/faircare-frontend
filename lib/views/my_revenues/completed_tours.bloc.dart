import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/tour_model.dart';

import '../../api/api.dart';

class CompletedToursBloc
    extends Bloc<CompletedToursEvent, CompletedToursState> {
  CompletedToursBloc() : super(CompletedToursInitial()) {
    on<GetCompletedTours>(
      (event, emit) async {
        try {
          emit(CompletedToursLoading());
          final tours = (await Api.request<List>('/tours/mine',
              options: Options(method: 'GET'),
              queryParameters: {
                'from': DateTime.now().ymd,
                'to': DateTime.now().ymd.subtract(const Duration(days: 90)),
              }))
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

abstract class CompletedToursEvent extends Equatable {
  const CompletedToursEvent();

  @override
  List<Object> get props => [];
}

class GetCompletedTours extends CompletedToursEvent {}

abstract class CompletedToursState extends Equatable {
  const CompletedToursState();

  @override
  List<Object> get props => [];
}

class CompletedToursInitial extends CompletedToursState {}

class CompletedToursLoading extends CompletedToursState {}

class CompletedToursLoaded extends CompletedToursState {
  final List<TourModel> tours;

  const CompletedToursLoaded(this.tours);
}

class CompletedToursError extends CompletedToursState {
  final String error;

  const CompletedToursError(this.error);
}
