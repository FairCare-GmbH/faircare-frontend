import 'package:bloc/bloc.dart';
import 'package:faircare/models/calendar_model.dart';

class PrefsCalendarDataCubit extends Cubit<List<CalendarModel>> {
  PrefsCalendarDataCubit() : super([]);

  void setInitialData(List<CalendarModel> data) {
    emit(data);
  }

  void updateData(DateTime fromDate, int type) {
    List<CalendarModel> updatedData = state.map((model) {
      if (model.fromDate == fromDate) {
        return model.copyWith(tourType: type);
      }
      return model;
    }).toList();

    emit(updatedData);
  }
}
