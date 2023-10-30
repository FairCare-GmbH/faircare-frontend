import 'package:dio/dio.dart';
import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/models/vacation_model.dart';

import '../../api/api.dart';

class PreferencesRepo {
  void setPreferences() async {

  }

  Future<List<CalendarModel>> getCalendarData() async {
    return (await Api.request<List>('/preferences/${Api.getUser()!.id}', options: Options(method: 'GET')))
        .map((e) => CalendarModel.fromJson(e))
        .toList(growable: false);
  }

  Future<List<VacationModel>> getVacationRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      VacationModel(
        fromDate: DateTime(2023, 9, 9),
        toDate: DateTime(2023, 9, 9),
        approvalStatus: 1,
      ),
      VacationModel(
        fromDate: DateTime(2023, 10, 27),
        toDate: DateTime(2023, 10, 27),
        approvalStatus: 1,
      ),
      VacationModel(
        fromDate: DateTime(2023, 10, 8),
        toDate: DateTime(2023, 10, 15),
        approvalStatus: 0,
      ),
      VacationModel(
        fromDate: DateTime(2023, 10, 21),
        toDate: DateTime(2023, 10, 25),
        approvalStatus: 0,
      ),
    ];
  }
}
