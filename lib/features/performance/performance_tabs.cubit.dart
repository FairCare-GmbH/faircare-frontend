import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:faircare/features/preferences/care_preferences.model.dart';

import '../../../global/constants.dart';

class PerformanceTabsCubit extends Cubit<String> {
  PerformanceTabsCubit(String initialState) : super(initialState);

  void setSelectedIndex(String value) {
    emit(value);
  }
}
