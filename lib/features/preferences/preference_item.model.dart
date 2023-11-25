class PreferenceItemModel {
  final DateTime startDate;
  final DateTime endDate;
  final int dayOfWeek;
  final int type;

  PreferenceItemModel({
    required this.startDate,
    required this.endDate,
    required this.dayOfWeek,
    required this.type,
  });

  factory PreferenceItemModel.fromJson(Map<String, dynamic> json) {
    return PreferenceItemModel(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      dayOfWeek: json['dayOfWeek'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
      "dayOfWeek": dayOfWeek,
      "type": type,
    };
  }

  PreferenceItemModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? dayOfWeek,
    int? type,
  }) {
    return PreferenceItemModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      type: type ?? this.type,
    );
  }
}
