class NurseModel {
  final int id;
  final int personId;
  final String qualification;
  final bool allowInfectiousDisease;
  final bool allowMedicalCare;
  final bool allowBasicCare;
  final bool allowWoundCare;
  final bool allowHousekeeping;
  final String ratingVector5;
  final String ratingVector4;
  final String ratingVector3;
  final String ratingVector2;
  final String ratingVector1;
  final bool hasDriversLicense;
  final String availableFrom;
  final int maximumCareRadius;
  final int weeklyHourMinimum;
  final int weeklyHourMaximum;
  final String marketingSource;
  final String dateCreated;
  final bool openForPatients;
  final bool isActive;

  NurseModel({
    required this.id,
    required this.personId,
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

  factory NurseModel.fromJson(Map<String, dynamic> json) {
    return NurseModel(
      id: json['id'],
      personId: json['personId'],
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
      hasDriversLicense: json['hasDriversLicense'],
      availableFrom: json['availableFrom'],
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
      "hasDriversLicense": hasDriversLicense,
      "availableFrom": availableFrom,
      "maximumCareRadius": maximumCareRadius,
      "weeklyHourMinimum": weeklyHourMinimum,
      "weeklyHourMaximum": weeklyHourMaximum,
      "marketingSource": marketingSource,
      "dateCreated": dateCreated,
      "openForPatients": openForPatients,
      "isActive": isActive,
    };
  }

  NurseModel copyWith({
    int? id,
    int? personId,
    String? qualification,
    bool? allowInfectiousDisease,
    bool? allowMedicalCare,
    bool? allowBasicCare,
    bool? allowWoundCare,
    bool? allowHousekeeping,
    String? ratingVector5,
    String? ratingVector4,
    String? ratingVector3,
    String? ratingVector2,
    String? ratingVector1,
    bool? hasDriversLicense,
    String? availableFrom,
    int? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? marketingSource,
    String? dateCreated,
    bool? openForPatients,
    bool? isActive,
  }) {
    return NurseModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
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
