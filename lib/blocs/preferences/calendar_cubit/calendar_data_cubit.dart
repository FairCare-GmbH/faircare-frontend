import 'package:bloc/bloc.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/calendar_model.dart';

class PrefsCalendarDaysCubit extends Cubit<List<CalendarModel>> {
  PrefsCalendarDaysCubit() : super([]);

  void setInitialData(List<CalendarModel> data) {
    emit(data);
  }

  void updateData(DateTime date, int type) {
    final fromDate = date.ymd;

    bool modelExists = state.any((model) => model.fromDate == fromDate);

    List<CalendarModel> updatedData;

    if (modelExists) {
      updatedData = state.map((model) {
        if (model.fromDate == fromDate) {
          return model.copyWith(tourType: type);
        }
        return model;
      }).toList();
    } else {
      updatedData = List<CalendarModel>.from(state)
        ..add(
          CalendarModel(
            id: 0,
            nurseId: 0,
            fromDate: fromDate,
            toDate: fromDate,
            dayOfWeek: fromDate.weekday,
            tourType: type,
            hasAssignedTour: false,
          ),
        );
    }

    emit(updatedData);
  }
}
