import 'dart:math';

import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/models/vacation_model.dart';

class PreferencesRepo {
  void setPreferences() async {}

  Future<List<CalendarModel>> getCalendarData() async {
    // TOUR TYPE - 0 = U, 1 = F, 2 = S, 3 = FS, 4 = FREE

    const days = 120;

    var data = list;
    for (int i = 0; i < 120; i++) {
      final now = DateTime.now();
      final currentMonth = DateTime(now.year, now.month);
    }

    return [
      ...List.generate(
        days,
        (i) {
          int dayOfWeek = (i + 1) % 7;
          if (dayOfWeek == 0) dayOfWeek = 7;

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

final list = [
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 1),
    toDate: DateTime(2023, 10, 29),
    dayOfWeek: 1,
    tourType: 1,
    hasAssignedTour: true,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 6),
    toDate: DateTime(2023, 10, 27),
    dayOfWeek: 6,
    tourType: 2,
    hasAssignedTour: false,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 7),
    toDate: DateTime(2023, 10, 7),
    dayOfWeek: 7,
    tourType: 2,
    hasAssignedTour: false,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 10),
    toDate: DateTime(2023, 10, 10),
    dayOfWeek: 3,
    tourType: 3,
    hasAssignedTour: false,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 14),
    toDate: DateTime(2023, 10, 14),
    dayOfWeek: 7,
    tourType: 2,
    hasAssignedTour: false,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 24),
    toDate: DateTime(2023, 10, 24),
    dayOfWeek: 3,
    tourType: 1,
    hasAssignedTour: false,
  ),
  CalendarModel(
    id: 0,
    nurseId: 0,
    fromDate: DateTime(2023, 10, 26),
    toDate: DateTime(2023, 10, 26),
    dayOfWeek: 5,
    tourType: 1,
    hasAssignedTour: false,
  ),
];
