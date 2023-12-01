import 'dart:convert';

import 'package:faircare/features/performance/measurable.model.dart';

class VisitModel extends Measurable {
  final int id;
  final int tourId;
  final int type;
  final int patientId;

  final String? desiredStartFrom;
  final String? desiredStartTo;

  VisitModel({
    required this.id,
    required this.tourId,
    required this.type,
    required this.patientId,
    required super.tourDate,
    required super.plannedStartTime,
    required super.plannedEndTime,
    this.desiredStartFrom,
    this.desiredStartTo,
    required super.actualStartTime,
    required super.actualEndTime,
    required super.plannedCareDuration,
    required super.plannedCommuteDuration,
    required super.actualCareDuration,
    required super.actualCommuteDuration,
    required super.plannedCommuteDistance,
    required super.plannedRevenue,
    required super.maxBonus,
    required super.plannedAdminDuration,
    required super.actualAdminDuration,
    required super.plannedBreakDuration,
    required super.actualBreakDuration,
    required super.rating,
    required super.plannedTaskCount,
    required super.actualTaskCount,
    required super.isClosed,
    required super.actualBonus,
    required super.hasInfectiousDisease,
    required super.hasMedicalCare,
    required super.hasBasicCare,
    required super.hasWoundCare,
    required super.hasHousekeeping,
    required super.hasCompanionship,
    required super.actualRevenue,
  });

  factory VisitModel.fromRawJson(String str) =>
      VisitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
        id: json["id"],
        tourId: json["tourId"],
        type: json["type"],
        patientId: json["patientId"],
        tourDate: DateTime.parse(json["tourDate"]),
        plannedStartTime: json["plannedStartTime"],
        plannedEndTime: json["plannedEndTime"],
        desiredStartFrom: json["desiredStartFrom"],
        desiredStartTo: json["desiredStartTo"],
        actualStartTime: json["actualStartTime"],
        actualEndTime: json["actualEndTime"],
        plannedCareDuration: json["plannedCareDuration"],
        plannedCommuteDuration: json["plannedCommuteDuration"],
        actualCareDuration: json["actualCareDuration"],
        actualCommuteDuration: json["actualCommuteDuration"],
        plannedCommuteDistance: json["plannedCommuteDistance"],
        plannedRevenue: json["plannedRevenue"],
        maxBonus: json["maxBonus"],
        plannedAdminDuration: json["plannedAdminDuration"],
        actualAdminDuration: json["actualAdminDuration"],
        actualBreakDuration: json["actualBreakDuration"],
        rating: json["rating"]?.toDouble(),
        plannedTaskCount: json["plannedTaskCount"],
        actualTaskCount: json["actualTaskCount"],
        isClosed: json["isClosed"],
        actualBonus: json["actualBonus"],
        plannedBreakDuration: json["plannedBreakDuration"],
        hasInfectiousDisease: json["hasInfectiousDisease"],
        hasMedicalCare: json["hasMedicalCare"],
        hasBasicCare: json["hasBasicCare"],
        hasWoundCare: json["hasWoundCare"],
        hasHousekeeping: json["hasHousekeeping"],
        hasCompanionship: json["hasCompanionship"],
        actualRevenue: json["actualRevenue"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tourId": tourId,
        "type": type,
        "patientId": patientId,
        "tourDate": tourDate.toIso8601String(),
        "plannedStartTime": plannedStartTime,
        "plannedEndTime": plannedEndTime,
        "desiredStartFrom": desiredStartFrom,
        "desiredStartTo": desiredStartTo,
        "actualStartTime": actualStartTime,
        "actualEndTime": actualEndTime,
        "plannedCareDuration": plannedCareDuration,
        "plannedCommuteDuration": plannedCommuteDuration,
        "actualCareDuration": actualCareDuration,
        "actualCommuteDuration": actualCommuteDuration,
        "plannedCommuteDistance": plannedCommuteDistance,
        "plannedRevenue": plannedRevenue,
        "maxBonus": maxBonus,
        "plannedAdminDuration": plannedAdminDuration,
        "actualAdminDuration": actualAdminDuration,
        "actualBreakDuration": actualBreakDuration,
        "rating": rating,
        "plannedTaskCount": plannedTaskCount,
        "actualTaskCount": actualTaskCount,
        "isClosed": isClosed,
        "actualBonus": actualBonus,
        "plannedBreakDuration": plannedBreakDuration,
        "hasInfectiousDisease": hasInfectiousDisease,
        "hasMedicalCare": hasMedicalCare,
        "hasBasicCare": hasBasicCare,
        "hasWoundCare": hasWoundCare,
        "hasHousekeeping": hasHousekeeping,
        "hasCompanionship": hasCompanionship,
        "actualRevenue": actualRevenue,
      };
}
