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

  bool isSameDay(DateTime date) {
    return (year == date.year && month == date.month && day == date.day);
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
