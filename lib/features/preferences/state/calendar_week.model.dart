import 'package:faircare/global/extensions.dart';

import '../preference_item.model.dart';
import 'calendar_day.model.dart';

class CalendarWeekModel {
  final int weekday;
  final List<PreferenceItemModel> weekPrefs;

  final List<CalendarDayModel> dayPrefs = [];

  CalendarWeekModel({
    required this.weekday,
    required this.weekPrefs,
  });

  PreferenceItemModel? get f =>
      weekPrefs.where((e) => e.type == 1 && e.endDate.isInFuture).firstOrNull;

  PreferenceItemModel? get s =>
      weekPrefs.where((e) => e.type == 2 && e.endDate.isInFuture).firstOrNull;

  PreferenceItemModel? getFForDate(DateTime day) => weekPrefs
      .where((e) =>
          e.type == 1 &&
          e.startDate.isSameDayOrBefore(day) &&
          e.endDate.isSameDayOrAfter(day))
      .firstOrNull;

  PreferenceItemModel? getSForDate(DateTime day) => weekPrefs
      .where((e) =>
          e.type == 2 &&
          e.startDate.isSameDayOrBefore(day) &&
          e.endDate.isSameDayOrAfter(day))
      .firstOrNull;

  bool get isF => f != null;

  bool get isS => s != null;

  bool incrementWeek() {
    if (isF && isS) {
      final s = this.s!;
      if (s.endDate
          .isBefore(DateTime.now().ymd.add(const Duration(days: 365 * 50)))) {
        weekPrefs.remove(s);
        weekPrefs.add(s.copyWith(endDate: DateTime.now().ymd));
        return incrementWeek();
      }

      final List<PreferenceItemModel> toAdd = [];
      for (var w in weekPrefs) {
        if (!w.startDate.isInFuture && w.endDate.isInFuture) {
          toAdd.add(w.copyWith(endDate: DateTime.now().ymd));
        }
      }
      weekPrefs.removeWhere((e) => e.endDate.isInFuture);
      weekPrefs.addAll(toAdd);
    } else if (isF) {
      final f = this.f!;
      if (f.endDate
          .isBefore(DateTime.now().ymd.add(const Duration(days: 14)))) {
        weekPrefs.remove(f);
        weekPrefs.add(f.copyWith(endDate: DateTime.now().ymd));
        return incrementWeek();
      }else{
        weekPrefs.remove(f);
      }

      for (var d in dayPrefs) {
        if (!d.isInPast && d.isS) {
          d.dayPrefs.remove(d.s);
        }
      }

      weekPrefs.add(PreferenceItemModel(
          startDate: DateTime.now().ymd.add(const Duration(days: 1)),
          endDate: DateTime.now().ymd.add(const Duration(days: 365 * 50)),
          dayOfWeek: weekday,
          type: 2));
    } else {
      for (var d in dayPrefs) {
        if (!d.isInPast && d.isF) {
          d.dayPrefs.remove(d.f);
        }
      }
      weekPrefs.add(PreferenceItemModel(
          startDate: DateTime.now().ymd.add(const Duration(days: 1)),
          endDate: DateTime.now().ymd.add(const Duration(days: 365 * 50)),
          dayOfWeek: weekday,
          type: 1));
    }
    return true;
  }
}
