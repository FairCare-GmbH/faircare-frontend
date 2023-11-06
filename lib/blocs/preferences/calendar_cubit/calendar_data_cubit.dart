import 'package:bloc/bloc.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar_cubit.dart';

class PrefsCalendarDaysCubit extends Cubit<List<CalendarModel>> {
  PrefsCalendarDaysCubit() : super([]);

  void setInitialData(List<CalendarModel> data) {
    emit(data);
  }


}
