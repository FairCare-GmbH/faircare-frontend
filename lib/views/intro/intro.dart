import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/intro/intro_pages.dart';
import 'package:faircare/views/intro/next_button.dart';
import 'package:faircare/views/intro/page_progress.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
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
                            IntroPages(pageController),
                            const VerticalSpacer(24),

                            // next
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: IntroNextButton(pageController),
                            ),
                            const VerticalSpacer(16),

                            // progress
                            const IntroPageProgress(),
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpacer(8),
                    InkWell(
                      onTap: () => navigateRemove(context, const LoginPage()),
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
