import 'package:faircare/global/extensions.dart';
import 'package:faircare/views/my_tours/my_tours.bloc.dart';
import 'package:faircare/views/my_tours/my_tours_app_bar.widget.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/enums.dart';
import '../../widgets/loading_indicator.dart';
import '../open_tours/tour_list_item.widget.dart';

class MyToursView extends StatelessWidget {
  const MyToursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MyToursAppBarWidget(),
        BlocProvider(
          create: (context) => MyToursBloc()..add(GetMyTours()),
          child: BlocBuilder<MyToursBloc, MyToursState>(
            builder: (context, state) {
              if (state is MyToursLoaded) {
                final today = state.tours
                    .where((element) => element.tourDate.isToday)
                    .toList(growable: false);
                final releasing = state.tours
                    .where((element) =>
                        element.isOpen && !element.tourDate.isToday)
                    .toList(growable: false);
                final assigned = state.tours
                    .where((element) =>
                        !element.isOpen && !element.tourDate.isToday)
                    .toList(growable: false);

                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    children: [
                      const MyHeading('Heute'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: today.length,
                        itemBuilder: (_, i) {
                          return TourListItemWidget(
                              today[i],
                              () => BlocProvider.of<MyToursBloc>(context)
                                  .add(GetMyTours()));
                        },
                      ),
                      const VerticalSpacer(32),

                      // requested tours
                      const MyHeading('In Abgabe'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: releasing.length,
                        itemBuilder: (_, i) {
                          return TourListItemWidget(
                              releasing[i],
                              () => BlocProvider.of<MyToursBloc>(context)
                                  .add(GetMyTours()));
                        },
                      ),
                      const VerticalSpacer(32),

                      // assigned tours
                      const MyHeading('Meine Touren'),
                      const VerticalSpacer(12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (a, b) => const VerticalSpacer(10),
                        itemCount: assigned.length,
                        itemBuilder: (_, i) {
                          return TourListItemWidget(
                              assigned[i],
                              () => BlocProvider.of<MyToursBloc>(context)
                                  .add(GetMyTours()));
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
