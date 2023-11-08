import 'package:flutter/material.dart';

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Future<T> navigate<T>(BuildContext context, Widget to) async {
  return await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => to,
    ),
  );
}

Future navigateRemove(BuildContext context, Widget to) async {
  return await Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (_) => to,
    ),
    (route) => false,
  );
}

void pop(BuildContext context, [bool result = false]) {
  Navigator.of(context).pop(result);
}
