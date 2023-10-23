import 'package:bloc/bloc.dart';
import 'package:faircare/models/register_model.dart';

class RegisterCubit extends Cubit<RegisterModel> {
  RegisterCubit() : super(RegisterModel());

  void setQualification(String value) {
    emit(state.copyWith(qualification: value));
  }

  void setDriversLicense(bool value) {
    emit(state.copyWith(hasDriversLicense: value));
  }

  void setDistance(int value) {
    emit(state.copyWith(maximumCareRadius: value));
  }

  void setMarketingSource(String value) {
    emit(state.copyWith(marketingSource: value));
  }

  void setTermsAgreement(bool value) {
    emit(state.copyWith(termsAgreed: value));
  }

  void setDataProtectionAgreement(bool value) {
    emit(state.copyWith(dataProtectionAgreed: value));
  }

  void setAvailability(DateTime value) {
    emit(state.copyWith(availableFrom: value));
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
}
