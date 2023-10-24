part of 'assigned_tours_bloc.dart';

abstract class AssignedToursState extends Equatable {
  const AssignedToursState();

  @override
  List<Object> get props => [];
}

class AssignedToursInitial extends AssignedToursState {}

class AssignedToursLoading extends AssignedToursState {}

class AssignedToursLoaded extends AssignedToursState {
  final List<TourModel> tours;

  const AssignedToursLoaded(this.tours);
}

class AssignedToursError extends AssignedToursState {
  final String error;

  const AssignedToursError(this.error);
}
