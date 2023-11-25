import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/features/login/login.view.dart';
import 'package:faircare/features/getting_started/progress.widget.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

import 'pages.widget.dart';
import 'next_button.widget.dart';

class GettingStartedView extends StatefulWidget {
  const GettingStartedView({Key? key}) : super(key: key);

  @override
  State<GettingStartedView> createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  final pageController = PageController();

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
                            GettingStartedPagesWidget(pageController),
                            const VerticalSpacer(24),

                            // next
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: GettingStartedNextButtonWidget(pageController),
                            ),
                            const VerticalSpacer(16),

                            // progress
                            const GettingStartedPageProgress(),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacer(8),
                    InkWell(
                      onTap: () => navigateRemove(context, const LoginView()),
                      child: Text(
                        'Einführung überspringen',
                        style: style(color: MyColors.white),
                      ),
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
