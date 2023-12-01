import '../../api/api.dart';

abstract class Measurable {
  final DateTime tourDate;

  final bool hasInfectiousDisease;
  final bool hasMedicalCare;
  final bool hasBasicCare;
  final bool hasWoundCare;
  final bool hasHousekeeping;
  final bool hasCompanionship;
  final int? maxBonus;
  final int? actualBonus;
  final int plannedRevenue;

  final String plannedStartTime;
  final String plannedEndTime;
  final String? actualStartTime;
  final String? actualEndTime;

  final int plannedCareDuration;
  final int? actualCareDuration;

  final int plannedCommuteDuration;
  final int? actualCommuteDuration;

  final int plannedAdminDuration;
  final int? actualAdminDuration;

  final int plannedBreakDuration;
  final int? actualBreakDuration;

  final int plannedCommuteDistance;
  final double? rating;
  final int plannedTaskCount;
  final int? actualTaskCount;
  final bool isClosed;

  Measurable({
    required this.tourDate,
    required this.plannedStartTime,
    required this.plannedEndTime,
    required this.actualStartTime,
    required this.actualEndTime,
    required this.plannedCareDuration,
    required this.actualCareDuration,
    required this.plannedCommuteDuration,
    required this.actualCommuteDuration,
    required this.plannedAdminDuration,
    required this.actualAdminDuration,
    required this.plannedBreakDuration,
    required this.actualBreakDuration,
    required this.plannedCommuteDistance,
    required this.plannedRevenue,
    required this.maxBonus,
    required this.actualBonus,
    required this.rating,
    required this.plannedTaskCount,
    required this.actualTaskCount,
    required this.isClosed,
    required this.hasInfectiousDisease,
    required this.hasMedicalCare,
    required this.hasBasicCare,
    required this.hasWoundCare,
    required this.hasHousekeeping,
    required this.hasCompanionship,
  });

  int get plannedTotalDurationMinutes =>
      plannedAdminDuration +
      plannedCareDuration +
      plannedCommuteDuration +
      plannedBreakDuration;

  int? get actualTotalDurationMinutes => !isClosed
      ? null
      : ((actualAdminDuration ?? 0) +
              (actualCareDuration ?? 0) +
              (actualCommuteDuration ?? 0) +
              (actualBreakDuration ?? 0)) ~/
          60;

  int get plannedWorkDurationMinutes =>
      (plannedAdminDuration + plannedCareDuration + plannedCommuteDuration) ~/
      60;

  int? get actualWorkDurationMinutes => !isClosed
      ? null
      : ((actualAdminDuration ?? 0) +
              (actualCareDuration ?? 0) +
              (actualCommuteDuration ?? 0)) ~/
          60;

  int get plannedHourlyWageCents => Api.getUser()!.hourlyWage;

  int? get actualHourlyWageCents => actualWorkDurationMinutes == null
      ? null
      : (Api.getUser()!.hourlyWage +
          (actualBonus ?? 0) ~/ (actualWorkDurationMinutes! / 60));

  int? get myActualWageCents => actualWorkDurationMinutes == null
      ? null
      : (Api.getUser()!.hourlyWage * (actualWorkDurationMinutes! / 60) +
              (actualBonus ?? 0))
          .round();

  int get myPlannedWageCents =>
      (Api.getUser()!.hourlyWage * (plannedWorkDurationMinutes / 60)).round();

  double? get myActualCompletionPercentage =>
      actualTaskCount == null ? null : actualTaskCount! / plannedTaskCount;
}
