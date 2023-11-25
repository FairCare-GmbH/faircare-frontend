import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularRatingWidget extends StatelessWidget {
  const CircularRatingWidget({
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
                  rating?.toStringAsFixed(2) ?? '-',
                  style: style(
                    fontSize: 32,
                    color: FCColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$totalRating Bewertungen',
                  style: style(color: FCColors.grey),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            progressColor: FCColors.red,
          ),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 12,
            percent: (rating ?? 0) / 5,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.transparent,
            progressColor: FCColors.green,
          ),
        ],
      ),
    );
  }
}
