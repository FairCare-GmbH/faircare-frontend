class CalendarModel {
  final int id;
  final int nurseId;
  final DateTime fromDate;
  final DateTime toDate;
  final int dayOfWeek;
  final int tourType;
  final bool hasAssignedTour;

  CalendarModel({
    required this.id,
    required this.nurseId,
    required this.fromDate,
    required this.toDate,
    required this.dayOfWeek,
    required this.tourType,
    required this.hasAssignedTour,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json['id'],
      nurseId: json['nurseId'],
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
      dayOfWeek: json['dayOfWeek'],
      tourType: json['tourType'],
      hasAssignedTour: json['hasAssignedTour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nurseId": nurseId,
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "dayOfWeek": dayOfWeek,
      "tourType": tourType,
      "hasAssignedTour": hasAssignedTour,
    };
  }

  CalendarModel copyWith({
    int? id,
    int? nurseId,
    DateTime? fromDate,
    DateTime? toDate,
    int? dayOfWeek,
    int? tourType,
    bool? hasAssignedTour,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      nurseId: nurseId ?? this.nurseId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      tourType: tourType ?? this.tourType,
      hasAssignedTour: hasAssignedTour ?? this.hasAssignedTour,
    );
  }
}
