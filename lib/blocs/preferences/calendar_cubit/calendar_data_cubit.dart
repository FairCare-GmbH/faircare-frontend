import 'package:bloc/bloc.dart';
import 'package:faircare/models/calendar_model.dart';

class PrefsCalendarDaysCubit extends Cubit<List<CalendarModel>> {
  PrefsCalendarDaysCubit() : super([]);

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
