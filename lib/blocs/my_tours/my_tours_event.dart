part of 'my_tours_bloc.dart';

abstract class MyToursEvent extends Equatable {
  const MyToursEvent();

  @override
  List<Object> get props => [];
}

class GetMyTours extends MyToursEvent {}
