import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class AccountCreationDialog extends StatelessWidget {
  const AccountCreationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Account in Erstellung',
            style: style(
              fontSize: 20,
              color: MyColors.black,
            ),
          ),
          const VerticalSpacer(16),
          Text(
            'Vielen Dank, dass du dich bei uns an-gemeldet hast. Wir werden deine Angaben innerhalb von 24h prüfen und dich bzgl. deiner Anmeldedaten kontaktieren.',
            style: style(color: MyColors.darkGrey),
          ),
          const VerticalSpacer(16),
          Text.rich(
            TextSpan(
              text: 'Bei Fragen kannst du dich jederzeit hier melden: ',
              children: [
                TextSpan(
                  text: '089-2000 60201',
                  style: style(color: MyColors.prime),
                ),
              ],
            ),
            style: style(color: MyColors.darkGrey),
          ),
          const VerticalSpacer(20),
          Button(
            'Verstanden',
            width: 140,
            height: 40,
            textSize: 14,
            borderRadius: 32,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

void showAccountCreationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const AccountCreationDialog(),
      );
    },
  );
}
