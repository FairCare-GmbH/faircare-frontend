class PreferenceModel {
  final DateTime startDate;
  final DateTime endDate;
  final int dayOfWeek;
  final int type;

  PreferenceModel({
    required this.startDate,
    required this.endDate,
    required this.dayOfWeek,
    required this.type,
  });

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
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

  PreferenceModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? dayOfWeek,
    int? type,
  }) {
    return PreferenceModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      type: type ?? this.type,
    );
  }
}
