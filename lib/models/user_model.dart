import 'dart:math';

class UserModel {
  int id;
  String type;
  String prefix;
  String firstName;
  String lastName;
  int gender;
  String email;
  String phone;
  String address;
  int latitude;
  int longitude;
  DateTime lastUpdate;
  String qualification;
  bool allowInfectiousDisease;
  bool allowMedicalCare;
  bool allowBasicCare;
  bool allowWoundCare;
  bool allowHousekeeping;
  bool allowCompanionship;
  double? ratingVector5;
  double? ratingVector4;
  double? ratingVector3;
  double? ratingVector2;
  double? ratingVector1;
  int? ratingCount;
  bool hasDriversLicense;
  String availableFrom;
  int maximumCareRadius;
  int weeklyHourMinimum;
  int weeklyHourMaximum;
  String marketingSource;
  DateTime dateCreated;
  bool openForPatients;
  bool isActive;

  UserModel({
    required this.id,
    required this.type,
    required this.prefix,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.lastUpdate,
    required this.qualification,
    required this.allowInfectiousDisease,
    required this.allowMedicalCare,
    required this.allowBasicCare,
    required this.allowWoundCare,
    required this.allowHousekeeping,
    required this.allowCompanionship,
    required this.ratingVector5,
    required this.ratingVector4,
    required this.ratingVector3,
    required this.ratingVector2,
    required this.ratingVector1,
    required this.ratingCount,
    required this.hasDriversLicense,
    required this.availableFrom,
    required this.maximumCareRadius,
    required this.weeklyHourMinimum,
    required this.weeklyHourMaximum,
    required this.marketingSource,
    required this.dateCreated,
    required this.openForPatients,
    required this.isActive,
  });

  double? getAverageRating() {
    final avg = ((ratingVector1 ?? 0) +
            (ratingVector2 ?? 0) +
            (ratingVector3 ?? 0) +
            (ratingVector4 ?? 0) +
            (ratingVector5 ?? 0)) /
        max(
            1,
            (((ratingVector1 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector2 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector3 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector4 ?? 0) > 0 ? 1 : 0) +
                ((ratingVector5 ?? 0) > 0 ? 1 : 0)));
    return avg == 0 ? null : avg;
  }

  UserModel copyWith({
    int? id,
    String? type,
    String? prefix,
    String? firstName,
    String? lastName,
    int? gender,
    String? email,
    String? phone,
    String? address,
    int? latitude,
    int? longitude,
    DateTime? lastUpdate,
    String? qualification,
    bool? allowInfectiousDisease,
    bool? allowMedicalCare,
    bool? allowBasicCare,
    bool? allowWoundCare,
    bool? allowHousekeeping,
    bool? allowCompanionship,
    double? ratingVector5,
    double? ratingVector4,
    double? ratingVector3,
    double? ratingVector2,
    double? ratingVector1,
    int? ratingCount,
    bool? hasDriversLicense,
    String? availableFrom,
    int? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? marketingSource,
    DateTime? dateCreated,
    bool? openForPatients,
    bool? isActive,
  }) =>
      UserModel(
        id: id ?? this.id,
        type: type ?? this.type,
        prefix: prefix ?? this.prefix,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        qualification: qualification ?? this.qualification,
        allowInfectiousDisease: allowInfectiousDisease ?? this.allowInfectiousDisease,
        allowMedicalCare: allowMedicalCare ?? this.allowMedicalCare,
        allowBasicCare: allowBasicCare ?? this.allowBasicCare,
        allowWoundCare: allowWoundCare ?? this.allowWoundCare,
        allowHousekeeping: allowHousekeeping ?? this.allowHousekeeping,
        allowCompanionship: allowCompanionship ?? this.allowCompanionship,
        ratingVector5: ratingVector5 ?? this.ratingVector5,
        ratingVector4: ratingVector4 ?? this.ratingVector4,
        ratingVector3: ratingVector3 ?? this.ratingVector3,
        ratingVector2: ratingVector2 ?? this.ratingVector2,
        ratingVector1: ratingVector1 ?? this.ratingVector1,
        ratingCount: ratingCount ?? this.ratingCount,
        hasDriversLicense: hasDriversLicense ?? this.hasDriversLicense,
        availableFrom: availableFrom ?? this.availableFrom,
        maximumCareRadius: maximumCareRadius ?? this.maximumCareRadius,
        weeklyHourMinimum: weeklyHourMinimum ?? this.weeklyHourMinimum,
        weeklyHourMaximum: weeklyHourMaximum ?? this.weeklyHourMaximum,
        marketingSource: marketingSource ?? this.marketingSource,
        dateCreated: dateCreated ?? this.dateCreated,
        openForPatients: openForPatients ?? this.openForPatients,
        isActive: isActive ?? this.isActive,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        type: json["type"],
        prefix: json["prefix"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        qualification: json["qualification"],
        allowInfectiousDisease: json["allowInfectiousDisease"],
        allowMedicalCare: json["allowMedicalCare"],
        allowBasicCare: json["allowBasicCare"],
        allowWoundCare: json["allowWoundCare"],
        allowHousekeeping: json["allowHousekeeping"],
        allowCompanionship: json["allowCompanionship"],
        ratingVector5: json["ratingVector5"]?.toDouble(),
        ratingVector4: json["ratingVector4"]?.toDouble(),
        ratingVector3: json["ratingVector3"]?.toDouble(),
        ratingVector2: json["ratingVector2"]?.toDouble(),
        ratingVector1: json["ratingVector1"]?.toDouble(),
        ratingCount: json["ratingCount"],
        hasDriversLicense: json["hasDriversLicense"],
        availableFrom: json["availableFrom"],
        maximumCareRadius: json["maximumCareRadius"],
        weeklyHourMinimum: json["weeklyHourMinimum"],
        weeklyHourMaximum: json["weeklyHourMaximum"],
        marketingSource: json["marketingSource"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        openForPatients: json["openForPatients"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "prefix": prefix,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "email": email,
        "phone": phone,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "lastUpdate": lastUpdate.toIso8601String(),
        "qualification": qualification,
        "allowInfectiousDisease": allowInfectiousDisease,
        "allowMedicalCare": allowMedicalCare,
        "allowBasicCare": allowBasicCare,
        "allowWoundCare": allowWoundCare,
        "allowHousekeeping": allowHousekeeping,
        "allowCompanionship": allowCompanionship,
        "ratingVector5": ratingVector5,
        "ratingVector4": ratingVector4,
        "ratingVector3": ratingVector3,
        "ratingVector2": ratingVector2,
        "ratingVector1": ratingVector1,
        "ratingCount": ratingCount,
        "hasDriversLicense": hasDriversLicense,
        "availableFrom": availableFrom,
        "maximumCareRadius": maximumCareRadius,
        "weeklyHourMinimum": weeklyHourMinimum,
        "weeklyHourMaximum": weeklyHourMaximum,
        "marketingSource": marketingSource,
        "dateCreated": dateCreated.toIso8601String(),
        "openForPatients": openForPatients,
        "isActive": isActive,
      };
}
