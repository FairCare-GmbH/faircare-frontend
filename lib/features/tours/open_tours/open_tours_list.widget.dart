import 'package:faircare/features/tours/tour_list_item.widget.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../performance/tour_list_performance_display_type.enum.dart';
import 'open_tours.bloc.dart';

class OpenToursListWidget extends StatelessWidget {
  const OpenToursListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenToursBloc, OpenToursState>(
      builder: (context, state) {
        if (state is OpenToursLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (a, b) => const VerticalSpacer(10),
            itemCount: state.tours.length,
            itemBuilder: (_, i) {
              return TourListItemWidget(
                  tour: state.tours[i],
                  displayType: TourListPerformanceDisplayType.workTime,
                  refreshCallback:
                  () => BlocProvider.of<OpenToursBloc>(context).add(
                      GetOpenTours(
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
