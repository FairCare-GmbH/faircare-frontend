import 'package:faircare/global/constants.dart';

class PreferencesModel {
  final bool openForPatients;
  final int maximumCareRadius;
  final int weeklyHourMinimum;
  final int weeklyHourMaximum;
  final String hoursType;
  final bool allowInfectiousDisease;
  final bool allowMedicalCare;
  final bool allowBasicCare;
  final bool allowWoundCare;
  final bool allowHousekeeping;

  PreferencesModel({
    this.openForPatients = false,
    int? maximumCareRadius,
    this.weeklyHourMinimum = 1,
    this.weeklyHourMaximum = 5,
    String? hoursType,
    this.allowInfectiousDisease = true,
    this.allowMedicalCare = true,
    this.allowBasicCare = true,
    this.allowWoundCare = true,
    this.allowHousekeeping = true,
  })  : maximumCareRadius = maximumCareRadius ?? distances[0],
        hoursType = hoursType ?? hoursTypes[0];

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      openForPatients: json['openForPatients'],
      maximumCareRadius: json['maximumCareRadius'],
      weeklyHourMinimum: json['weeklyHourMinimum'],
      weeklyHourMaximum: json['weeklyHourMaximum'],
      hoursType: json['hoursType'],
      allowInfectiousDisease: json['allowInfectiousDisease'],
      allowMedicalCare: json['allowMedicalCare'],
      allowBasicCare: json['allowBasicCare'],
      allowWoundCare: json['allowWoundCare'],
      allowHousekeeping: json['allowHousekeeping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "openForPatients": openForPatients,
      "maximumCareRadius": maximumCareRadius,
      "weeklyHourMinimum": weeklyHourMinimum,
      "weeklyHourMaximum": weeklyHourMaximum,
      "hoursType": hoursType,
      "allowInfectiousDisease": allowInfectiousDisease,
      "allowMedicalCare": allowMedicalCare,
      "allowBasicCare": allowBasicCare,
      "allowWoundCare": allowWoundCare,
      "allowHousekeeping": allowHousekeeping,
    };
  }

  PreferencesModel copyWith({
    bool? openForPatients,
    int? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? hoursType,
    bool? allowInfectiousDisease,
    bool? allowMedicalCare,
    bool? allowBasicCare,
    bool? allowWoundCare,
    bool? allowHousekeeping,
  }) {
    return PreferencesModel(
      openForPatients: openForPatients ?? this.openForPatients,
      maximumCareRadius: maximumCareRadius ?? this.maximumCareRadius,
      weeklyHourMinimum: weeklyHourMinimum ?? this.weeklyHourMinimum,
      weeklyHourMaximum: weeklyHourMaximum ?? this.weeklyHourMaximum,
      hoursType: hoursType ?? this.hoursType,
      allowInfectiousDisease:
          allowInfectiousDisease ?? this.allowInfectiousDisease,
      allowMedicalCare: allowMedicalCare ?? this.allowMedicalCare,
      allowBasicCare: allowBasicCare ?? this.allowBasicCare,
      allowWoundCare: allowWoundCare ?? this.allowWoundCare,
      allowHousekeeping: allowHousekeeping ?? this.allowHousekeeping,
    );
  }
}
