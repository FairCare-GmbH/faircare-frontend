import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularRating extends StatelessWidget {
  const CircularRating({
    required this.rating,
    required this.totalRating,
    Key? key,
  }) : super(key: key);

  final double? rating;
  final int totalRating;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        children: [
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 12,
            percent: 1,
            startAngle: 349.5,
            reverse: true,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating?.toString() ?? '-',
                  style: style(
                    fontSize: 32,
                    color: MyColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$totalRating Bewertungen',
                  style: style(color: MyColors.grey),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            progressColor: MyColors.red,
          ),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 12,
            percent: (rating ?? 0) / 5,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.transparent,
            progressColor: MyColors.green,
          ),
        ],
      ),
    );
  }
}
