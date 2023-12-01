import 'dart:convert';

import 'package:faircare/features/performance/measurable.model.dart';

class TourModel extends Measurable {
  final int id;
  final int ownerNurseId;
  final int type;
  final int dayOfWeek;
  final double centerLongitude;
  final double centerLatitude;
  final double plannedCommuteRadius;
  final String name;
  final bool isOpen;

  TourModel({
    required this.id,
    required this.ownerNurseId,
    required super.hasInfectiousDisease,
    required super.hasMedicalCare,
    required super.hasBasicCare,
    required super.hasWoundCare,
    required super.hasHousekeeping,
    required super.hasCompanionship,
    required super.maxBonus,
    required this.dayOfWeek,
    required this.type,
    required this.centerLongitude,
    required this.centerLatitude,
    required super.plannedRevenue,
    required this.isOpen,
    required super.tourDate,
    required super.plannedStartTime,
    required super.plannedEndTime,
    required super.actualStartTime,
    required super.actualEndTime,
    required super.plannedCareDuration,
    required super.plannedCommuteDuration,
    required super.actualCareDuration,
    required super.actualCommuteDuration,
    required super.plannedCommuteDistance,
    required super.rating,
    required super.plannedTaskCount,
    required super.actualTaskCount,
    required this.name,
    required super.plannedAdminDuration,
    required super.plannedBreakDuration,
    required super.actualAdminDuration,
    required super.actualBreakDuration,
    required super.isClosed,
    required super.actualBonus,
    required this.plannedCommuteRadius,
    required super.actualRevenue,
  });

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
        centerLongitude: json["centerLongitude"].toDouble(),
        centerLatitude: json["centerLatitude"].toDouble(),
        plannedRevenue: json["plannedRevenue"],
        maxBonus: json["maxBonus"],
        hasInfectiousDisease: json["hasInfectiousDisease"],
        hasMedicalCare: json["hasMedicalCare"],
        hasBasicCare: json["hasBasicCare"],
        hasWoundCare: json["hasWoundCare"],
        hasHousekeeping: json["hasHousekeeping"],
        hasCompanionship: json["hasCompanionship"],
        type: json["type"],
        rating: json["rating"]?.toDouble(),
        plannedTaskCount: json["plannedTaskCount"],
        actualTaskCount: json["actualTaskCount"],
        name: json["name"],
        plannedBreakDuration: json["plannedBreakDuration"],
        plannedAdminDuration: json["plannedAdminDuration"],
        actualBreakDuration: json["actualBreakDuration"],
        actualAdminDuration: json["actualAdminDuration"],
        isClosed: json["isClosed"],
        actualBonus: json["actualBonus"],
        plannedCommuteRadius: json["plannedCommuteRadius"].toDouble(),
        actualRevenue: json["actualRevenue"],
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
        "centerLongitude": centerLongitude,
        "centerLatitude": centerLatitude,
        "plannedRevenue": plannedRevenue,
        "maxBonus": maxBonus,
        "hasInfectiousDisease": hasInfectiousDisease,
        "hasMedicalCare": hasMedicalCare,
        "hasBasicCare": hasBasicCare,
        "hasWoundCare": hasWoundCare,
        "hasHousekeeping": hasHousekeeping,
        "hasCompanionship": hasCompanionship,
        "type": type,
        "rating": rating,
        "taskCount": plannedTaskCount,
        "taskCompleteCount": actualTaskCount,
        "name": name,
        "plannedBreakDuration": plannedBreakDuration,
        "plannedAdminDuration": plannedAdminDuration,
        "actualBreakDuration": actualBreakDuration,
        "actualAdminDuration": actualAdminDuration,
        "isClosed": isClosed,
        "actualBonus": actualBonus,
        "plannedCommuteRadius": plannedCommuteRadius,
        "actualRevenue": actualRevenue,
      };
}
