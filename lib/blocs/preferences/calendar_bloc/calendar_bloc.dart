import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/repos/preferences/preferences_repo.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class PrefsCalendarBloc extends Bloc<PrefsCalendarEvent, PrefsCalendarState> {
  PrefsCalendarBloc() : super(PrefsCalendarInitial()) {
    on<GetCalendarData>(
      (event, emit) async {
        try {
          emit(PrefsCalendarLoading());
          final data = await PreferencesRepo().getCalendarData();
          emit(PrefsCalendarLoaded(data));
        } catch (e) {
          emit(PrefsCalendarError(e.toString()));
        }
      },
    );
  }
}
