import 'package:faircare/features/users/user_bloc.dart';
import 'package:faircare/features/ratings/rating_item.widget.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'circular_rating.widget.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context).add(GetUserData());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserDataLoaded) {
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
                CircularRatingWidget(
                  rating: state.ratings.getAverageRating(),
                  totalRating: state.ratings.ratingsCount ?? 0,
                ),
                const VerticalSpacer(32),

                // rating details
                const MyHeading('Details'),
                const VerticalSpacer(24),
                RatingItemWidget(
                  'Freundlichkeit',
                  rating: state.ratings.ratingVector1 ?? 0,
                ),
                const VerticalSpacer(24),
                RatingItemWidget(
                  'Kompetenz',
                  rating: state.ratings.ratingVector2 ?? 0,
                ),
                const VerticalSpacer(24),
                RatingItemWidget(
                  'Zuverlässigkeit',
                  rating: state.ratings.ratingVector3 ?? 0,
                ),
                const VerticalSpacer(24),
                RatingItemWidget(
                  'Gründlichkeit',
                  rating: state.ratings.ratingVector4 ?? 0,
                ),
                const VerticalSpacer(24),
                RatingItemWidget(
                  'Kommunikation',
                  rating: state.ratings.ratingVector5 ?? 0,
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
