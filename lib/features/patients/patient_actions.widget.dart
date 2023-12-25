import 'package:faircare/features/patients/patient.model.dart';
import 'package:flutter/cupertino.dart';

import '../../global/fc_colors.dart';
import '../../widgets/button.dart';
import '../../widgets/spacer.dart';
import '../ratings/new_rating.dialog.dart';

class PatientActionsWidget extends StatelessWidget {
  final PatientModel patient;

  const PatientActionsWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Button(
        'Bewertung Abgeben',
        buttonColor: FCColors.green,
        onPressed: () {
          showNewRatingDialog(context, patient.id);
        },
      ),
      const VerticalSpacer(8),
      Button(
        'Wunschzeiten Anpassen',
        buttonColor: FCColors.prime,
        onPressed: () {},
      ),
      const VerticalSpacer(8),
      Button(
        'Leistungen Anpassen',
        buttonColor: FCColors.orange,
        onPressed: () {},
      ),
      const VerticalSpacer(8),
      Button('Verordnung Hochladen',
          buttonColor: FCColors.yellow, onPressed: () {}),
    ]);
  }
}
