import 'package:dio/dio.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/tour_details/tour_details.view.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../api/api_exception.dart';
import '../../widgets/snack_bar.dart';

class TourListItemWidget extends StatelessWidget {
  const TourListItemWidget(
    this.tour,
    this.refreshCallback, {
    Key? key,
  }) : super(key: key);

  final TourModel tour;
  final Function refreshCallback;

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
          color: MyColors.lightGrey,
        ),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                color: MyColors.prime,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: //model.fromDate.isSameDay(model.toDate)?
                    Text(
                  days[tour.dayOfWeek - 1].substring(0, 2),
                  style: style(
                    color: MyColors.white,
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
                      color: MyColors.prime,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const VerticalSpacer(2),
                  Text(
                    tourType[tour.type - 1],
                    style: style(
                      color: MyColors.darkGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalSpacer(12),
            Text(
              '${((tour.actualDurationMinutes ?? tour.plannedDurationMinutes) ~/ 60).toString().padLeft(1, '0')}h ${((tour.actualDurationMinutes ?? tour.plannedDurationMinutes) % 60).toString().padLeft(2, '0')}m',
              style: style(
                color: MyColors.darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
