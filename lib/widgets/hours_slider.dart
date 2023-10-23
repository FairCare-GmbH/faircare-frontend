import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';

class HoursSlider extends StatelessWidget {
  const HoursSlider({
    required this.min,
    required this.max,
    required this.selectedRange,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  final double min, max;
  final RangeValues selectedRange;
  final void Function(RangeValues)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorColor: MyColors.prime,
        valueIndicatorTextStyle: style(color: MyColors.white, fontSize: 14),
      ),
      child: RangeSlider(
        values: selectedRange,
        min: min,
        max: max,
        labels: RangeLabels(
          selectedRange.start.toInt().toString(),
          selectedRange.end.toInt().toString(),
        ),
        activeColor: MyColors.prime,
        inactiveColor: MyColors.border,
        onChanged: onChanged,
      ),
    );
  }
}
