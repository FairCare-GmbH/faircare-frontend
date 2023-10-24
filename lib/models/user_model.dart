class UserModel {
  final int id;
  final int personId;
  final String name;
  final String email;
  final String qualification;
  final bool allowInfectiousDisease;
  final bool allowMedicalCare;
  final bool allowBasicCare;
  final bool allowWoundCare;
  final bool allowHousekeeping;
  final double ratingVector5;
  final double ratingVector4;
  final double ratingVector3;
  final double ratingVector2;
  final double ratingVector1;
  final int ratingCount;
  final bool hasDriversLicense;
  final DateTime availableFrom;
  final int maximumCareRadius;
  final int weeklyHourMinimum;
  final int weeklyHourMaximum;
  final String marketingSource;
  final String dateCreated;
  final bool openForPatients;
  final bool isActive;

  UserModel({
    required this.id,
    required this.personId,
    required this.name,
    required this.email,
    required this.qualification,
    required this.allowInfectiousDisease,
    required this.allowMedicalCare,
    required this.allowBasicCare,
    required this.allowWoundCare,
    required this.allowHousekeeping,
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      personId: json['personId'],
      name: json['name'],
      email: json['email'],
      qualification: json['qualification'],
      allowInfectiousDisease: json['allowInfectiousDisease'],
      allowMedicalCare: json['allowMedicalCare'],
      allowBasicCare: json['allowBasicCare'],
      allowWoundCare: json['allowWoundCare'],
      allowHousekeeping: json['allowHousekeeping'],
      ratingVector5: json['ratingVector5'],
      ratingVector4: json['ratingVector4'],
      ratingVector3: json['ratingVector3'],
      ratingVector2: json['ratingVector2'],
      ratingVector1: json['ratingVector1'],
      ratingCount: json['ratingCount'],
      hasDriversLicense: json['hasDriversLicense'],
      availableFrom: DateTime.parse(json['availableFrom']),
      maximumCareRadius: json['maximumCareRadius'],
      weeklyHourMinimum: json['weeklyHourMinimum'],
      weeklyHourMaximum: json['weeklyHourMaximum'],
      marketingSource: json['marketingSource'],
      dateCreated: json['dateCreated'],
      openForPatients: json['openForPatients'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "personId": personId,
      "name": name,
      "email": email,
      "qualification": qualification,
      "allowInfectiousDisease": allowInfectiousDisease,
      "allowMedicalCare": allowMedicalCare,
      "allowBasicCare": allowBasicCare,
      "allowWoundCare": allowWoundCare,
      "allowHousekeeping": allowHousekeeping,
      "ratingVector5": ratingVector5,
      "ratingVector4": ratingVector4,
      "ratingVector3": ratingVector3,
      "ratingVector2": ratingVector2,
      "ratingVector1": ratingVector1,
      "ratingCount": ratingCount,
      "hasDriversLicense": hasDriversLicense,
      "availableFrom": availableFrom.toIso8601String(),
      "maximumCareRadius": maximumCareRadius,
      "weeklyHourMinimum": weeklyHourMinimum,
      "weeklyHourMaximum": weeklyHourMaximum,
      "marketingSource": marketingSource,
      "dateCreated": dateCreated,
      "openForPatients": openForPatients,
      "isActive": isActive,
    };
  }

  UserModel copyWith({
    int? id,
    int? personId,
    String? name,
    String? email,
    String? qualification,
    bool? allowInfectiousDisease,
    bool? allowMedicalCare,
    bool? allowBasicCare,
    bool? allowWoundCare,
    bool? allowHousekeeping,
    double? ratingVector5,
    double? ratingVector4,
    double? ratingVector3,
    double? ratingVector2,
    double? ratingVector1,
    int? ratingCount,
    bool? hasDriversLicense,
    DateTime? availableFrom,
    int? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? marketingSource,
    String? dateCreated,
    bool? openForPatients,
    bool? isActive,
  }) {
    return UserModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      name: name ?? this.name,
      email: email ?? this.email,
      qualification: qualification ?? this.qualification,
      allowInfectiousDisease:
          allowInfectiousDisease ?? this.allowInfectiousDisease,
      allowMedicalCare: allowMedicalCare ?? this.allowMedicalCare,
      allowBasicCare: allowBasicCare ?? this.allowBasicCare,
      allowWoundCare: allowWoundCare ?? this.allowWoundCare,
      allowHousekeeping: allowHousekeeping ?? this.allowHousekeeping,
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
  }
}
