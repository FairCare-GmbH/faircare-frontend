class CalendarModel {
  final DateTime fromDate;
  final DateTime toDate;
  final int dayOfWeek;
  final int tourType;
  final int? assignedTourType;

  CalendarModel({
    required this.fromDate,
    required this.toDate,
    required this.dayOfWeek,
    required this.tourType,
    required this.assignedTourType,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
      dayOfWeek: json['dayOfWeek'],
      tourType: json['tourType'],
      assignedTourType: json['assignedTourType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "dayOfWeek": dayOfWeek,
      "tourType": tourType,
      "assignedTourType": assignedTourType,
    };
  }

  CalendarModel copyWith({
    int? id,
    int? nurseId,
    DateTime? fromDate,
    DateTime? toDate,
    int? dayOfWeek,
    int? tourType,
    int? assignedTourType,
  }) {
    return CalendarModel(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      tourType: tourType ?? this.tourType,
      assignedTourType: assignedTourType ?? this.assignedTourType,
    );
  }
}
