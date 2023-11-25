import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SmallCircularRatingWidget extends StatelessWidget {
  const SmallCircularRatingWidget({
    required this.rating,
    Key? key,
  }) : super(key: key);

  final double? rating;

  @override
  Widget build(BuildContext context) {
    double progress = (rating ?? 0) / 5;

    return CircularPercentIndicator(
      radius: 13,
      lineWidth: 2,
      percent: progress,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: MyColors.red,
      progressColor: MyColors.green,
      center: Text(
        rating?.toStringAsFixed(1) ?? '-',
        style: style(
          fontSize: 11,
          color: MyColors.darkGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
