class CalendarModel {
  final DateTime fromDate;
  final DateTime toDate;
  final int dayOfWeek;
  final int tourType;
  final int? assignedTourType;
  final List<int>? assignedTourIds;

  CalendarModel({
    required this.fromDate,
    required this.toDate,
    required this.dayOfWeek,
    required this.tourType,
    required this.assignedTourType,
    required this.assignedTourIds,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      fromDate: DateTime.parse(json['fromDate']),
      toDate: DateTime.parse(json['toDate']),
      dayOfWeek: json['dayOfWeek'],
      tourType: json['tourType'],
      assignedTourType: json['assignedTourType'] != null
          ? int.parse(json['assignedTourType'].toString())
          : null,
      assignedTourIds: json['assignedTourIds'] != null
          ? (json['assignedTourIds'] as List<dynamic>)
              .map((e) => int.parse(e.toString()))
              .toList(growable: false)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "dayOfWeek": dayOfWeek,
      "tourType": tourType,
      "assignedTourType": assignedTourType,
      "assignedTourIds": assignedTourIds
    };
  }

  CalendarModel copyWith(
      {int? id,
      int? nurseId,
      DateTime? fromDate,
      DateTime? toDate,
      int? dayOfWeek,
      int? tourType,
      int? assignedTourType,
      List<int>? assignedTourIds}) {
    return CalendarModel(
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        tourType: tourType ?? this.tourType,
        assignedTourType: assignedTourType ?? this.assignedTourType,
        assignedTourIds: assignedTourIds ?? this.assignedTourIds);
  }
}
