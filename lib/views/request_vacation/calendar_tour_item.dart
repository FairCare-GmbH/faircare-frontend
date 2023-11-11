import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/preference.model.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarTourItem extends StatelessWidget {
  const CalendarTourItem(
    this.model,
    this.state, {
    Key? key,
  }) : super(key: key);

  final PreferenceModel model;
  final TourState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () { //TODO load tour details from api
      //   navigate<TourState?>(context, TourDetailsPage(model, state))
      //       .then((value) {
      //     if (value is TourState) {
      //       String snackMessage, endpoint;
      //       int nurseId;
      //       if (value == TourState.requested) {
      //         //TODO handle request
      //         endpoint = 'request';
      //         snackMessage = 'Tour erfolgreich beantragt.';
      //         nurseId = Api.getUser()!.id;
      //       } else if (value == TourState.givenBack) {
      //         //TODO handle give back
      //         endpoint = 'release';
      //         snackMessage = 'Tour ist in Abgabe.';
      //         nurseId = 0;
      //       } else if (value == TourState.assigned) {
      //         //TODO handle give-back request cancelled
      //         endpoint = 'request';
      //         snackMessage = 'Abgabe abgebrochen.';
      //         nurseId = Api.getUser()!.id;
      //       } else {
      //         return;
      //       }
      //
      //       Api.request('/tour-plans/${model.id}/$endpoint',
      //               options: Options(method: 'POST'))
      //           .then((value) {
      //         showSnackBar(
      //           context,
      //           snackMessage,
      //           icon: Icons.save,
      //         );
      //       }).onError((error, stackTrace) {
      //         if (error is ApiException) {
      //           error.showDialog(context);
      //         } else if (kDebugMode) {
      //           print(error);
      //           print(stackTrace);
      //         }
      //       });
      //     }
      //   });
      //},
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
                child: model.startDate.isSameDay(model.endDate)
                    ? Text(
                        '1x',
                        style: style(
                          color: MyColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const Icon(
                        Icons.all_inclusive,
                        color: MyColors.white,
                        size: 18,
                      ),
              ),
            ),
            const HorizontalSpacer(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.startDate.isSameDay(model.endDate)
                        ? DateFormat('dd.MM.yyyy').format(model.startDate)
                        : '${days[model.dayOfWeek]}s',
                    style: style(
                      color: MyColors.prime,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const VerticalSpacer(2),
                  Text(
                    tourType[model.type - 1],
                    style: style(
                      color: MyColors.darkGrey,
                      fontSize: 13,
                    ),
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
