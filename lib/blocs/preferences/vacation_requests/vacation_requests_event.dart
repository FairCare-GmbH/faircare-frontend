part of 'vacation_requests_bloc.dart';

abstract class VacationRequestsEvent extends Equatable {
  const VacationRequestsEvent();

  @override
  List<Object> get props => [];
}

class GetVacationRequests extends VacationRequestsEvent {}
