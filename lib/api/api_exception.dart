import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;

class ApiException implements Exception {
  final int code;
  final List<String> messages;

  ApiException({required this.code, required this.messages});

  @override
  String toString() {
    return '$messages';
  }

  Future<T?> showDialog<T>(BuildContext context) {
    return material.showDialog(
      context: context,
      builder: (BuildContext context) => material.AlertDialog(
        title: Text('Error $code'),
        content: Text(messages[0]),//TODO add internationalization
        actions: <Widget>[
          material.TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
