import 'package:faircare/blocs/user/user/user_bloc.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/views/rating_dialog/circular_rating.dart';
import 'package:faircare/views/rating_dialog/rating_item.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserDataLoaded) {
          final data = state.user;
          final average = (data.ratingVector1 +
                  data.ratingVector2 +
                  data.ratingVector3 +
                  data.ratingVector4 +
                  data.ratingVector5) /
              5;

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
                CircularRating(
                  rating: average,
                  totalRating: data.ratingCount,
                ),
                const VerticalSpacer(32),

                // rating details
                const MyHeading('Details'),
                const VerticalSpacer(24),
                RatingItem(
                  'Freundlichkeit',
                  rating: data.ratingVector1,
                ),
                const VerticalSpacer(24),
                RatingItem(
                  'Kompetenz',
                  rating: data.ratingVector2,
                ),
                const VerticalSpacer(24),
                RatingItem(
                  'Zuverlässigkeit',
                  rating: data.ratingVector3,
                ),
                const VerticalSpacer(24),
                RatingItem(
                  'Gründlichkeit',
                  rating: data.ratingVector4,
                ),
                const VerticalSpacer(24),
                RatingItem(
                  'Kommunikation',
                  rating: data.ratingVector5,
                ),
              ],
            ),
          );
        }
        return const LoadingIndicator();
      },
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
