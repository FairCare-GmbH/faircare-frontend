import 'package:faircare/global/constants.dart';

class RegisterModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final double latitude;
  final double longitude;
  final String qualification;
  final bool hasDriversLicense;
  final DateTime availableFrom;
  final int maximumCareRadius;
  final int weeklyHourMinimum;
  final int weeklyHourMaximum;
  final String hoursType;
  final String marketingSource;
  final String password;
  final bool termsAgreed;
  final bool dataProtectionAgreed;

  RegisterModel({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    String? qualification,
    this.hasDriversLicense = false,
    DateTime? availableFrom,
    int? maximumCareRadius,
    this.weeklyHourMinimum = 1,
    this.weeklyHourMaximum = 5,
    String? hoursType,
    String? marketingSource,
    this.termsAgreed = false,
    this.dataProtectionAgreed = false,
    this.password = ''
  })  : availableFrom = availableFrom ?? DateTime.now(),
        qualification = qualification ?? qualifications[0],
        maximumCareRadius = maximumCareRadius ?? distances[0],
        marketingSource = marketingSource ?? sources[0],
        hoursType = hoursType ?? hoursTypes[0];

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      qualification: json['qualification'],
      hasDriversLicense: json['hasDriversLicense'],
      availableFrom: DateTime.parse(json['availableFrom']),
      maximumCareRadius: json['maximumCareRadius'],
      weeklyHourMinimum: json['weeklyHourMinimum'],
      weeklyHourMaximum: json['weeklyHourMaximum'],
      marketingSource: json['marketingSource'],
      hoursType: json['hoursType'],
      termsAgreed: json['termsAgreed'],
      dataProtectionAgreed: json['dataProtectionAgreed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "qualification": qualification,
      "hasDriversLicense": hasDriversLicense,
      "availableFrom": availableFrom.toIso8601String(),
      "maximumCareRadius": maximumCareRadius,
      "weeklyHourMinimum": weeklyHourMinimum,
      "weeklyHourMaximum": weeklyHourMaximum,
      "marketingSource": marketingSource,
      "hoursType": hoursType,
      "termsAgreed": termsAgreed,
      "dataProtectionAgreed": dataProtectionAgreed,
      "password": password
    };
  }

  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    String? qualification,
    bool? hasDriversLicense,
    DateTime? availableFrom,
    int? maximumCareRadius,
    int? weeklyHourMinimum,
    int? weeklyHourMaximum,
    String? hoursType,
    String? marketingSource,
    bool? termsAgreed,
    bool? dataProtectionAgreed,
    String? password
  }) {
    return RegisterModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      qualification: qualification ?? this.qualification,
      hasDriversLicense: hasDriversLicense ?? this.hasDriversLicense,
      availableFrom: availableFrom ?? this.availableFrom,
      maximumCareRadius: maximumCareRadius ?? this.maximumCareRadius,
      weeklyHourMinimum: weeklyHourMinimum ?? this.weeklyHourMinimum,
      weeklyHourMaximum: weeklyHourMaximum ?? this.weeklyHourMaximum,
      hoursType: hoursType ?? this.hoursType,
      marketingSource: marketingSource ?? this.marketingSource,
      termsAgreed: termsAgreed ?? this.termsAgreed,
      dataProtectionAgreed: dataProtectionAgreed ?? this.dataProtectionAgreed,
      password: password ?? this.password
    );
  }
}
