import 'package:intl/intl.dart';

class TourModel {
  final int id;
  final int ownerNurseId;
  final String fromTime;
  final String toTime;
  final bool hasInfectiousDisease;
  final bool hasMedicalCare;
  final bool hasBasicCare;
  final bool hasWoundCare;
  final bool hasHousekeeping;
  final int bonus;
  final int dayOfWeek;
  final int type;
  final double centerLongitude;
  final double centerLatitude;
  final int revenue;
  final int maximumCareRadius;
  final int careDuration;
  final int commuteDuration;
  final DateTime fromDate;
  final DateTime toDate;

  TourModel({
    required this.id,
    required this.ownerNurseId,
    required this.fromTime,
    required this.toTime,
    required this.hasInfectiousDisease,
    required this.hasMedicalCare,
    required this.hasBasicCare,
    required this.hasWoundCare,
    required this.hasHousekeeping,
    required this.bonus,
    required this.dayOfWeek,
    required this.type,
    required this.centerLongitude,
    required this.centerLatitude,
    required this.revenue,
    required this.maximumCareRadius,
    required this.careDuration,
    required this.commuteDuration,
    required this.fromDate,
    required this.toDate,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      ownerNurseId: json['ownerNurseId'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      hasInfectiousDisease: json['hasInfectiousDisease'],
      hasMedicalCare: json['hasMedicalCare'],
      hasBasicCare: json['hasBasicCare'],
      hasWoundCare: json['hasWoundCare'],
      hasHousekeeping: json['hasHousekeeping'],
      bonus: json['bonus'],
      dayOfWeek: json['dayOfWeek'],
      type: json['type'],
      centerLongitude: json['centerLongitude'],
      centerLatitude: json['centerLatitude'],
      revenue: json['revenue'],
      maximumCareRadius: json['maximumCareRadius'],
      careDuration: json['careDuration'],
      commuteDuration: json['commuteDuration'],
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerNurseId": ownerNurseId,
      "fromTime": fromTime,
      "toTime": toTime,
      "hasInfectiousDisease": hasInfectiousDisease,
      "hasMedicalCare": hasMedicalCare,
      "hasBasicCare": hasBasicCare,
      "hasWoundCare": hasWoundCare,
      "hasHousekeeping": hasHousekeeping,
      "bonus": bonus,
      "dayOfWeek": dayOfWeek,
      "type": type,
      "centerLongitude": centerLongitude,
      "centerLatitude": centerLatitude,
      "revenue": revenue,
      "maximumCareRadius": maximumCareRadius,
      "careDuration": careDuration,
      "commuteDuration": commuteDuration,
      "fromDate": DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(fromDate),
      "toDate": DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(toDate),
    };
  }

  TourModel copyWith({
    int? id,
    int? ownerNurseId,
    String? fromTime,
    String? toTime,
    bool? hasInfectiousDisease,
    bool? hasMedicalCare,
    bool? hasBasicCare,
    bool? hasWoundCare,
    bool? hasHousekeeping,
    int? bonus,
    int? dayOfWeek,
    int? type,
    double? centerLongitude,
    double? centerLatitude,
    int? revenue,
    int? maximumCareRadius,
    int? careDuration,
    int? commuteDuration,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return TourModel(
      id: id ?? this.id,
      ownerNurseId: ownerNurseId ?? this.ownerNurseId,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      hasInfectiousDisease: hasInfectiousDisease ?? this.hasInfectiousDisease,
      hasMedicalCare: hasMedicalCare ?? this.hasMedicalCare,
      hasBasicCare: hasBasicCare ?? this.hasBasicCare,
      hasWoundCare: hasWoundCare ?? this.hasWoundCare,
      hasHousekeeping: hasHousekeeping ?? this.hasHousekeeping,
      bonus: bonus ?? this.bonus,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      type: type ?? this.type,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      revenue: revenue ?? this.revenue,
      maximumCareRadius: maximumCareRadius ?? this.maximumCareRadius,
      careDuration: careDuration ?? this.careDuration,
      commuteDuration: commuteDuration ?? this.commuteDuration,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
