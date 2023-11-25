import 'dart:convert';

import '../../api/api.dart';


class TourVisitModel {
  final int id;
  final int tourId;
  final int type;
  final int patientId;
  final DateTime tourDate;
  final String plannedStartTime;
  final String plannedEndTime;
  final String? desiredStartFrom;
  final String? desiredStartTo;
  final String? actualStartTime;
  final String? actualEndTime;
  final int plannedCareDuration;
  final int plannedCommuteDuration;
  final int? actualCareDuration;
  final int? actualCommuteDuration;
  final int plannedCommuteDistance;
  final int? actualCommuteDistance;
  final int revenue;
  final int bonus;

  TourVisitModel({
    required this.id,
    required this.tourId,
    required this.type,
    required this.patientId,
    required this.tourDate,
    required this.plannedStartTime,
    required this.plannedEndTime,
    required this.desiredStartFrom,
    required this.desiredStartTo,
    required this.actualStartTime,
    required this.actualEndTime,
    required this.plannedCareDuration,
    required this.plannedCommuteDuration,
    required this.actualCareDuration,
    required this.actualCommuteDuration,
    required this.plannedCommuteDistance,
    required this.actualCommuteDistance,
    required this.revenue,
    required this.bonus,
  });

  TourVisitModel copyWith({
    int? id,
    int? tourId,
    int? type,
    int? patientId,
    DateTime? tourDate,
    String? plannedStartTime,
    String? plannedEndTime,
    String? desiredStartFrom,
    String? desiredStartTo,
    String? actualStartTime,
    String? actualEndTime,
    int? plannedCareDuration,
    int? plannedCommuteDuration,
    int? actualCareDuration,
    int? actualCommuteDuration,
    int? plannedCommuteDistance,
    int? actualCommuteDistance,
    int? revenue,
    int? bonus,
  }) =>
      TourVisitModel(
        id: id ?? this.id,
        tourId: tourId ?? this.tourId,
        type: type ?? this.type,
        patientId: patientId ?? this.patientId,
        tourDate: tourDate ?? this.tourDate,
        plannedStartTime: plannedStartTime ?? this.plannedStartTime,
        plannedEndTime: plannedEndTime ?? this.plannedEndTime,
        desiredStartFrom: desiredStartFrom ?? this.desiredStartFrom,
        desiredStartTo: desiredStartTo ?? this.desiredStartTo,
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
        revenue: revenue ?? this.revenue,
        bonus: bonus ?? this.bonus,
      );

  factory TourVisitModel.fromRawJson(String str) =>
      TourVisitModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourVisitModel.fromJson(Map<String, dynamic> json) => TourVisitModel(
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
        actualCommuteDistance: json["actualCommuteDistance"],
        revenue: json["revenue"],
        bonus: json["bonus"],
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
        "actualCommuteDistance": actualCommuteDistance,
        "revenue": revenue,
        "bonus": bonus,
      };

  int get plannedDurationMinutes =>
      plannedCareDuration + plannedCommuteDuration;

  int? get actualDurationMinutes =>
      actualCareDuration == null || actualCommuteDuration == null
          ? null
          : (actualCareDuration! + actualCommuteDuration!);

  int get plannedHourlyRevenueCents =>
      ((revenue / (plannedCareDuration + plannedCommuteDuration)) * 3600)
          .round();

  int? get actualHourlyRevenueCents =>
      actualCareDuration == null || actualCommuteDuration == null
          ? null
          : ((revenue / (actualCareDuration! + actualCommuteDuration!)) * 3600)
              .round();

  int get myPlannedWageCents => (Api.getUser()!.hourlyWage *
          ((plannedCareDuration + plannedCommuteDuration) / 3600))
      .round();

  int? get myActualWageCents =>
      actualCareDuration == null || actualCommuteDuration == null
          ? null
          : (Api.getUser()!.hourlyWage *
                  ((actualCareDuration! + actualCommuteDuration!) / 3600))
              .round();
}
