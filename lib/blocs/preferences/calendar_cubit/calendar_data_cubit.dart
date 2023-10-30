import 'package:bloc/bloc.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/calendar_model.dart';

class PrefsCalendarDaysCubit extends Cubit<List<CalendarModel>> {
  PrefsCalendarDaysCubit() : super([]);

  void setInitialData(List<CalendarModel> data) {
    emit(data);
  }

  void incrementDay(DateTime day) {
    final List<CalendarModel> models = getDayData(state, day);
    final CalendarModel? dayModel = models
        .where((e) => e.fromDate.isSameDay(e.toDate) && e.tourType != 0)
        .firstOrNull;
    final CalendarModel? weekModel = models
        .where((e) => !e.fromDate.isSameDay(e.toDate) && e.tourType != 0)
        .firstOrNull;
    final CalendarModel? vacationModel =
        models.where((e) => e.tourType == 0).firstOrNull;

    if (vacationModel != null ||
        weekModel?.tourType == 3 ||
        dayModel?.assignedTourType == 3 ||
        (weekModel != null && dayModel?.assignedTourType != null)) {
      return;
    }

    int? newType;
    if (weekModel != null) {
      newType = weekModel.tourType % 2 + 1;
      if (newType == dayModel?.tourType) newType = null;
    } else if (dayModel?.assignedTourType != null) {
      newType = dayModel!.tourType == 3 ? dayModel.assignedTourType! : 3;
    } else {
      newType = (dayModel?.tourType ?? 0) + 1;
      if (newType == 4) newType = null;
    }

    List<CalendarModel> updatedData =
        state.where((e) => !_isDayMatch(e, day)).toList();

    if (vacationModel != null) updatedData.add(vacationModel);
    if (weekModel != null) updatedData.add(weekModel);
    if (newType != null) {
      updatedData.add(dayModel != null
          ? dayModel.copyWith(tourType: newType)
          : CalendarModel(
              fromDate: day.ymd,
              toDate: day.ymd,
              dayOfWeek: day.weekday,
              tourType: newType,
              assignedTourType: null,
            ));
    }

    emit(updatedData);
  }

  void incrementWeek(int weekday) {
    final List<CalendarModel> models =
        state.where((e) => e.dayOfWeek == weekday).toList(growable: false);
    final List<CalendarModel> dayModels = models
        .where((e) => e.fromDate.isSameDay(e.toDate) && e.tourType != 0)
        .toList(growable: false);
    final CalendarModel? weekModel = models
        .where((e) => !e.fromDate.isSameDay(e.toDate) && e.tourType != 0)
        .firstOrNull;
    final CalendarModel? vacationModel =
        models.where((e) => e.tourType == 0).firstOrNull;

    if (weekModel?.assignedTourType == 3) return;

    int? newType;
    if (weekModel?.assignedTourType != null) {
      newType = weekModel!.tourType == 3 ? weekModel.assignedTourType! : 3;
    } else {
      newType = (weekModel?.tourType ?? 0) + 1;
      if (newType == 4) newType = null;
    }

    List<CalendarModel> updatedData =
        state.where((e) => e.dayOfWeek != weekday).toList();

    if (vacationModel != null) updatedData.add(vacationModel);
    if (newType != null) {
      updatedData.add(weekModel != null
          ? weekModel.copyWith(
              tourType: newType,
              fromDate: DateTime.now().ymd,
              toDate: DateTime(DateTime.now().year + 15).ymd,
            )
          : CalendarModel(
              fromDate: DateTime.now().ymd,
              toDate: DateTime(DateTime.now().year + 15).ymd,
              dayOfWeek: weekday,
              tourType: newType,
              assignedTourType: null,
            ));
    }

    updatedData.addAll(dayModels
        .where((e) => e.assignedTourType != null || e.tourType != newType));

    emit(updatedData);
  }

  static bool _isDayMatch(CalendarModel model, DateTime day) =>
      model.fromDate.isSameDay(day) && model.toDate.isSameDay(day) ||
      _isWeekDayMatch(model, day.weekday);

  static bool _isWeekDayMatch(CalendarModel model, int weekday) =>
      !model.fromDate.isSameDay(model.toDate) && model.dayOfWeek == weekday;

  static List<CalendarModel> getDayData(
          List<CalendarModel> state, DateTime day) =>
      state
          .where(
            (e) => _isDayMatch(e, day),
          )
          .toList(growable: false);
}
