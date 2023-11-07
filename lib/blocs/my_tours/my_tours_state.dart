part of 'my_tours_bloc.dart';

abstract class MyToursState extends Equatable {
  const MyToursState();

  @override
  List<Object> get props => [];
}

class MyToursInitial extends MyToursState {}

class MyToursLoading extends MyToursState {}

class MyToursLoaded extends MyToursState {
  final List<TourModel> tours;

  const MyToursLoaded(this.tours);
}

class MyToursError extends MyToursState {
  final String error;

  const MyToursError(this.error);
}
