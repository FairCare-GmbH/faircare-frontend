import 'package:bloc/bloc.dart';
import 'package:faircare/global/constants.dart';

class PrefsCalendarMonthCubit extends Cubit<PrefsCalendarMonthCubitState> {
  PrefsCalendarMonthCubit() : super(PrefsCalendarMonthCubitState());

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

class PrefsCalendarMonthCubitState {
  DateTime dateTime;
  String month;

  PrefsCalendarMonthCubitState({
    DateTime? dateTime,
    String? month,
  })  : dateTime = dateTime ?? DateTime.now(),
        month = month ?? months[DateTime.now().month - 1];

  PrefsCalendarMonthCubitState copyWith({
    DateTime? dateTime,
    String? month,
  }) {
    return PrefsCalendarMonthCubitState(
      dateTime: dateTime ?? this.dateTime,
      month: month ?? this.month,
    );
  }
}
