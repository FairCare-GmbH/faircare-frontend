import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class GiveBackVacationDialog extends StatelessWidget {
  const GiveBackVacationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Urlaub zurückgeben?',
            style: style(
              fontSize: 20,
              color: FCColors.black,
            ),
          ),
          const VerticalSpacer(16),
          Text(
            'Hiermit gibst du deinen bestehenden Urlaub zurück. '
            'Die entsprechenden Tage können wieder für Touren '
            'freigegeben werden.',
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
                'Zurückgeben',
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

Future<bool?> showGiveBackVacationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const GiveBackVacationDialog(),
      );
    },
  );
}
