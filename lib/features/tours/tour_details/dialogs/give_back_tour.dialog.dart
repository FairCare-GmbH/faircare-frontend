import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class GiveBackTourDialog extends StatelessWidget {
  const GiveBackTourDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tour abgeben?',
            style: style(
              fontSize: 20,
              color: FCColors.black,
            ),
          ),
          const VerticalSpacer(16),
          Text.rich(
            TextSpan(
              text: '',
              children: [
                TextSpan(
                  text: 'Hinweis: ',
                  style: style(
                    color: FCColors.darkGrey,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: 'Bis zur Umplanung der Tour durch FairCare, '
                      'muss sie weiter gefahren werden.\n\n',
                  style: style(color: FCColors.darkGrey, height: 1.4),
                ),
                TextSpan(
                  text: 'In dringenden Fällen oder bei Fragen, stehen wir dir '
                      'unter der',
                  style: style(color: FCColors.darkGrey, height: 1.4),
                ),
                TextSpan(
                  text: ' 089-2000 60201 ',
                  style: style(height: 1.4, color: FCColors.prime),
                ),
                TextSpan(
                  text: 'jederzeit zur Verfügung.',
                  style: style(color: FCColors.darkGrey, height: 1.4),
                ),
              ],
            ),
            style: style(
              color: FCColors.darkGrey,
              height: 1.4,
            ),
          ),
          const VerticalSpacer(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextButton(
                'Abbrechen',
                onTap: () {
                  Navigator.pop(context, false);
                },
              ),
              Button(
                'Abgeben',
                width: 140,
                height: 40,
                textSize: 14,
                borderRadius: 32,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<bool?> showGiveBackDialog(BuildContext context) {
  return showDialog<bool?>(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const GiveBackTourDialog(),
      );
    },
  );
}
