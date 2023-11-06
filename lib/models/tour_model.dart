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
  final bool hasCompanionship;
  final int bonus;
  final int dayOfWeek;
  final int type;
  final double centerLongitude;
  final double centerLatitude;
  final int revenue;
  final double maximumCareRadius;
  final String? actualFromTime;
  final String? actualToTime;
  final DateTime fromDate;
  final DateTime toDate;
  final bool isOpen;

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
    required this.hasCompanionship,
    required this.bonus,
    required this.dayOfWeek,
    required this.type,
    required this.centerLongitude,
    required this.centerLatitude,
    required this.revenue,
    required this.maximumCareRadius,
    this.actualFromTime,
    this.actualToTime,
    required this.fromDate,
    required this.toDate,
    required this.isOpen,
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
      hasCompanionship: json['hasCompanionship'],
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
      isOpen: json['isOpen'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerNurseId": ownerNurseId,
      "plannedFromTime": fromTime,
      "plannedToTime": toTime,
      "hasInfectiousDisease": hasInfectiousDisease,
      "hasMedicalCare": hasMedicalCare,
      "hasBasicCare": hasBasicCare,
      "hasWoundCare": hasWoundCare,
      "hasHousekeeping": hasHousekeeping,
      "hasCompanionship": hasCompanionship,
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
      "isOpen": isOpen,
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
    bool? hasCompanionship,
    int? bonus,
    int? dayOfWeek,
    int? type,
    double? centerLongitude,
    double? centerLatitude,
    int? revenue,
    double? maximumCareRadius,
    String? actualFromTime,
    String? actualToTime,
    DateTime? fromDate,
    DateTime? toDate,
    bool? isOpen,
  }) {
    return TourModel(
      id: id ?? this.id,
      ownerNurseId: ownerNurseId ?? this.ownerNurseId,
      fromTime: plannedFromTime ?? fromTime,
      toTime: plannedToTime ?? toTime,
      hasInfectiousDisease: hasInfectiousDisease ?? this.hasInfectiousDisease,
      hasMedicalCare: hasMedicalCare ?? this.hasMedicalCare,
      hasBasicCare: hasBasicCare ?? this.hasBasicCare,
      hasWoundCare: hasWoundCare ?? this.hasWoundCare,
      hasHousekeeping: hasHousekeeping ?? this.hasHousekeeping,
      hasCompanionship: hasCompanionship ?? this.hasCompanionship,
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
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
