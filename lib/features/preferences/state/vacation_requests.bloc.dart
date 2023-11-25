import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/vacation_model.dart';

import '../../../api/api.dart';

class VacationRequestsBloc
    extends Bloc<VacationRequestsEvent, VacationRequestsState> {
  VacationRequestsBloc() : super(VacationRequestsInitial()) {
    on<GetVacationRequests>(
      (event, emit) async {
        try {
          emit(VacationRequestsLoading());
          emit(VacationRequestsLoaded((await Api.request<List<dynamic>>(
                  '/preferences/${Api.getUser()!.id}/vacation-requests',
                  options: Options(method: 'GET')))
              .map((e) => VacationModel.fromJson(e))
              .toList(growable: false)));
        } catch (e) {
          emit(VacationRequestsError(e.toString()));
        }
      },
    );
  }
}

abstract class VacationRequestsState {
  VacationRequestsState();
}

class VacationRequestsInitial extends VacationRequestsState {}

class VacationRequestsLoading extends VacationRequestsState {}

class VacationRequestsLoaded extends VacationRequestsState {
  final List<VacationModel> vacations;

  VacationRequestsLoaded(this.vacations);
}

class VacationRequestsError extends VacationRequestsState {
  final String error;

  VacationRequestsError(this.error);
}

abstract class VacationRequestsEvent extends Equatable {
  const VacationRequestsEvent();

  @override
  List<Object> get props => [];
}

class GetVacationRequests extends VacationRequestsEvent {}
