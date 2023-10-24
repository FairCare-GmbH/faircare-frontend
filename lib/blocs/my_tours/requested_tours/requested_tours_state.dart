part of 'requested_tours_bloc.dart';

abstract class RequestedToursState extends Equatable {
  const RequestedToursState();

  @override
  List<Object> get props => [];
}

class RequestedToursInitial extends RequestedToursState {}

class RequestedToursLoading extends RequestedToursState {}

class RequestedToursLoaded extends RequestedToursState {
  final List<TourModel> tours;

  const RequestedToursLoaded(this.tours);
}

class RequestedToursError extends RequestedToursState {
  final String error;

  const RequestedToursError(this.error);
}
