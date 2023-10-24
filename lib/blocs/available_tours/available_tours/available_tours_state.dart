part of 'available_tours_bloc.dart';

abstract class AvailableToursState extends Equatable {
  const AvailableToursState();

  @override
  List<Object> get props => [];
}

class AvailableToursInitial extends AvailableToursState {}

class AvailableToursLoading extends AvailableToursState {}

class AvailableToursLoaded extends AvailableToursState {
  final List<TourModel> tours;

  const AvailableToursLoaded(this.tours);
}

class AvailableToursError extends AvailableToursState {
  final String error;

  const AvailableToursError(this.error);
}
