import 'package:faircare/views/my_tours/tour_visit_item.widget.dart';
import 'package:faircare/views/my_tours/tour_details.bloc.dart';
import 'package:faircare/views/open_tours/open_tours.bloc.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/views/open_tours/tour_item.widget.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourVisitsListWidget extends StatelessWidget {
  final int tourId;

  const TourVisitsListWidget({required this.tourId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TourDetailsBloc()..add(GetTourDetails(tourId)),
      child: BlocBuilder<TourDetailsBloc, TourDetailsState>(
        builder: (context, state) {
          if (state is TourDetailsLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (a, b) => const VerticalSpacer(10),
              itemCount: state.visits.length,
              itemBuilder: (_, i) {
                return TourVisitItemWidget(state.visits[i].visit, state.visits[i].patient);
              },
            );
          }
          return const LoadingIndicator();
        },
      ),
    );
  }
}
