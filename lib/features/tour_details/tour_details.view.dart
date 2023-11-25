import 'package:faircare/features/tour_details/tour_details_app_bar.widget.dart';
import 'package:faircare/features/tour_details/tour_map.widget.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../my_tours/tour_details.bloc.dart';
import '../my_tours/tour_visits_list.widget.dart';
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
              ToursDetailsAppBarWidget(
                  title:
                      'F${tour.tourDate.year}${tour.tourDate.month}${tour.tourDate.day}-${tour.id}'),
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
                    HorizontalTile(
                      'Start/Ende',
                      mainText:
                          '${tour.actualDurationMinutes != null ? ' / ' : ''}'
                          '${tour.plannedStartTime.substring(0, 5)} - ${tour.plannedEndTime.substring(0, 5)}',
                      secondaryText: tour.actualDurationMinutes != null
                          ? '${tour.actualStartTime?.substring(0, 5)} - ${tour.actualEndTime?.substring(0, 5)}'
                          : '',
                      secondaryColor: tour.plannedDurationMinutes >=
                              (tour.actualDurationMinutes ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                    HorizontalTile(
                      'Pflegezeit',
                      mainText:
                          '${tour.actualDurationMinutes != null ? ' / ' : ''}'
                          '${(tour.plannedCareDuration ~/ 3600).toString().padLeft(1, '0')}h ${((tour.plannedCareDuration % 3600) ~/ 60).toString().padLeft(2, '0')}m',
                      secondaryText: tour.actualDurationMinutes != null
                          ? '${(tour.actualCareDuration! ~/ 3600).toString().padLeft(1, '0')}h ${((tour.actualCareDuration! % 3600) ~/ 60).toString().padLeft(2, '0')}m'
                          : '',
                      secondaryColor: tour.plannedCareDuration <=
                              (tour.actualCareDuration ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                    HorizontalTile(
                      'Fahrtzeit',
                      mainText:
                          '${tour.actualDurationMinutes != null ? ' / ' : ''}'
                          '${(tour.plannedCommuteDuration ~/ 3600).toString().padLeft(1, '0')}h ${((tour.plannedCommuteDuration % 3600) ~/ 60).toString().padLeft(2, '0')}m',
                      secondaryText: tour.actualDurationMinutes != null
                          ? '${(tour.actualCommuteDuration! ~/ 3600).toString().padLeft(1, '0')}h ${((tour.actualCommuteDuration! % 3600) ~/ 60).toString().padLeft(2, '0')}m'
                          : '',
                      secondaryColor: tour.plannedCommuteDuration <=
                              (tour.actualCommuteDuration ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                    HorizontalTile(
                      'Vergütung',
                      mainText: '${tour.myActualWageCents != null ? ' / ' : ''}'
                          '${(tour.myPlannedWageCents / 100).toStringAsFixed(2)} €',
                      secondaryText: tour.actualDurationMinutes != null
                          ? '${(tour.myActualWageCents! / 100).toStringAsFixed(2)} €'
                          : '',
                      secondaryColor: tour.myPlannedWageCents <=
                              (tour.myActualWageCents ?? 0)
                          ? MyColors.green
                          : MyColors.red,
                    ),

                    // HorizontalTile(
                    //   'Bonus',
                    //   mainText: '',
                    //   secondaryText:
                    //       '${tour.bonus > 0 ? '+' : ''} ${((tour.bonus) / 100).toStringAsFixed(2)} €',
                    //   secondaryColor: tour.plannedDurationMinutes >=
                    //           (tour.actualDurationMinutes ?? 0)
                    //       ? (tour.bonus > 0 ? MyColors.green : MyColors.prime)
                    //       : MyColors.red,
                    // ),

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
                      TourVisitsListWidget(tourId: tour.id),

                    const VerticalSpacer(12),

                    if (tour.tourDate.isInFuture &&
                        tour.isOpen &&
                        tour.ownerNurseId != Api.getUser()!.id)
                      Button(
                        'Anfragen',
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
                        buttonColor: MyColors.red,
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
