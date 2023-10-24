part of 'available_tours_bloc.dart';

abstract class AvailableToursEvent extends Equatable {
  const AvailableToursEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableTours extends AvailableToursEvent {}
