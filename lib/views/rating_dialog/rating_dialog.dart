import 'package:faircare/global/global.dart';
import 'package:faircare/views/rating_dialog/circular_rating.dart';
import 'package:faircare/views/rating_dialog/rating_item.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // logo and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyHeading('Übersicht'),
              InkWell(
                onTap: () => pop(context),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          const VerticalSpacer(12),
          const CircularRating(rating: 3.4, totalRating: 21),
          const VerticalSpacer(32),

          // rating details
          const MyHeading('Details'),
          const VerticalSpacer(24),
          const RatingItem('Freundlichkeit', rating: 4),
          const VerticalSpacer(24),
          const RatingItem('Kompetenz', rating: 3),
          const VerticalSpacer(24),
          const RatingItem('Zuverlässigkeit', rating: 4),
          const VerticalSpacer(24),
          const RatingItem('Gründlichkeit', rating: 2),
          const VerticalSpacer(24),
          const RatingItem('Kommunikation', rating: 4),
        ],
      ),
    );
  }
}

void showRatingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const RatingDialog(),
      );
    },
  );
}
