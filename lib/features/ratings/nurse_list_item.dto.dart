class NurseListItemDto {
  final int nurseId;
  final String? prefix;
  final String firstName;
  final String lastName;
  final int? metric;

  NurseListItemDto(
      {required this.nurseId,
      this.prefix,
      required this.firstName,
      required this.lastName,
      this.metric});

  factory NurseListItemDto.fromJson(Map<String, dynamic> json) =>
      NurseListItemDto(
        nurseId: json["nurseId"].toInt(),
        prefix: json["prefix"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        metric: json["metric"] == null ? null : int.parse(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "nurseId": nurseId,
        "prefix": prefix,
        "firstName": firstName,
        "lastName": lastName,
        "metric": metric,
      };
}
