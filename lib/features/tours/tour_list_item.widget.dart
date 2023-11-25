import 'package:dio/dio.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import '../../widgets/snack_bar.dart';
import 'tour_details/tour_details.view.dart';

class TourListItemWidget extends StatelessWidget {
  const TourListItemWidget({
    required this.tour,
    required this.refreshCallback,
    this.displayType = 't',
    Key? key,
  }) : super(key: key);

  final TourModel tour;
  final Function refreshCallback;
  final String
      displayType; // '' = nothing, '€' = revenue, 't' = time, '%' = percent complete, '>' = chevron

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate<TourState?>(context, TourDetailsView(tour)).then((value) {
          if (value is TourState) {
            String snackMessage, endpoint;
            if (value == TourState.requested) {
              endpoint = 'request';
              snackMessage = 'Tour erfolgreich beantragt.';
            } else if (value == TourState.givenBack) {
              endpoint = 'release';
              snackMessage = 'Tour ist in Abgabe.';
            } else if (value == TourState.assigned) {
              //TODO handle give-back request cancelled
              endpoint = 'request';
              snackMessage = 'Abgabe abgebrochen.';
            } else {
              return;
            }

            Api.request('/tours/${tour.id}/$endpoint',
                    options: Options(method: 'POST'))
                .then((value) {
              showSnackBar(
                context,
                snackMessage,
                icon: Icons.save,
              );
              refreshCallback();
            }).onError((error, stackTrace) {
              if (error is ApiException) {
                error.showDialog(context);
              } else if (kDebugMode) {
                print(error);
                print(stackTrace);
              }
            });
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: FCColors.lightGrey,
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: FCColors.prime,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: //model.fromDate.isSameDay(model.toDate)?
                    Text(
                  days[tour.dayOfWeek - 1].substring(0, 2),
                  style: style(
                    color: FCColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // : const Icon(
                //     Icons.all_inclusive,
                //     color: MyColors.white,
                //     size: 18,
                //   ),
              ),
            ),
            const HorizontalSpacer(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // model.fromDate.isSameDay(model.toDate)
                    DateFormat('dd.MM.yyyy').format(tour.tourDate),
                    //: '${days[model.dayOfWeek]}s',
                    style: style(
                      color: FCColors.prime,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const VerticalSpacer(2),
                  Text(
                    tourType[tour.type - 1],
                    style: style(
                      color: FCColors.darkGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalSpacer(12),
            if (displayType == 't')
              Text(
                '${((tour.actualDurationMinutes ?? tour.plannedDurationMinutes) ~/ 60).toString().padLeft(1, '0')}h ${((tour.actualDurationMinutes ?? tour.plannedDurationMinutes) % 60).toString().padLeft(2, '0')}m',
                style: style(
                  color: FCColors.darkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            if (displayType == '€')
              Text(
                '${((tour.myActualWageCents ?? tour.myPlannedWageCents) / 100).toStringAsFixed(2)} €',
                style: style(
                  color: FCColors.darkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            if (displayType == '>') const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
