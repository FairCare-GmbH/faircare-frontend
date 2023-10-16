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

  final double rating;
  final int totalRating;

  @override
  Widget build(BuildContext context) {
    double progress = rating / 5;
    double greenPercent = progress - 0.03;
    double redPercent = 1 - progress - 0.03;

    if (greenPercent < 0) greenPercent = 0;
    if (redPercent < 0) redPercent = 0;

    if (rating == 5) {
      greenPercent = 1;
      redPercent = 0;
    }

    if (rating == 0) {
      greenPercent = 0;
      redPercent = 1;
    }

    return Center(
      child: Stack(
        children: [
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 12,
            percent: redPercent,
            startAngle: 349.5,
            reverse: true,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$rating',
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
            percent: greenPercent,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.transparent,
            progressColor: MyColors.green,
          ),
        ],
      ),
    );
  }
}
