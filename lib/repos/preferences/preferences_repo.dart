import 'dart:math';

import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/models/vacation_model.dart';

class PreferencesRepo {
  void setPreferences() async {}

  Future<List<CalendarModel>> getCalendarData() async {
    const days = 120;

    return [
      ...List.generate(
        days,
        (i) {
          int dayOfWeek = (i + 1) % 7;
          if (dayOfWeek == 0) dayOfWeek = 7;

          // 0 = U, 1 = F, 2 = S, 3 = FS, 4 = FREE
          int tourType = Random().nextInt(5);
          bool tourAssigned = Random().nextBool();
          if (tourType == 4) tourAssigned = false;

          return CalendarModel(
            id: i,
            nurseId: i,
            fromDate: DateTime(2023, 10, i + 1),
            toDate: DateTime(2023, 10, i + 1),
            dayOfWeek: dayOfWeek,
            tourType: tourType,
            hasAssignedTour: tourAssigned,
          );
        },
      ),
    ];
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
