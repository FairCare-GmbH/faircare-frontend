import 'package:bloc/bloc.dart';
import 'package:faircare/models/preferences_model.dart';

class PreferencesCubit extends Cubit<PreferencesModel> {
  PreferencesCubit() : super(PreferencesModel());

  void setAvailability(bool value) {
    emit(state.copyWith(openForPatients: value));
  }

  void setDistance(int value) {
    emit(state.copyWith(maximumCareRadius: value));
  }

  void setHoursType(String value) {
    emit(state.copyWith(hoursType: value));
  }

  void setMinimumRate(int value) {
    emit(state.copyWith(weeklyHourMinimum: value));
  }

  void setMaximumRate(int value) {
    emit(state.copyWith(weeklyHourMaximum: value));
  }

  void setBasicCare(bool value) {
    emit(state.copyWith(allowBasicCare: value));
  }

  void setHousekeeping(bool value) {
    emit(state.copyWith(allowHousekeeping: value));
  }

  void setInfectiousDisease(bool value) {
    emit(state.copyWith(allowInfectiousDisease: value));
  }

  void setMedicalCare(bool value) {
    emit(state.copyWith(allowMedicalCare: value));
  }

  void setWoundCare(bool value) {
    emit(state.copyWith(allowWoundCare: value));
  }
}
