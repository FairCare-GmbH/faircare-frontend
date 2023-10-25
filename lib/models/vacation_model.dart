class VacationModel {
  DateTime fromDate;
  DateTime toDate;
  int approvalStatus;

  VacationModel({
    required this.fromDate,
    required this.toDate,
    required this.approvalStatus,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      fromDate: DateTime.parse(json["fromDate"]),
      toDate: DateTime.parse(json["toDate"]),
      approvalStatus: json["approvalStatus"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "approvalStatus": approvalStatus,
    };
  }

  VacationModel copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    int? approvalStatus,
  }) {
    return VacationModel(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }
}
