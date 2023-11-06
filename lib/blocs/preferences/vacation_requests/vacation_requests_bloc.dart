import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/vacation_model.dart';

import '../../../api/api.dart';

part 'vacation_requests_event.dart';

class VacationRequestsBloc
    extends Bloc<VacationRequestsEvent, VacationRequestsState> {
  VacationRequestsBloc() : super(VacationRequestsInitial()) {
    on<GetVacationRequests>(
      (event, emit) async {
        try {
          emit(VacationRequestsLoading());
          emit(VacationRequestsLoaded(
              (await Api.request<List<dynamic>>(
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

abstract class VacationRequestsState extends Equatable {
  const VacationRequestsState();

  @override
  List<Object> get props => [];
}

class VacationRequestsInitial extends VacationRequestsState {}

class VacationRequestsLoading extends VacationRequestsState {}

class VacationRequestsLoaded extends VacationRequestsState {
  final List<VacationModel> vacations;

  const VacationRequestsLoaded(this.vacations);
}

class VacationRequestsError extends VacationRequestsState {
  final String error;

  const VacationRequestsError(this.error);
}
