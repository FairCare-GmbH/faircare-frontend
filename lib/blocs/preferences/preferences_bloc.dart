import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/api/api.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/preferences_model.dart';
import 'package:faircare/models/user_model.dart';

import '../../models/calendar_model.dart';

class PreferencesBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferencesBloc() : super(PreferenceInitial()) {
    on<GetPreferenceData>((event, emit) async {
      try {
        emit(PreferenceLoading());
        final data = (await Api.request<Map<String, dynamic>>(
            '/preferences/${Api.getUser()!.id}',
            options: Options(method: 'GET')));
        emit(PreferenceLoaded(
            (data['preferences'] as List)
                .map((e) => CalendarModel.fromJson(e))
                .toList(growable: false),
            UserModel.fromJson(data['nurse'])));
      } catch (error, stack) {
        emit(PreferenceError(error, stack));
      }
    });

    on<UpdatePreferenceData>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(event.preferences, event.userModel));
      }
    });

    on<UpdatePreferenceUser>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(
            (state as PreferenceLoaded).preferences, event.userModel));
      }
    });

    on<UpdatePreferenceList>((event, emit) async {
      if (state is PreferenceLoaded) {
        emit(PreferenceLoaded(
            event.preferences, (state as PreferenceLoaded).userModel));
      }
    });

    on<IncrementPreferenceDay>((event, emit) async {
      if (state is PreferenceLoaded) {
        if (event.day.isBefore(DateTime.now())) return;
        final List<CalendarModel> models =
            (state as PreferenceLoaded).getDayData(event.day);
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

        List<CalendarModel> updatedData = (state as PreferenceLoaded)
            .preferences
            .where((e) => !PreferenceLoaded._isDayMatch(e, event.day))
            .toList();

        if (vacationModel != null) updatedData.add(vacationModel);
        if (weekModel != null) updatedData.add(weekModel);
        if (newType != null) {
          updatedData.add(dayModel != null
              ? dayModel.copyWith(tourType: newType)
              : CalendarModel(
                  fromDate: event.day.ymd,
                  toDate: event.day.ymd,
                  dayOfWeek: event.day.weekday,
                  tourType: newType,
                  assignedTourType: null,
                  assignedTourIds: null));
        }

        emit(PreferenceLoaded(
            updatedData, (state as PreferenceLoaded).userModel));
      }
    });

    on<IncrementPreferenceWeekday>((event, emit) async {
      if (state is PreferenceLoaded) {
        final List<CalendarModel> models = (state as PreferenceLoaded)
            .preferences
            .where((e) => e.dayOfWeek == event.weekday)
            .toList(growable: false);
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

        List<CalendarModel> updatedData = (state as PreferenceLoaded)
            .preferences
            .where((e) => e.dayOfWeek != event.weekday)
            .toList();

        if (vacationModel != null) updatedData.add(vacationModel);
        if (newType != null) {
          updatedData.add(weekModel != null
              ? weekModel.copyWith(
                  tourType: newType,
                  fromDate: DateTime.now().ymd,
                  toDate: DateTime(event.fromDate.year + 50).ymd,
                )
              : CalendarModel(
                  fromDate: DateTime.now().ymd,
                  toDate: DateTime(event.fromDate.year + 50).ymd,
                  dayOfWeek: event.weekday,
                  tourType: newType,
                  assignedTourType: null,
                  assignedTourIds: null,
                ));
        }

        updatedData.addAll(dayModels
            .where((e) => e.assignedTourType != null || e.tourType != newType));

        emit(PreferenceLoaded(
            updatedData, (state as PreferenceLoaded).userModel));
      }
    });
  }
}

abstract class PreferenceEvent {
  PreferenceEvent();
}

class GetPreferenceData extends PreferenceEvent {}

class UpdatePreferenceData extends PreferenceEvent {
  final List<CalendarModel> preferences;
  final UserModel userModel;

  UpdatePreferenceData(this.preferences, this.userModel);
}

class UpdatePreferenceUser extends PreferenceEvent {
  final UserModel userModel;

  UpdatePreferenceUser(this.userModel);
}

class UpdatePreferenceList extends PreferenceEvent {
  final List<CalendarModel> preferences;

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

abstract class PreferenceState {
  PreferenceState();
}

class PreferenceInitial extends PreferenceState {}

class PreferenceLoading extends PreferenceState {}

class PreferenceLoaded extends PreferenceState {
  final List<CalendarModel> preferences;
  final UserModel userModel;

  PreferenceLoaded(this.preferences, this.userModel);

  static bool _isDayMatch(CalendarModel model, DateTime day) =>
      model.fromDate.isSameDay(day) && model.toDate.isSameDay(day) ||
      _isWeekDayMatch(model, day.weekday);

  static bool _isWeekDayMatch(CalendarModel model, int weekday) =>
      !model.fromDate.isSameDay(model.toDate) && model.dayOfWeek == weekday;

  List<CalendarModel> getDayData(DateTime day) => preferences
      .where(
        (e) => _isDayMatch(e, day),
      )
      .toList(growable: false);

  List<CalendarModel> getReducedRangeDays(
          DateTime from, DateTime to) =>
      preferences
          .where((e) =>
              _isDayMatch(e, from) ||
              e.fromDate.isAfter(from) && e.fromDate.isBefore(to))
          .toList(growable: false);

  List<CalendarModel> getExplodedRangeDays(DateTime from, DateTime to) {
    from = from.ymd;
    to = to.ymd;
    final count = to.difference(from).inDays;
    List<CalendarModel> models = [];
    for (var i = 0; i < count; i++) {
      final f = from.add(Duration(days: i));
      for (var d in getDayData(f)) {
        models.add(d.copyWith(fromDate: f, toDate: f));
      }
    }
    return models;
  }
}

class PreferenceError extends PreferenceState {
  final Object error;
  final StackTrace stack;

  PreferenceError(this.error, this.stack);
}
