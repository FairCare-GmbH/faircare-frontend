import 'package:faircare/features/tours/tour.model.dart';

class NotificationModel {
  int id;
  int nurseId;
  DateTime dateCreated;
  TourModel tourPlan;
  String icon;
  String title;
  String subtitle;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.nurseId,
    required this.dateCreated,
    required this.tourPlan,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      nurseId: json["nurseId"],
      dateCreated: DateTime.parse(json["dateCreated"]),
      tourPlan: TourModel.fromJson(json["tourPlan"]),
      icon: json["icon"],
      title: json["title"],
      subtitle: json["subtitle"],
      isRead: json["isRead"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nurseId": nurseId,
      "dateCreated": dateCreated.toIso8601String(),
      "tourPlan": tourPlan.toJson(),
      "icon": icon,
      "title": title,
      "subtitle": subtitle,
      "isRead": isRead,
    };
  }

  NotificationModel copyWith({
    int? id,
    int? nurseId,
    DateTime? dateCreated,
    TourModel? tourPlan,
    String? icon,
    String? title,
    String? subtitle,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      nurseId: nurseId ?? this.nurseId,
      dateCreated: dateCreated ?? this.dateCreated,
      tourPlan: tourPlan ?? this.tourPlan,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isRead: isRead ?? this.isRead,
    );
  }
}
