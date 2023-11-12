import 'package:faircare/views/open_tours/open_tours.bloc.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/views/open_tours/tour_item.widget.dart';
import 'package:faircare/widgets/loading_indicator.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return TourItemWidget(
                  state.tours[i],
                  TourState.available,
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
