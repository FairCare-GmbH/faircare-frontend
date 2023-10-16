import 'package:intl/intl.dart';

class UserModel {
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
  final String marketingSource;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.qualification,
    required this.hasDriversLicense,
    required this.availableFrom,
    required this.maximumCareRadius,
    required this.weeklyHourMinimum,
    required this.weeklyHourMaximum,
    required this.marketingSource,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
      "availableFrom":
          DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(availableFrom),
      "maximumCareRadius": maximumCareRadius,
      "weeklyHourMinimum": weeklyHourMinimum,
      "weeklyHourMaximum": weeklyHourMaximum,
      "marketingSource": marketingSource,
    };
  }

  UserModel copyWith({
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
    String? marketingSource,
  }) {
    return UserModel(
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
      marketingSource: marketingSource ?? this.marketingSource,
    );
  }
}
