import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tours/tour_list_item.widget.dart';
import 'completed_tours.bloc.dart';


class CompletedToursListWidget extends StatelessWidget {
  const CompletedToursListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedToursBloc, CompletedToursState>(
      builder: (context, state) {
        if (state is CompletedToursLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (a, b) => const VerticalSpacer(10),
            itemCount: state.tours.length,
            itemBuilder: (_, i) {
              return TourListItemWidget(
                  state.tours[i],
                  () => BlocProvider.of<CompletedToursBloc>(context).add(
                      GetCompletedTours(
                          from: state.from,
                          to: state.to,
                          searchType: state.searchType)));
            },
          );
        }
        return const LoadingIndicator();
      },
    );
  }
}
