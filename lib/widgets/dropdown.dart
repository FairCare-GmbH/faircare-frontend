import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final String label;
  final dynamic value;
  final List items;
  final void Function(dynamic)? onChanged;

  const MyDropdown({
    required this.label,
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
          label,
          style: style(color: MyColors.grey),
        ),
        const VerticalSpacer(6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: MyColors.border,
            ),
          ),
          child: DropdownButton(
            onChanged: onChanged,
            underline: Container(),
            value: value,
            itemHeight: 48,
            isExpanded: true,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.toString()),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
