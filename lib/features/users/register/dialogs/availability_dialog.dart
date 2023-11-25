import 'package:flutter/material.dart';

Future<DateTime?> showAvailabilityDialog(BuildContext context) async {
  final date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2025),
  );

  return date;
}
