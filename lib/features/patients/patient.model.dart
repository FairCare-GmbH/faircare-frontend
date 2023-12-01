import 'dart:convert';

class PatientModel {
  final int id;
  final String prefix;
  final String firstName;
  final String lastName;
  final int gender;
  final String email;
  final String phone;
  final String fax;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime? dateOfBirth;
  final DateTime dateCreated;
  final DateTime lastUpdate;
  final String? plannedCareStart;
  final String? plannedCareEnd;
  final int? pflegegrad;
  final List<String>? absences;

  PatientModel({
    required this.id,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.fax,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.dateOfBirth,
    required this.dateCreated,
    required this.lastUpdate,
    required this.plannedCareStart,
    required this.plannedCareEnd,
    required this.pflegegrad,
    required this.absences,
  });

  PatientModel copyWith({
    int? id,
    String? prefix,
    String? firstName,
    String? lastName,
    int? gender,
    String? email,
    String? phone,
    String? fax,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? dateOfBirth,
    DateTime? dateCreated,
    DateTime? lastUpdate,
    String? plannedCareStart,
    String? plannedCareEnd,
    int? pflegegrad,
    List<String>? absences,
  }) =>
      PatientModel(
        id: id ?? this.id,
        prefix: prefix ?? this.prefix,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fax: fax ?? this.fax,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        dateCreated: dateCreated ?? this.dateCreated,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        plannedCareStart: plannedCareStart ?? this.plannedCareStart,
        plannedCareEnd: plannedCareEnd ?? this.plannedCareEnd,
        pflegegrad: pflegegrad ?? this.pflegegrad,
        absences: absences ?? this.absences,
      );

  factory PatientModel.fromRawJson(String str) => PatientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientModel.fromJson(Map<String, dynamic> json) => PatientModel(
        id: json["id"],
        prefix: json["prefix"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        fax: json["fax"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        dateCreated: DateTime.parse(json["dateCreated"]),
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        plannedCareStart: json["plannedCareStart"],
        plannedCareEnd: json["plannedCareEnd"],
        pflegegrad: json["pflegegrad"],
        absences: List<String>.from(json["absences"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prefix": prefix,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "phone": phone,
        "fax": fax,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "dateCreated": dateCreated.toIso8601String(),
        "lastUpdate": lastUpdate.toIso8601String(),
        "plannedCareStart": plannedCareStart,
        "plannedCareEnd": plannedCareEnd,
        "pflegegrad": pflegegrad,
        "absences": absences != null
            ? List<dynamic>.from(absences!.map((x) => x))
            : null,
      };
}
