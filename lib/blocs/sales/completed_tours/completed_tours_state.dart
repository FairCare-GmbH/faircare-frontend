part of 'completed_tours_bloc.dart';

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
