import 'package:faircare/models/calendar_model.dart';
import 'package:faircare/models/vacation_model.dart';

class PreferencesRepo {
  void setPreferences() async {}

  Future<List<CalendarModel>> getCalendarData() async {
    // TOUR TYPE - 0 = U, 1 = F, 2 = S, 3 = FS, 4 = FREE

    List<CalendarModel> data = dataFromApi();
    List<CalendarModel> finalData = [];

    for (final item in data) {
      if (item.fromDate == item.toDate) {
        finalData.add(item);
      } else {
        final fromDate = item.fromDate;
        final daysDifference = item.toDate.difference(item.fromDate).inDays;

        for (int i = 0; i <= daysDifference; i += 7) {
          final newDate = DateTime(
            fromDate.year,
            fromDate.month,
            fromDate.day + i,
          );

          finalData.add(
            item.copyWith(fromDate: newDate, toDate: newDate),
          );
        }
      }
    }

    return finalData;
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

List<CalendarModel> dataFromApi() => [
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
