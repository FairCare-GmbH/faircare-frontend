import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class RatingItemWidget extends StatelessWidget {
  const RatingItemWidget(
    this.text, {
    this.rating = 5,
    Key? key,
  }) : super(key: key);

  final String text;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: style(
                fontSize: 16,
                color: FCColors.darkGrey,
              ),
            ),
            Text(
              '${rating.toStringAsFixed(1)}/5',
              style: style(
                fontSize: 16,
                color: FCColors.darkGrey,
              ),
            ),
          ],
        ),
        const VerticalSpacer(12),
        ProgressWidget(rating),
      ],
    );
  }
}

class ProgressWidget extends StatelessWidget {
  const ProgressWidget(this.rating, {Key? key}) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    double progress = rating / 5;

    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: FCColors.border,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: (progress * 100).toInt(),
            child: Container(
              decoration: BoxDecoration(
                color: getColor(),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Expanded(
            flex: ((1 - progress) * 100).toInt(),
            child: Container(),
          ),
        ],
      ),
    );
  }

  Color getColor() {
    if (rating == 5 || rating == 4) return FCColors.green;
    if (rating == 3) return FCColors.orange;
    if (rating == 2 || rating == 1) return FCColors.red;
    return FCColors.green;
  }
}
