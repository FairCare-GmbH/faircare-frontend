import 'package:faircare/features/performance/measurable_details.widget.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:faircare/features/tours/tour_details/tour_details_app_bar.widget.dart';
import 'package:faircare/features/tours/tour_details/tour_map.widget.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api.dart';
import '../../../global/fc_colors.dart';
import '../../performance/tour_list_performance_display_type.enum.dart';
import '../tour_details.bloc.dart';
import '../tour_visits_list.widget.dart';
import 'dialogs/cancel_give_back_request.dialog.dart';
import 'dialogs/give_back_tour.dialog.dart';
import 'dialogs/request_tour.dialog.dart';

class TourDetailsView extends StatelessWidget {
  const TourDetailsView(
    this.tour, {
    Key? key,
  }) : super(key: key);

  final TourModel tour;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TourDetailsBloc()..add(GetTourDetails(tour.id)),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              ToursDetailsAppBarWidget(title: tour.name),
              // overview

              BlocBuilder<TourDetailsBloc, TourDetailsState>(
                  builder: (context, state) => state is! TourDetailsLoaded
                      ? TourMapWidget(tour: tour)
                      : TourMapWidget(tour: tour, visits: state.visits)),

              const VerticalSpacer(2),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  children: [
                    // planning
                    const MyHeading('Planung'),
                    const VerticalSpacer(12),

                    // start and end time
                    MeasurableDetailsWidget(
                      measurable: tour,
                    ),

                    // HorizontalTile(
                    //   'Vergütung',
                    //   mainText:
                    //   '${state == TourState.completed ? ' / ' : ''}'
                    //       '${(((model.myPlannedWageCents ?? 0) + model.bonus) / 100).toStringAsFixed(2)} €',
                    //   secondaryText:
                    //       '${(((model.myActualWageCents ?? 0) + model.bonus) / 100).toStringAsFixed(2)} €',
                    //   secondaryColor: model.plannedDurationMinutes >=
                    //           (model.actualDurationMinutes ?? 0)
                    //       ? MyColors.green
                    //       : MyColors.red,
                    // ),
                    //
                    // // hourly rate
                    // HorizontalTile(
                    //   'Stundenlohn',
                    //   mainText: '${state == TourState.completed ? ' / ' : ''}'
                    //       '${(((model.myPlannedWageCents ?? 0) / (model.plannedDurationMinutes / 60)) / 100).toStringAsFixed(2)} €',
                    //   secondaryText: state == TourState.completed
                    //       ? '${(((model.myActualWageCents ?? 0) / ((model.actualDurationMinutes ?? 0) / 60)) / 100).toStringAsFixed(2)} €'
                    //       : '',
                    //   secondaryColor: model.plannedDurationMinutes >=
                    //           (model.actualDurationMinutes ?? 0)
                    //       ? MyColors.green
                    //       : MyColors.red,
                    // ),
                    const VerticalSpacer(24),

                    // details
                    const MyHeading('Details'),
                    const VerticalSpacer(12),
                    MySwitch(
                      'Hauswirtschaft',
                      value: tour.hasHousekeeping,
                      absorb: true,
                    ),
                    MySwitch(
                      'Wundversorgung',
                      value: tour.hasWoundCare,
                      absorb: true,
                    ),
                    MySwitch(
                      'Grundpflege',
                      value: tour.hasBasicCare,
                      absorb: true,
                    ),
                    MySwitch(
                      'Behandlungspflege',
                      value: tour.hasMedicalCare,
                      absorb: true,
                    ),
                    MySwitch(
                      'Betreuung',
                      value: tour.hasCompanionship,
                      absorb: true,
                    ),
                    MySwitch(
                      'Infektionskrankheiten',
                      value: tour.hasInfectiousDisease,
                      absorb: true,
                    ),
                    const VerticalSpacer(12),

                    if (tour.ownerNurseId == Api.getUser()!.id)
                      const MyHeading('Einsätze'),
                    if (tour.ownerNurseId == Api.getUser()!.id)
                      const VerticalSpacer(12),
                    if (tour.ownerNurseId == Api.getUser()!.id)
                      TourVisitsListWidget(
                        tourId: tour.id,
                        displayType: tour.isClosed
                            ? null
                            : TourListPerformanceDisplayType.workTime,
                      ),

                    const VerticalSpacer(12),

                    if (tour.tourDate.isInFuture &&
                        tour.isOpen &&
                        tour.ownerNurseId != Api.getUser()!.id)
                      Button(
                        'Anfordern',
                        onPressed: () {
                          showRequestDialog(context).then((value) {
                            if (value == true) {
                              Navigator.pop(context, TourState.requested);
                            }
                          });
                        },
                      ),
                    if (tour.tourDate.isInFuture &&
                        !tour.isOpen &&
                        tour.ownerNurseId == Api.getUser()!.id)
                      Button(
                        'Abgeben',
                        onPressed: () {
                          showGiveBackDialog(context).then((value) {
                            if (value == true) {
                              Navigator.pop(context, TourState.givenBack);
                            }
                          });
                        },
                      ),
                    if (tour.tourDate.isInFuture &&
                        tour.isOpen &&
                        tour.ownerNurseId == Api.getUser()!.id)
                      Button(
                        'Abgabe abbrechen',
                        buttonColor: FCColors.red,
                        onPressed: () {
                          showCancelGiveBackDialog(context).then((value) {
                            if (value == true) {
                              Navigator.pop(context, TourState.assigned);
                            }
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
