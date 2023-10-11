import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MySwitch extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool?)? onChanged;

  const MySwitch({
    required this.text,
    required this.value,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        text,
        style: style(fontSize: 16),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
