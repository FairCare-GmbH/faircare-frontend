import 'package:faircare/global/extensions.dart';
import 'package:faircare/views/preferences/state/calendar_week.model.dart';

import '../../../models/preference.model.dart';
import '../../../models/tour_model.dart';
import '../../../models/vacation_model.dart';

class CalendarDayModel {
  final DateTime day;

  final List<PreferenceModel> dayPrefs;
  final CalendarWeekModel weekPrefs;
  final List<TourModel> tours;
  final VacationModel? vacationRequest;

  CalendarDayModel(
      {required this.day,
      required this.dayPrefs,
      required this.weekPrefs,
      required this.tours,
      required this.vacationRequest}) {
    weekPrefs.dayPrefs.add(this);
  }

  PreferenceModel? get f =>
      dayPrefs.where((e) => e.type == 1).firstOrNull ??
      weekPrefs.getFForDate(day.ymd);

  PreferenceModel? get s =>
      dayPrefs.where((e) => e.type == 2).firstOrNull ??
      weekPrefs.getSForDate(day.ymd);

  bool get isF => f != null;

  bool get isS => s != null;

  bool get isFAssigned => tours.any((e) => e.type == 1);

  bool get isSAssigned => tours.any((e) => e.type == 2);

  bool get isU => vacationRequest != null;

  bool get isUAssigned => !isFAssigned && !isSAssigned && isU;

  bool get isInPast => day.ymd.isTodayOrInPast;

  bool get isFWeek {
    var f = this.f;
    return f != null && !f.startDate.isSameDay(f.endDate);
  }

  bool get isSWeek {
    var s = this.s;
    return s != null && !s.startDate.isSameDay(s.endDate);
  }

  bool get isFDay {
    var f = this.f;
    return f != null && f.startDate.isSameDay(f.endDate);
  }

  bool get isSDay {
    var s = this.s;
    return s != null && s.startDate.isSameDay(s.endDate);
  }

  bool incrementDay() {
    if (isInPast ||
        isU ||
        (isFWeek && isSWeek) || //max two different types: 1 and 2
        (isFAssigned && isSAssigned) || //max two different types: 1 and 2
        (isFWeek && isSDay && isSAssigned) ||
        (isSWeek && isFDay && isFAssigned)) {
      return false;
    }

    if (isFWeek || isFAssigned) {
      if (isS) {
        dayPrefs.remove(s);
      } else {
        dayPrefs.add(PreferenceModel(
            startDate: day, endDate: day, dayOfWeek: day.weekday, type: 2));
      }
    } else if (isSWeek || isSAssigned) {
      if (isF) {
        dayPrefs.remove(f);
      } else {
        dayPrefs.add(PreferenceModel(
            startDate: day, endDate: day, dayOfWeek: day.weekday, type: 1));
      }
    } else {
      if (isF && isS) {
        dayPrefs.clear();
      } else if (isF) {
        dayPrefs.add(PreferenceModel(
            startDate: day, endDate: day, dayOfWeek: day.weekday, type: 2));
      } else {
        dayPrefs.add(PreferenceModel(
            startDate: day, endDate: day, dayOfWeek: day.weekday, type: 1));
      }
    }
    return true;
  }
}
