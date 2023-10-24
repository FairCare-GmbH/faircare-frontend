part of 'assigned_tours_bloc.dart';

abstract class AssignedToursEvent extends Equatable {
  const AssignedToursEvent();

  @override
  List<Object> get props => [];
}

class GetAssignedTours extends AssignedToursEvent {}
