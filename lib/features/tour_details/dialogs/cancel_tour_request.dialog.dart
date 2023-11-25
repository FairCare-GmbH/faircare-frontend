import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class CancelTourRequestDialog extends StatelessWidget {
  const CancelTourRequestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Abgabe zurückziehen?',
            style: style(
              fontSize: 20,
              color: MyColors.black,
            ),
          ),
          const VerticalSpacer(16),
          Text(
            'Hiermit ziehst du die Abgabe zurück. Die Tour bleibt '
            'bei dir und muss weiter gefahren werden.',
            style: style(
              color: MyColors.darkGrey,
              height: 1.4,
            ),
          ),
          const VerticalSpacer(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyTextButton(
                'Abbrechen',
                onTap: () {},
              ),
              Button(
                'Zurückziehen',
                width: 140,
                height: 40,
                textSize: 14,
                borderRadius: 32,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

void showCancelRequestDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const CancelTourRequestDialog(),
      );
    },
  );
}
