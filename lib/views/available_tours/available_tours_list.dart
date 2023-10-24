import 'package:faircare/blocs/available_tours/available_tours/available_tours_bloc.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/views/available_tours/tour_item.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableToursList extends StatelessWidget {
  const AvailableToursList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableToursBloc, AvailableToursState>(
      builder: (context, state) {
        if (state is AvailableToursLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (a, b) => const VerticalSpacer(10),
            itemCount: state.tours.length,
            itemBuilder: (_, i) {
              return TourItem(state.tours[i], TourState.available);
            },
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
