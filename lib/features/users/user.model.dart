 
class UserModel {
  int id;
  String prefix;
  String firstName;
  String lastName;
  int gender;
  String email;
  String phone;
  String address;
  double latitude;
  double longitude;
  DateTime lastUpdate;
  String qualification;
  bool allowInfectiousDisease;
  bool allowMedicalCare;
  bool allowBasicCare;
  bool allowWoundCare;
  bool allowHousekeeping;
  bool allowCompanionship;
  bool hasDriversLicense;
  String availableFrom;
  double maximumCareRadius;
  int weeklyHourMinimum;
  int weeklyHourMaximum;
  String? leadSource;
  DateTime dateCreated;
  bool openForPatients;
  bool isActive;
  int hourlyWage;

  UserModel({
    required this.id,
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
    required this.hasDriversLicense,
    required this.availableFrom,
    required this.maximumCareRadius,
    required this.weeklyHourMinimum,
    required this.weeklyHourMaximum,
    this.leadSource,
    required this.dateCreated,
    required this.openForPatients,
    required this.isActive,
    required this.hourlyWage,
  });

  UserModel copyWith({
    int? id,
    String? prefix,
    String? firstName,
    String? lastName,
    int? gender,
    String? email,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
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
    double? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? leadSource,
    DateTime? dateCreated,
    bool? openForPatients,
    bool? isActive,
    int? hourlyWage,
  }) =>
      UserModel(
        id: id ?? this.id,
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
        allowInfectiousDisease:
            allowInfectiousDisease ?? this.allowInfectiousDisease,
        allowMedicalCare: allowMedicalCare ?? this.allowMedicalCare,
        allowBasicCare: allowBasicCare ?? this.allowBasicCare,
        allowWoundCare: allowWoundCare ?? this.allowWoundCare,
        allowHousekeeping: allowHousekeeping ?? this.allowHousekeeping,
        allowCompanionship: allowCompanionship ?? this.allowCompanionship,
        hasDriversLicense: hasDriversLicense ?? this.hasDriversLicense,
        availableFrom: availableFrom ?? this.availableFrom,
        maximumCareRadius: maximumCareRadius ?? this.maximumCareRadius,
        weeklyHourMinimum: weeklyHourMinimum ?? this.weeklyHourMinimum,
        weeklyHourMaximum: weeklyHourMaximum ?? this.weeklyHourMaximum,
        leadSource: leadSource ?? this.leadSource,
        dateCreated: dateCreated ?? this.dateCreated,
        openForPatients: openForPatients ?? this.openForPatients,
        isActive: isActive ?? this.isActive,
        hourlyWage: hourlyWage ?? this.hourlyWage,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        prefix: json["prefix"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        qualification: json["qualification"],
        allowInfectiousDisease: json["allowInfectiousDisease"],
        allowMedicalCare: json["allowMedicalCare"],
        allowBasicCare: json["allowBasicCare"],
        allowWoundCare: json["allowWoundCare"],
        allowHousekeeping: json["allowHousekeeping"],
        allowCompanionship: json["allowCompanionship"],
        hasDriversLicense: json["hasDriversLicense"],
        availableFrom: json["availableFrom"],
        maximumCareRadius: json["maximumCareRadius"].toDouble(),
        weeklyHourMinimum: json["weeklyHourMinimum"],
        weeklyHourMaximum: json["weeklyHourMaximum"],
        leadSource: json["leadSource"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        openForPatients: json["openForPatients"],
        isActive: json["isActive"],
        hourlyWage: json["hourlyWage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "hasDriversLicense": hasDriversLicense,
        "availableFrom": availableFrom,
        "maximumCareRadius": maximumCareRadius,
        "weeklyHourMinimum": weeklyHourMinimum,
        "weeklyHourMaximum": weeklyHourMaximum,
        "leadSource": leadSource,
        "dateCreated": dateCreated.toIso8601String(),
        "openForPatients": openForPatients,
        "isActive": isActive,
        "hourlyWage": hourlyWage,
      };
}
