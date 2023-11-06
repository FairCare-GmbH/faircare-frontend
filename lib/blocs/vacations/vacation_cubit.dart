import 'package:bloc/bloc.dart';

class VacationCubit extends Cubit<VacationCubitState> {
  VacationCubit() : super(VacationCubitState());

  void setStartDate(DateTime date) {
    emit(VacationCubitState(startDate: date, endDate: null));
  }

  void setEndDate(DateTime? date) {
    emit(VacationCubitState(startDate: state.startDate, endDate: date));
  }

  void setStartEndDate(DateTime? startDate, DateTime? endDate) {
    emit(VacationCubitState(startDate: startDate, endDate: endDate));
  }
}

class VacationCubitState {
  DateTime? startDate, endDate;

  VacationCubitState({this.startDate, this.endDate});
}
