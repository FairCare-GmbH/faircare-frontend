import 'package:flutter/material.dart';

extension StringExtension on String {
  String toProperCase() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateTimeExt on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return (year == now.year && month == now.month && day == now.day);
  }

  int get daysFromToday => DateTime.now().ymd.difference(ymd).inDays;

  bool get isInPast {
    return isBefore(DateTime.now().ymd);
  }

  bool get isInFuture {
    return isAfter(DateTime.now().ymd);
  }

  bool get isTodayOrInPast {
    return isToday || isInPast;
  }

  bool get isTodayOrInFuture {
    return isToday || isInFuture;
  }

  DateTime get ymd {
    return DateTime(year, month, day);
  }

  bool isSameDay(DateTime date) {
    return (year == date.year && month == date.month && day == date.day);
  }

  bool isSameDayOrBefore(DateTime date) {
    return isSameDay(date) || isBefore(date);
  }

  bool isSameDayOrAfter(DateTime date) {
    return isSameDay(date) || isAfter(date);
  }
}

extension TimeExtension on String {
  TimeOfDay get time {
    final text = split(':');
    return TimeOfDay(
      hour: int.parse(text[0]),
      minute: int.parse(text[1]),
    );
  }
}
