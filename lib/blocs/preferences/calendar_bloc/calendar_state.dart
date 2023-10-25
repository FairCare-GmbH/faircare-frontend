part of 'calendar_bloc.dart';

abstract class PrefsCalendarState extends Equatable {
  const PrefsCalendarState();

  @override
  List<Object> get props => [];
}

class PrefsCalendarInitial extends PrefsCalendarState {}

class PrefsCalendarLoading extends PrefsCalendarState {}

class PrefsCalendarLoaded extends PrefsCalendarState {
  final List<CalendarModel> data;

  const PrefsCalendarLoaded(this.data);
}

class PrefsCalendarError extends PrefsCalendarState {
  final String error;

  const PrefsCalendarError(this.error);
}
