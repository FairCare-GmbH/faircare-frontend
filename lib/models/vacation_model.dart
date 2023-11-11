class VacationModel {
  final int id;
  final int nurseId;
  final DateTime fromDate;
  final DateTime toDate;
  final int daysRequested;
  final int daysApproved;

  VacationModel({
    required this.id,
    required this.nurseId,
    required this.fromDate,
    required this.toDate,
    required this.daysRequested,
    required this.daysApproved,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      id: json["id"],
      fromDate: DateTime.parse(json["fromDate"]),
      toDate: DateTime.parse(json["toDate"]),
      nurseId: json["nurseId"],
      daysRequested: int.parse(json["daysRequested"]),
      daysApproved: int.parse(json["daysApproved"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "nurseId": nurseId,
      "daysRequested": daysRequested,
      "daysApproved": daysApproved,
    };
  }

  VacationModel copyWith({
    int? id,
    int? nurseId,
    DateTime? fromDate,
    DateTime? toDate,
    int? daysRequested,
    int? daysApproved,
  }) {
    return VacationModel(
      id: id ?? this.id,
      nurseId: nurseId ?? this.nurseId,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      daysRequested: daysRequested ?? this.daysRequested,
      daysApproved: daysApproved ?? this.daysApproved,
    );
  }
}
