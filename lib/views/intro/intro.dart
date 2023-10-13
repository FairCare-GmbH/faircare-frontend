import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/intro/intro_details_page.dart';
import 'package:faircare/views/intro/intro_page_1.dart';
import 'package:faircare/views/intro/page_progress.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // pages
                            Flexible(
                              child: PageView(
                                children: const [
                                  IntroFirstPage(),
                                  IntroDetailsPage(
                                    icon: 'flexible',
                                    title: 'Mehr Flexibilität',
                                    subtitle:
                                        'Arbeite so oft und so lange du willst',
                                    text1:
                                        'Sag uns, wie viel du arbeiten möchtest',
                                    text2: 'Sag uns, wann du arbeiten möchtest',
                                    image1: 'intro_11',
                                    image2: 'intro_12',
                                    imageSize1: 50,
                                    imageSize2: 240,
                                  ),
                                  IntroDetailsPage(
                                    icon: 'determine',
                                    title: 'Mehr Selbstbestimmung',
                                    subtitle: 'Pflege so wie du es möchtest',
                                    text1: 'Such dir deine Touren selbst aus',
                                    text2:
                                        'Wir bezahlen dich dabei nach den  erbrachten Leistungskomplexen - egal wie viel Zeit du dir dabei nehmen möchtest',
                                    image1: 'intro_21',
                                    image2: 'intro_22',
                                    imageSize1: 170,
                                    imageSize2: 70,
                                  ),
                                  IntroDetailsPage(
                                    icon: 'salary',
                                    title: 'Mehr Einkommen',
                                    subtitle: 'Bekomme bis zu 25% mehr Geld',
                                    text1:
                                        'Du hast volle Tansparenz über deine Einnahmen und deinen Stundenlohn',
                                    text2:
                                        'Bei uns kannst du bis zu 25% mehr verdienen, als bei anderen Pflegediensten. Garantiert nicht weniger.',
                                    image1: 'intro_31',
                                    image2: '',
                                    imageSize1: 240,
                                    imageSize2: 0,
                                  ),
                                ],
                              ),
                            ),
                            const VerticalSpacer(24),

                            // next
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Button(
                                'Weiter',
                                onPressed: () {},
                              ),
                            ),
                            const VerticalSpacer(16),

                            // progress
                            const IntroPageProgress(),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacer(8),
                    Text(
                      'Einführung überspringen',
                      style: style(color: MyColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
