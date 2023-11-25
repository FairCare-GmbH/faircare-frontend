import 'package:faircare/features/my_tours/tours.bloc.dart';
import 'package:faircare/features/my_tours/tours_app_bar.widget.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/enums.dart';
import '../../widgets/heading.dart';
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
                      if (today.isNotEmpty) const MyHeading('Heute'),
                      if (today.isNotEmpty) const VerticalSpacer(12),
                      if (today.isNotEmpty)
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
                      if (releasing.isNotEmpty) const VerticalSpacer(32),
                      if (releasing.isNotEmpty) const MyHeading('In Abgabe'),
                      if (releasing.isNotEmpty) const VerticalSpacer(12),
                      if (releasing.isNotEmpty)
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
                      if (assigned.isNotEmpty) const VerticalSpacer(32),
                      if (assigned.isNotEmpty) const MyHeading('Meine Touren'),
                      if (assigned.isNotEmpty) const VerticalSpacer(12),
                      if (assigned.isNotEmpty)
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
