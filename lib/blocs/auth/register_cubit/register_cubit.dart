import 'package:bloc/bloc.dart';
import 'package:faircare/models/register_model.dart';

class RegisterCubit extends Cubit<RegisterModel> {
  RegisterCubit() : super(RegisterModel());

  void setName(String value) {
    final List<String> namesArray = value.trim().split(' ');
    String fNames = namesArray[0];
    String lNames = '';
    if(namesArray.length == 2){
      lNames = namesArray[1];
    }else if(namesArray.length > 2){
      fNames += ' ${namesArray[1]}';
      for(int i = 2;i < namesArray.length;i++){
        lNames += ' ${namesArray[2]}';
      }
      lNames = lNames.trim();
    }
    emit(state.copyWith(firstName: fNames, lastName: lNames));
  }

  void setAddress(String value) {
    emit(state.copyWith(address: value));
  }

  void setPhone(String value) {
    emit(state.copyWith(phone: value));
  }

  void setEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

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
