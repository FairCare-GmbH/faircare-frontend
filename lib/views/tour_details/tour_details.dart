import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/my_tours/tour_visits_list.widget.dart';
import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/request_dialog.dart';
import 'package:faircare/views/tour_details/tour_map.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';

class TourDetailsPage extends StatelessWidget {
  const TourDetailsPage(
    this.model,
    this.state, {
    Key? key,
  }) : super(key: key);

  final TourModel model;
  final TourState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ToursDetailsAppBar(
                title:
                    'F${model.tourDate.year}${model.tourDate.month}${model.tourDate.day}-${model.id}'),
            // overview

            TourMap(model),
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
                    mainText: '${state == TourState.completed ? ' / ' : ''}'
                        '${model.plannedStartTime.substring(0, 5)} - ${model.plannedEndTime.substring(0, 5)}',
                    secondaryText: state == TourState.completed
                        ? '${model.actualStartTime?.substring(0, 5)} - ${model.actualEndTime?.substring(0, 5)}'
                        : '',
                    secondaryColor: model.plannedDurationMinutes >=
                            (model.actualDurationMinutes ?? 0)
                        ? MyColors.green
                        : MyColors.red,
                  ),

                  HorizontalTile(
                    'Vergütung',
                    mainText:
                        '${((model.myActualWageCents ?? 0) / 100).toStringAsFixed(2)} €',
                  ),

                  HorizontalTile(
                    'Bonus',
                    mainText: '',
                    secondaryText:
                        '${model.bonus > 0 ? '+' : ''} ${((model.bonus) / 100).toStringAsFixed(2)} €',
                    secondaryColor: model.plannedDurationMinutes >=
                            (model.actualDurationMinutes ?? 0)
                        ? (model.bonus > 0 ? MyColors.green : MyColors.prime)
                        : MyColors.red,
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
                    value: model.hasHousekeeping,
                    absorb: true,
                  ),
                  MySwitch(
                    'Wundversorgung',
                    value: model.hasWoundCare,
                    absorb: true,
                  ),
                  MySwitch(
                    'Grundpflege',
                    value: model.hasBasicCare,
                    absorb: true,
                  ),
                  MySwitch(
                    'Behandlungspflege',
                    value: model.hasMedicalCare,
                    absorb: true,
                  ),
                  MySwitch(
                    'Betreuung',
                    value: model.hasCompanionship,
                    absorb: true,
                  ),
                  MySwitch(
                    'Infektionskrankheiten',
                    value: model.hasInfectiousDisease,
                    absorb: true,
                  ),
                  const VerticalSpacer(12),

                  if (model.ownerNurseId == Api.getUser()!.id)
                    TourVisitsListWidget(tourId: model.id),

                  const VerticalSpacer(12),

                  if (model.tourDate.isInFuture &&
                      model.isOpen &&
                      model.ownerNurseId != Api.getUser()!.id)
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
                  if (model.tourDate.isInFuture &&
                      !model.isOpen &&
                      model.ownerNurseId == Api.getUser()!.id)
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
                  if (model.tourDate.isInFuture &&
                      model.isOpen &&
                      model.ownerNurseId == Api.getUser()!.id)
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
    );
  }
}
