import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class GettingStartedPageWidget extends StatelessWidget {
  const GettingStartedPageWidget({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.text1,
    required this.text2,
    required this.image1,
    required this.image2,
    required this.imageSize1,
    required this.imageSize2,
    Key? key,
  }) : super(key: key);

  final String icon;
  final String title, subtitle;
  final String text1, text2;
  final String image1, image2;
  final double imageSize1, imageSize2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Image.asset(
            'assets/icons/$icon.png',
            width: 40,
            height: 40,
          ),
          const VerticalSpacer(6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: style(
              color: FCColors.prime,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const VerticalSpacer(2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: style(color: FCColors.darkGrey, fontWeight: FontWeight.w500),
          ),
          const VerticalSpacer(20),
          Text(
            text1,
            textAlign: TextAlign.center,
            style: style(color: FCColors.darkGrey),
          ),
          const VerticalSpacer(20),
          Image.asset('assets/images/$image1.png', height: imageSize1),
          const VerticalSpacer(20),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: style(color: FCColors.darkGrey),
          ),
          if (image2 != '') ...[
            const VerticalSpacer(20),
            Image.asset('assets/images/$image2.png', height: imageSize2),
          ]
        ],
      ),
    );
  }
}
