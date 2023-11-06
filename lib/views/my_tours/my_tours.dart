import 'package:faircare/blocs/my_tours/assigned_tours/assigned_tours_bloc.dart';
import 'package:faircare/views/my_tours/app_bar.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/enums.dart';
import '../../widgets/loading_indicator.dart';
import '../available_tours/tour_item.dart';

class MyToursPage extends StatelessWidget {
  const MyToursPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyToursAppBar(),
        BlocProvider(
          create: (context) => AssignedToursBloc()..add(GetAssignedTours()),
          child: BlocBuilder<AssignedToursBloc, AssignedToursState>(
            builder: (context, state) {
              if (state is AssignedToursLoaded) {
                final releasing = state.tours.where((element) => element.isOpen).toList(growable: false);
                final assigned = state.tours.where((element) => !element.isOpen).toList(growable: false);

                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    children: [
                      // requested tours
                      const MyHeading('Abgabe'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: releasing.length,
                        itemBuilder: (_, i) {
                          return TourItem(releasing[i], TourState.requested);
                        },
                      ),
                      const VerticalSpacer(32),

                      // assigned tours
                      const MyHeading('Zugewiesen'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: assigned.length,
                        itemBuilder: (_, i) {
                          return TourItem(assigned[i], TourState.requested);
                        },
                      ),
                    ],
                  ),
                );
              }
              return const LoadingIndicator();
            },
          ),
        )
      ],
    );
  }
}
