import 'package:bloc/bloc.dart';
import 'package:faircare/global/constants.dart';

class PreferencesCalendarCubit extends Cubit<PreferencesCalendarState> {
  PreferencesCalendarCubit() : super(PreferencesCalendarState());

  void nextMonth() {
    DateTime dateTime = state.dateTime;
    DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month + 1,
      dateTime.day,
    );

    emit(state.copyWith(
      dateTime: newDateTime,
      month: months[newDateTime.month - 1],
    ));
  }

  void previousMonth() {
    DateTime dateTime = state.dateTime;
    DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month - 1,
      dateTime.day,
    );

    emit(state.copyWith(
      dateTime: newDateTime,
      month: months[newDateTime.month - 1],
    ));
  }

  void setMonth(DateTime dateTime) {
    DateTime newDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );

    emit(state.copyWith(
      dateTime: newDateTime,
      month: months[newDateTime.month - 1],
    ));
  }
}

class PreferencesCalendarState {
  DateTime dateTime;
  String month;

  PreferencesCalendarState({
    DateTime? dateTime,
    String? month,
  })  : dateTime = dateTime ?? DateTime.now(),
        month = month ?? months[DateTime.now().month - 1];

  PreferencesCalendarState copyWith({
    DateTime? dateTime,
    String? month,
  }) {
    return PreferencesCalendarState(
      dateTime: dateTime ?? this.dateTime,
      month: month ?? this.month,
    );
  }
}
