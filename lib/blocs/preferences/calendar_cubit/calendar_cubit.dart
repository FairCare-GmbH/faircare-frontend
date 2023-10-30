import 'package:bloc/bloc.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/extensions.dart';

class PrefsCalendarMonthCubit extends Cubit<PrefsCalendarMonthCubitState> {
  PrefsCalendarMonthCubit() : super(PrefsCalendarMonthCubitState());

  void nextMonth() {
    emit(PrefsCalendarMonthCubitState(
        dateTime: DateTime(
      state._dateTime.year,
      state._dateTime.month + 1,
    )));
  }

  void previousMonth() {
    emit(PrefsCalendarMonthCubitState(
        dateTime: DateTime(
      state._dateTime.year,
      state._dateTime.month - 1,
    )));
  }

  void setMonth(DateTime dateTime) {
    emit(PrefsCalendarMonthCubitState(
        dateTime: DateTime(
      dateTime.year,
      dateTime.month,
    )));
  }
}

class PrefsCalendarMonthCubitState {
  final DateTime _dateTime;

  PrefsCalendarMonthCubitState({
    DateTime? dateTime,
  }) : _dateTime = DateTime((dateTime ?? DateTime.now().ymd).year,
            (dateTime ?? DateTime.now().ymd).month);

  DateTime getDate() => _dateTime;
}
