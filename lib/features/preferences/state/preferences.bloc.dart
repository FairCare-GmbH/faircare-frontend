import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:faircare/api/api.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/features/users/user.model.dart';

import '../preference_item.model.dart';
import '../../tours/tour.model.dart';
import '../../vacation/vacation.model.dart';
import 'calendar_day.model.dart';
import 'calendar_week.model.dart';

class PreferencesBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferencesBloc() : super(PreferenceInitial()) {
    on<GetPreferenceData>((event, emit) async {
      try {
        emit(PreferenceLoading());
        final now = DateTime.now();
        final from = DateTime(now.year, now.month - 1, 1);
        final to = DateTime(now.year, now.month + 2, 0);
        final data = (await Api.request<Map<String, dynamic>>(
            '/preferences/mine',
            options: Options(method: 'GET'),
            queryParameters: {
              'from': from,
              'to': to,
            }));

        emit(PreferenceLoaded(
            (data['preferences'] as List)
                .map((e) => PreferenceItemModel.fromJson(e))
                .toList(growable: false),
            UserModel.fromJson(data['nurse']),
            (data['vacationRequests'] as List)
                .map((e) => VacationModel.fromJson(e))
                .toList(growable: false),
            (data['assignedTours'] as List)
                .map((e) => TourModel.fromJson(e))
                .toList(growable: false)));
      } catch (error, stack) {
        emit(PreferenceError(error, stack));
      }
    });

    on<UpdatePreferenceData>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(
          event.preferences,
          event.userModel,
          event.vacationRequests,
          (state as PreferenceLoaded).tours,
        ));
      }
    });

    on<UpdatePreferenceUser>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(
          (state as PreferenceLoaded).preferences,
          event.userModel,
          (state as PreferenceLoaded).vacationRequests,
          (state as PreferenceLoaded).tours,
        ));
      }
    });

    on<UpdatePreferenceList>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(
          event.preferences,
          (state as PreferenceLoaded).userModel,
          (state as PreferenceLoaded).vacationRequests,
          (state as PreferenceLoaded).tours,
        ));
      }
    });

    on<PreferenceStateUpdated>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(event.state);
      }
    });
  }
}

abstract class PreferenceEvent {
  PreferenceEvent();
}

class GetPreferenceData extends PreferenceEvent {}

class UpdatePreferenceUser extends PreferenceEvent {
  final UserModel userModel;

  UpdatePreferenceUser(this.userModel);
}

class UpdatePreferenceData extends PreferenceEvent {
  final List<PreferenceItemModel> preferences;
  final UserModel userModel;
  final List<VacationModel> vacationRequests;

  UpdatePreferenceData(this.preferences, this.userModel, this.vacationRequests);
}

class UpdatePreferenceList extends PreferenceEvent {
  final List<PreferenceItemModel> preferences;

  UpdatePreferenceList(this.preferences);
}

class IncrementPreferenceDay extends PreferenceEvent {
  final DateTime day;

  IncrementPreferenceDay(this.day);
}

class IncrementPreferenceWeekday extends PreferenceEvent {
  final int weekday;
  final DateTime fromDate;

  IncrementPreferenceWeekday(this.weekday, this.fromDate);
}

class PreferenceStateUpdated extends PreferenceEvent {
  final PreferenceLoaded state;

  PreferenceStateUpdated(this.state);
}

abstract class PreferenceState {
  PreferenceState();
}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceLoaded extends PreferenceState {
  final Map<DateTime, CalendarDayModel> _dayPrefs =
      HashMap(equals: (a, b) => a.isSameDay(b), hashCode: (d) => d.hashCode);
  final Map<int, CalendarWeekModel> _weekPrefs =
      HashMap(equals: (a, b) => a == b, hashCode: (d) => d.hashCode);

  final UserModel userModel;
  final List<VacationModel> vacationRequests;
  final List<TourModel> tours;

  PreferenceLoaded(List<PreferenceItemModel> preferences, this.userModel,
      this.vacationRequests, this.tours) {
    final Map<DateTime, List<PreferenceItemModel>> prefsDayCache =
        HashMap(equals: (a, b) => a.isSameDay(b), hashCode: (d) => d.hashCode);
    final Map<DateTime, List<TourModel>> toursCache =
        HashMap(equals: (a, b) => a.isSameDay(b), hashCode: (d) => d.hashCode);
    final Map<int, List<PreferenceItemModel>> prefsWeekCache =
        HashMap(equals: (a, b) => a == b, hashCode: (d) => d.hashCode);

    for (var p in preferences) {
      if (p.startDate.isSameDay(p.endDate)) {
        if (prefsDayCache[p.startDate.ymd] == null) {
          prefsDayCache[p.startDate.ymd] = [p];
        } else {
          prefsDayCache[p.startDate.ymd]!.add(p);
        }
      } else {
        if (prefsWeekCache[p.dayOfWeek] == null) {
          prefsWeekCache[p.dayOfWeek] = [p];
        } else {
          prefsWeekCache[p.dayOfWeek]!.add(p);
        }
      }
    }

    for (var t in tours) {
      if (toursCache[t.tourDate.ymd] == null) {
        toursCache[t.tourDate.ymd] = [t];
      } else {
        toursCache[t.tourDate.ymd]!.add(t);
      }
      prefsDayCache[t.tourDate.ymd] ??= [];
    }

    for (var v in vacationRequests) {
      final count = v.toDate.ymd.difference(v.fromDate.ymd).inDays + 1;
      for (var i = 0; i < count; i++) {
        prefsDayCache[v.fromDate.add(Duration(days: i)).ymd] ??= [];
      }
    }

    for (var w = 1; w < 8; w++) {
      _weekPrefs[w] =
          CalendarWeekModel(weekday: w, weekPrefs: prefsWeekCache[w] ?? []);
    }

    for (var d in prefsDayCache.keys) {
      _dayPrefs[d] = CalendarDayModel(
          day: d,
          dayPrefs: prefsDayCache[d]!,
          weekPrefs: _weekPrefs[d.weekday]!,
          tours: toursCache[d] ?? [],
          vacationRequest: vacationRequests
              .where((e) =>
                  e.fromDate.ymd.isSameDayOrBefore(d) &&
                  e.toDate.ymd.isSameDayOrAfter(d))
              .firstOrNull);
    }
  }

  List<PreferenceItemModel> get preferences {
    final Set<PreferenceItemModel> p = {};
    for (CalendarWeekModel w in _weekPrefs.values) {
      p.addAll(w.weekPrefs);
    }
    for (CalendarDayModel d in _dayPrefs.values) {
      p.addAll(d.dayPrefs);
    }
    return p.toList(growable: false);
  }

  CalendarDayModel getDayPref(DateTime day) =>
      _dayPrefs[day.ymd] ??= CalendarDayModel(
          day: day.ymd,
          dayPrefs: [],
          weekPrefs: _weekPrefs[day.weekday]!,
          tours: [],
          vacationRequest: null);

  CalendarWeekModel getWeekPref(int weekday) => _weekPrefs[weekday]!;
}

class PreferenceError extends PreferenceState {
  final Object error;
  final StackTrace stack;

  PreferenceError(this.error, this.stack);
}
