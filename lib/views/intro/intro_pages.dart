import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/views/intro/intro_details_page.dart';
import 'package:faircare/views/intro/intro_page_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntroPages extends StatelessWidget {
  const IntroPages(this.controller, {Key? key}) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          IntroFirstPage(),
          IntroDetailsPage(
            icon: 'flexible',
            title: 'Mehr Flexibilität',
            subtitle: 'Arbeite so oft und so lange du willst',
            text1: 'Sag uns, wie viel du arbeiten möchtest',
            text2: 'Sag uns, wann du arbeiten möchtest',
            image1: 'intro_11',
            image2: 'intro_12',
            imageSize1: 50,
            imageSize2: 230,
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
        onPageChanged: (v) {
          BlocProvider.of<IntroProgressCubit>(context).setPage(v);
        },
      ),
    );
  }
}
