class VacationModel {
  final int id;
  final DateTime fromDate;
  final DateTime toDate;
  final int approvalStatus;


  VacationModel({
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.approvalStatus,
  });

  factory VacationModel.fromJson(Map<String, dynamic> json) {
    return VacationModel(
      id: json["id"],
      fromDate: DateTime.parse(json["fromDate"]),
      toDate: DateTime.parse(json["toDate"]),
      approvalStatus: json["approvalStatus"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fromDate": fromDate.toIso8601String(),
      "toDate": toDate.toIso8601String(),
      "approvalStatus": approvalStatus,
    };
  }

  VacationModel copyWith({
    int? id,
    DateTime? fromDate,
    DateTime? toDate,
    int? approvalStatus,
  }) {
    return VacationModel(
      id: id ?? this.id,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }
}
