part of 'vacation_requests_bloc.dart';

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
