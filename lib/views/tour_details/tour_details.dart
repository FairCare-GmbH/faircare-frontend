import 'package:faircare/global/colors.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/tour_details/app_bar.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/cancel_request_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/give_back_dialog.dart';
import 'package:faircare/views/tour_details/dialogs/request_dialog.dart';
import 'package:faircare/views/tour_details/tour_map.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/heading.dart';
import 'package:faircare/widgets/horizontal_tile.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/switch.dart';
import 'package:flutter/material.dart';

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
    final plannedFromTime = model.plannedFromTime.time;
    final plannedToTime = model.plannedToTime.time;
    final actualFromTime = model.actualFromTime.time;
    final actualToTime = model.actualToTime.time;

    final plannedTime = plannedToTime.hour * 60 +
        plannedToTime.minute -
        plannedFromTime.hour * 60 +
        plannedFromTime.minute;

    final actualTime = actualToTime.hour * 60 +
        actualToTime.minute -
        actualFromTime.hour * 60 +
        actualFromTime.minute;

    final plannedHourlyRate =
        (model.revenue + model.bonus) / (plannedTime / 60);
    final actualHourlyRate = (model.revenue + model.bonus) / (actualTime / 60);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ToursDetailsAppBar(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                children: [
                  // overview
                  const MyHeading('Übersicht'),
                  const VerticalSpacer(12),
                  TourMap(model),
                  const VerticalSpacer(12),
                  const VerticalSpacer(24),

                  // planning
                  const MyHeading('Planung'),
                  const VerticalSpacer(12),

                  // start and end time
                  HorizontalTile(
                    'Start/Ende',
                    mainText: '${state == TourState.completed ? ' / ' : ''}'
                        '${model.plannedFromTime} - ${model.plannedToTime}',
                    secondaryText: state == TourState.completed
                        ? '${model.actualFromTime} - ${model.actualToTime}'
                        : '',
                    secondaryColor: plannedTime >= actualTime
                        ? MyColors.green
                        : MyColors.red,
                  ),

                  // revenue
                  HorizontalTile(
                    'Vergütung',
                    mainText: '${model.revenue + model.bonus} €',
                  ),

                  // hourly rate
                  HorizontalTile(
                    'Geschätzter Stundenlohn',
                    mainText: '${state == TourState.completed ? ' / ' : ''}'
                        '${plannedHourlyRate.toStringAsFixed(2)}',
                    secondaryText: state == TourState.completed
                        ? actualHourlyRate.toStringAsFixed(2)
                        : '',
                    secondaryColor: plannedTime >= actualTime
                        ? MyColors.green
                        : MyColors.red,
                  ),
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
                    'Infektionskrankheiten',
                    value: model.hasInfectiousDisease,
                    absorb: true,
                  ),
                  const VerticalSpacer(12),

                  if (state == TourState.available)
                    Button(
                      'Anfragen',
                      onPressed: () {
                        showRequestDialog(context);
                      },
                    ),
                  if (state == TourState.requested)
                    Button(
                      'Zurückziehen',
                      onPressed: () {
                        showCancelRequestDialog(context);
                      },
                    ),
                  if (state == TourState.assigned)
                    Button(
                      'Abgeben',
                      onPressed: () {
                        showGiveBackDialog(context);
                      },
                    ),
                  if (state == TourState.givenBack)
                    Button(
                      'Abgabe abbrechen',
                      buttonColor: MyColors.red,
                      onPressed: () {
                        showCancelGiveBackDialog(context);
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
