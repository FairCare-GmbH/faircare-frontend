part of 'requested_tours_bloc.dart';

abstract class RequestedToursEvent extends Equatable {
  const RequestedToursEvent();

  @override
  List<Object> get props => [];
}

class GetRequestedTours extends RequestedToursEvent {}
