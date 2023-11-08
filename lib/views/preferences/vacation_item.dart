import 'package:dio/dio.dart';
import 'package:faircare/blocs/preferences/vacation_requests/vacation_requests_bloc.dart';
import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/models/vacation_model.dart';
import 'package:faircare/views/preferences/dialogs/cancel_vacation_dialog.dart';
import 'package:faircare/views/preferences/dialogs/give_back_vacation_dialog.dart';
import 'package:faircare/views/vacation_details/vacation_details.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../widgets/snack_bar.dart';

class VacationItem extends StatelessWidget {
  const VacationItem(this.model, {Key? key}) : super(key: key);

  final VacationModel model;

  @override
  Widget build(BuildContext context) {
    bool isPast = model.fromDate.isBefore(DateTime.now());

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.border.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: getColor(isPast),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                getIcon(),
                size: 20,
                color: MyColors.white,
              ),
            ),
          ),
          const HorizontalSpacer(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormat('dd.MM.yyyy').format(model.fromDate)}'
                  '${!model.fromDate.isAtSameMomentAs(model.toDate) ? ''
                      ' - ${DateFormat('dd.MM.yyyy').format(model.toDate)}'
                      '' : ''}',
                  style: style(
                    color: getColor(isPast),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const VerticalSpacer(2),
                Text(
                  'Urlaub',
                  style: style(
                    color: MyColors.darkGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const HorizontalSpacer(12),
          InkWell(
            onTap: () => getAction(context),
            child: Icon(
              getActionIcon(isPast),
              color: getActionColor(isPast),
            ),
          ),
        ],
      ),
    );
  }

  void getAction(BuildContext context) {
    if (model.fromDate.isBefore(DateTime.now())) {
      navigate(context, const VacationDetailsPage());
    }
    showGiveBackVacationDialog(context).then((cancelVacation) {
      if (cancelVacation == true) {
        Api.request(
                '/preferences/${Api.getUser()!.id}/vacation-requests/${model.id}',
                options: Options(method: 'DELETE'))
            .then((value) {
          BlocProvider.of<VacationRequestsBloc>(context)
              .add(GetVacationRequests());
          showSnackBar(
            context,
            'Urlaub zurückgezogen',
            icon: Icons.save,
          );
        }).onError((error, stackTrace) {
          showSnackBar(
            context,
            'Problem beim zurückziehen des Urlaubs.',
            bgColor: MyColors.red,
            icon: Icons.error,
          );
          if (kDebugMode) {
            print(error);
            print(stackTrace);
          }
        });
      }
    });
  }

  IconData getIcon() {
    if (model.approvalStatus == 1) return Icons.check;
    return Icons.cached;
  }

  IconData getActionIcon(bool before) {
    if (model.approvalStatus == 3) {
      if (before) return Icons.chevron_right;
      return Icons.delete;
    }
    return Icons.close;
  }

  Color getColor(bool before) {
    if (model.approvalStatus == 3) {
      return MyColors.red;
    } else if (model.approvalStatus == 1) {
      return MyColors.green;
    } else {
      return MyColors.yellow;
    }
  }

  Color getActionColor(bool before) {
    if (model.approvalStatus == 3) {
      return MyColors.red;
    } else if (model.approvalStatus == 1) {
      return MyColors.green;
    } else {
      return MyColors.yellow;
    }
  }
}
