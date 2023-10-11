import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final String text, value;
  final List<String> items;
  final void Function(String?)? onChanged;

  const MyDropdown({
    required this.text,
    required this.value,
    required this.items,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text.toUpperCase(),
          style: style(fontSize: 12),
        ),
        Container(
          width: double.infinity,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColors.white.withOpacity(0.1),
          ),
          child: DropdownButton(
            onChanged: onChanged,
            underline: Container(),
            value: value,
            isExpanded: true,
            items: items
                .map(
                  (String e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
