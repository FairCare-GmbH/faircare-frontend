import 'package:bloc/bloc.dart';
import 'package:faircare/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterModel> {
  RegisterCubit() : super(RegisterModel());

  void setQualification(String value) {
    emit(state.copyWith(qualification: value));
  }

  void setDriversLicense(bool value) {
    emit(state.copyWith(hasDriversLicense: value));
  }
}
