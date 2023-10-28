import 'package:bloc/bloc.dart';
import 'package:faircare/global/constants.dart';

class VacationCubit extends Cubit<VacationCubitState> {
  VacationCubit() : super(VacationCubitState());

  void setStartDate(DateTime date) {
    emit(state.copyWith(startDate: date, endDate: null));
    print(state.startDate);
    print(state.endDate);
  }

  void setEndDate(DateTime date) {
    emit(state.copyWith(endDate: date));
    print(state.startDate);
    print(state.endDate);
  }
}

class VacationCubitState {
  DateTime? startDate, endDate;

  VacationCubitState({
    this.startDate,
    this.endDate,
  });

  VacationCubitState copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return VacationCubitState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
