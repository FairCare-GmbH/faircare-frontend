import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class GettingStartedPage1Widget extends StatelessWidget {
  const GettingStartedPage1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogo(),
          const VerticalSpacer(32),
          Text(
            'Herzlich Willkommen',
            style: style(
              color: MyColors.prime,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const VerticalSpacer(20),
          Text(
            'Du als Pflegekraft bist für uns das wertvollste Gut - '
            'für dich entwickeln wir unsere App!\n\n'
            'Unser Ziel ist es, deine Arbeitsbedingungen '
            ' zu verbessern und den Pflegeberuf wieder '
            'attraktiv zu machen.\n\n'
            'Denn nur mit zufriedenen Pflegekräften geht es '
            'den Patienten auch gut.',
            textAlign: TextAlign.center,
            style: style(fontSize: 15),
          ),
          const VerticalSpacer(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/icons/flexible.png', width: 60),
              Image.asset('assets/icons/determine.png', width: 60),
              Image.asset('assets/icons/salary.png', width: 60),
            ],
          )
        ],
      ),
    );
  }
}
