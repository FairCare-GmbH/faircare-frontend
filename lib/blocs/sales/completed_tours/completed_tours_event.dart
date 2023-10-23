part of 'completed_tours_bloc.dart';

abstract class CompletedToursEvent extends Equatable {
  const CompletedToursEvent();

  @override
  List<Object> get props => [];
}

class GetCompletedTours extends CompletedToursEvent {}
