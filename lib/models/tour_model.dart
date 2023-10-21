class TourModel {
  final int id;
  final int ownerNurseId;
  final String plannedFromTime;
  final String plannedToTime;
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
  final String actualFromTime;
  final String actualToTime;
  final DateTime fromDate;
  final DateTime toDate;

  TourModel({
    required this.id,
    required this.ownerNurseId,
    required this.plannedFromTime,
    required this.plannedToTime,
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
    required this.actualFromTime,
    required this.actualToTime,
    required this.fromDate,
    required this.toDate,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      id: json['id'],
      ownerNurseId: json['ownerNurseId'],
      plannedFromTime: json['plannedFromTime'],
      plannedToTime: json['plannedToTime'],
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
      actualFromTime: json['actualFromTime'],
      actualToTime: json['actualToTime'],
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerNurseId": ownerNurseId,
      "plannedFromTime": plannedFromTime,
      "plannedToTime": plannedToTime,
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
      "actualFromTime": actualFromTime,
      "actualToTime": actualToTime,
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
    };
  }

  TourModel copyWith({
    int? id,
    int? ownerNurseId,
    String? plannedFromTime,
    String? plannedToTime,
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
    String? actualFromTime,
    String? actualToTime,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return TourModel(
      id: id ?? this.id,
      ownerNurseId: ownerNurseId ?? this.ownerNurseId,
      plannedFromTime: plannedFromTime ?? this.plannedFromTime,
      plannedToTime: plannedToTime ?? this.plannedToTime,
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
      actualFromTime: actualFromTime ?? this.actualFromTime,
      actualToTime: actualToTime ?? this.actualToTime,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }
}
