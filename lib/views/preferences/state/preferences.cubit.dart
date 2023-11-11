import 'package:bloc/bloc.dart';
import 'package:faircare/models/preferences_model.dart';

import '../../../global/constants.dart';

class PreferencesCubit extends Cubit<PreferencesModel> {
  PreferencesCubit() : super(PreferencesModel());

  void setAvailability(bool value) {
    emit(state.copyWith(openForPatients: value));
  }

  void setDistance(int value) {
    emit(state.copyWith(maximumCareRadius: value));
  }

  void setHoursType(String value) {
    int min = 0;
    int max = 0;
    if (value == hoursTypes[0]) {
      min = 1;
      max = 5;
    } else if (value == hoursTypes[1]) {
      min = 6;
      max = 34;
    } else if (value == hoursTypes[2]) {
      min = 35;
      max = 50;
    } else {
      throw Exception('invalid state');
    }
    emit(state.copyWith(
        hoursType: value, weeklyHourMaximum: max, weeklyHourMinimum: min));
  }

  void setMinimumRate(int value) {
    emit(state.copyWith(weeklyHourMinimum: value));
  }

  void setMaximumRate(int value) {
    emit(state.copyWith(weeklyHourMaximum: value));
  }

  void setRate(int min, int max) {
    emit(state.copyWith(weeklyHourMaximum: max, weeklyHourMinimum: min));
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

  void setCompanionship(bool value) {
    emit(state.copyWith(allowCompanionship: value));
  }
}
