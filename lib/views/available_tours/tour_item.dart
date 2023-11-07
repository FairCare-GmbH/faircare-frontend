import 'package:faircare/global/colors.dart';
import 'package:faircare/global/constants.dart';
import 'package:faircare/global/enums.dart';
import 'package:faircare/global/extensions.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/tour_details/tour_details.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TourItem extends StatelessWidget {
  const TourItem(
    this.model,
    this.state, {
    Key? key,
  }) : super(key: key);

  final TourModel model;
  final TourState state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context, TourDetailsPage(model, state));
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
              decoration: BoxDecoration(
                color: model.bonus > 0 ? MyColors.yellow : MyColors.prime,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: model.fromDate.isSameDay(model.toDate)
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
                    model.fromDate.isSameDay(model.toDate)
                        ? DateFormat('dd.MM.yyyy').format(model.fromDate)
                        : '${days[model.dayOfWeek]}s',
                    style: style(
                      color: model.bonus > 0 ? MyColors.yellow : MyColors.prime,
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
            const HorizontalSpacer(12),
            Text(
              '${model.revenue + model.bonus} €',
              style: style(
                color: model.bonus > 0 ? MyColors.yellow : MyColors.darkGrey,
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
