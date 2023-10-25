import 'package:bloc/bloc.dart';
import 'package:faircare/global/constants.dart';

class PrefsCalendarCubit extends Cubit<PrefsCalendarCubitState> {
  PrefsCalendarCubit() : super(PrefsCalendarCubitState());

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

class PrefsCalendarCubitState {
  DateTime dateTime;
  String month;

  PrefsCalendarCubitState({
    DateTime? dateTime,
    String? month,
  })  : dateTime = dateTime ?? DateTime.now(),
        month = month ?? months[DateTime.now().month - 1];

  PrefsCalendarCubitState copyWith({
    DateTime? dateTime,
    String? month,
  }) {
    return PrefsCalendarCubitState(
      dateTime: dateTime ?? this.dateTime,
      month: month ?? this.month,
    );
  }
}
