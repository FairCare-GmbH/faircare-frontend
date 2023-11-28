import 'dart:convert';

import 'package:faircare/api/api.dart';
import 'package:faircare/global/extensions.dart';

class TourModel {
  final int id;
  final int ownerNurseId;
  final DateTime tourDate;
  final bool hasInfectiousDisease;
  final bool hasMedicalCare;
  final bool hasBasicCare;
  final bool hasWoundCare;
  final bool hasHousekeeping;
  final bool hasCompanionship;
  final int bonus;
  final int dayOfWeek;
  final int type;
  final double centerLongitude;
  final double centerLatitude;
  final int revenue;
  final bool isOpen;
  final String plannedStartTime;
  final String plannedEndTime;
  final String? actualStartTime;
  final String? actualEndTime;
  final int plannedCareDuration;
  final int plannedCommuteDuration;
  final int? actualCareDuration;
  final int? actualCommuteDuration;
  final int plannedCommuteDistance;
  final int? actualCommuteDistance;
  final int plannedCommuteRadius;
  final double? rating;
  final int taskCount;
  final int? taskCompleteCount;

  TourModel({
    required this.id,
    required this.ownerNurseId,
    required this.hasInfectiousDisease,
    required this.hasMedicalCare,
    required this.hasBasicCare,
    required this.hasWoundCare,
    required this.hasHousekeeping,
    required this.hasCompanionship,
    required this.bonus,
    required this.dayOfWeek,
    required this.type,
    required this.centerLongitude,
    required this.centerLatitude,
    required this.revenue,
    required this.isOpen,
    required this.tourDate,
    required this.plannedStartTime,
    required this.plannedEndTime,
    this.actualStartTime,
    this.actualEndTime,
    required this.plannedCareDuration,
    required this.plannedCommuteDuration,
    this.actualCareDuration,
    this.actualCommuteDuration,
    required this.plannedCommuteDistance,
    this.actualCommuteDistance,
    required this.plannedCommuteRadius,
    this.rating,
    required this.taskCount,
    this.taskCompleteCount,
  });

  TourModel copyWith({
    int? id,
    int? ownerNurseId,
    bool? isOpen,
    DateTime? tourDate,
    int? dayOfWeek,
    String? plannedStartTime,
    String? plannedEndTime,
    String? actualStartTime,
    String? actualEndTime,
    int? plannedCareDuration,
    int? plannedCommuteDuration,
    int? actualCareDuration,
    int? actualCommuteDuration,
    int? plannedCommuteDistance,
    int? actualCommuteDistance,
    double? centerLongitude,
    double? centerLatitude,
    int? plannedCommuteRadius,
    int? revenue,
    int? bonus,
    bool? hasInfectiousDisease,
    bool? hasMedicalCare,
    bool? hasBasicCare,
    bool? hasWoundCare,
    bool? hasHousekeeping,
    bool? hasCompanionship,
    int? type,
    double? rating,
    int? taskCount,
    int? taskCompleteCount,
  }) =>
      TourModel(
        id: id ?? this.id,
        ownerNurseId: ownerNurseId ?? this.ownerNurseId,
        isOpen: isOpen ?? this.isOpen,
        tourDate: tourDate ?? this.tourDate,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        plannedStartTime: plannedStartTime ?? this.plannedStartTime,
        plannedEndTime: plannedEndTime ?? this.plannedEndTime,
        actualStartTime: actualStartTime ?? this.actualStartTime,
        actualEndTime: actualEndTime ?? this.actualEndTime,
        plannedCareDuration: plannedCareDuration ?? this.plannedCareDuration,
        plannedCommuteDuration:
            plannedCommuteDuration ?? this.plannedCommuteDuration,
        actualCareDuration: actualCareDuration ?? this.actualCareDuration,
        actualCommuteDuration:
            actualCommuteDuration ?? this.actualCommuteDuration,
        plannedCommuteDistance:
            plannedCommuteDistance ?? this.plannedCommuteDistance,
        actualCommuteDistance:
            actualCommuteDistance ?? this.actualCommuteDistance,
        centerLongitude: centerLongitude ?? this.centerLongitude,
        centerLatitude: centerLatitude ?? this.centerLatitude,
        plannedCommuteRadius: plannedCommuteRadius ?? this.plannedCommuteRadius,
        revenue: revenue ?? this.revenue,
        bonus: bonus ?? this.bonus,
        hasInfectiousDisease: hasInfectiousDisease ?? this.hasInfectiousDisease,
        hasMedicalCare: hasMedicalCare ?? this.hasMedicalCare,
        hasBasicCare: hasBasicCare ?? this.hasBasicCare,
        hasWoundCare: hasWoundCare ?? this.hasWoundCare,
        hasHousekeeping: hasHousekeeping ?? this.hasHousekeeping,
        hasCompanionship: hasCompanionship ?? this.hasCompanionship,
        type: type ?? this.type,
        rating: rating ?? this.rating,
        taskCount: taskCount ?? this.taskCount,
        taskCompleteCount: taskCompleteCount ?? this.taskCompleteCount,
      );

  factory TourModel.fromRawJson(String str) =>
      TourModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourModel.fromJson(Map<String, dynamic> json) => TourModel(
        id: json["id"],
        ownerNurseId: json["ownerNurseId"],
        isOpen: json["isOpen"],
        tourDate: DateTime.parse(json["tourDate"]),
        dayOfWeek: json["dayOfWeek"],
        plannedStartTime: json["plannedStartTime"],
        plannedEndTime: json["plannedEndTime"],
        actualStartTime: json["actualStartTime"],
        actualEndTime: json["actualEndTime"],
        plannedCareDuration: json["plannedCareDuration"],
        plannedCommuteDuration: json["plannedCommuteDuration"],
        actualCareDuration: json["actualCareDuration"],
        actualCommuteDuration: json["actualCommuteDuration"],
        plannedCommuteDistance: json["plannedCommuteDistance"],
        actualCommuteDistance: json["actualCommuteDistance"],
        centerLongitude: json["centerLongitude"],
        centerLatitude: json["centerLatitude"],
        plannedCommuteRadius: json["plannedCommuteRadius"],
        revenue: json["revenue"],
        bonus: json["bonus"],
        hasInfectiousDisease: json["hasInfectiousDisease"],
        hasMedicalCare: json["hasMedicalCare"],
        hasBasicCare: json["hasBasicCare"],
        hasWoundCare: json["hasWoundCare"],
        hasHousekeeping: json["hasHousekeeping"],
        hasCompanionship: json["hasCompanionship"],
        type: json["type"],
        rating: json["rating"],
        taskCount: json["taskCount"],
        taskCompleteCount: json["taskCompleteCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ownerNurseId": ownerNurseId,
        "isOpen": isOpen,
        "tourDate": tourDate.toIso8601String(),
        "dayOfWeek": dayOfWeek,
        "plannedStartTime": plannedStartTime,
        "plannedEndTime": plannedEndTime,
        "actualStartTime": actualStartTime,
        "actualEndTime": actualEndTime,
        "plannedCareDuration": plannedCareDuration,
        "plannedCommuteDuration": plannedCommuteDuration,
        "actualCareDuration": actualCareDuration,
        "actualCommuteDuration": actualCommuteDuration,
        "plannedCommuteDistance": plannedCommuteDistance,
        "actualCommuteDistance": actualCommuteDistance,
        "centerLongitude": centerLongitude,
        "centerLatitude": centerLatitude,
        "plannedCommuteRadius": plannedCommuteRadius,
        "revenue": revenue,
        "bonus": bonus,
        "hasInfectiousDisease": hasInfectiousDisease,
        "hasMedicalCare": hasMedicalCare,
        "hasBasicCare": hasBasicCare,
        "hasWoundCare": hasWoundCare,
        "hasHousekeeping": hasHousekeeping,
        "hasCompanionship": hasCompanionship,
        "type": type,
        "rating": rating,
        "taskCount": taskCount,
        "taskCompleteCount": taskCompleteCount,
      };

  int get plannedDurationMinutes =>
      ((plannedEndTime.time.hour * 60 + plannedEndTime.time.minute) -
              (plannedStartTime.time.hour * 60 + plannedStartTime.time.minute))
          .toInt();

  int? get actualDurationMinutes => actualEndTime == null ||
          actualStartTime == null
      ? null
      : ((actualEndTime!.time.hour * 60 + actualEndTime!.time.minute) -
              (actualStartTime!.time.hour * 60 + actualStartTime!.time.minute))
          .toInt();

  int get plannedHourlyWageCents => Api.getUser()!.hourlyWage;

  int? get actualHourlyWageCents => actualDurationMinutes == null
      ? null
      : (Api.getUser()!.hourlyWage + bonus / (actualDurationMinutes! / 60))
          .round();

  int get myPlannedWageCents =>
      (Api.getUser()!.hourlyWage * (plannedDurationMinutes / 60)).round();

  int? get myActualWageCents => actualDurationMinutes == null
      ? null
      : (Api.getUser()!.hourlyWage * (actualDurationMinutes! / 60)).round();

  double? get myActualCompletionPercentage =>
      taskCompleteCount == null ? null : taskCompleteCount! / taskCount;
}
