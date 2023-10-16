import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/register/next_button.dart';
import 'package:faircare/views/register/page_progress.dart';
import 'package:faircare/views/register/register_pages.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            Center(
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
                    // logo
                    const AppLogo(),
                    const VerticalSpacer(24),

                    // pages
                    RegisterPages(pageController),
                    const VerticalSpacer(24),

                    // next button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RegisterNextButton(pageController),
                    ),
                    const VerticalSpacer(16),

                    // progress
                    const RegisterPageProgress(),
                    const VerticalSpacer(24),

                    // login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ein Account vorhanden? ',
                          style: style(fontSize: 14),
                        ),
                        MyTextButton(
                          'Login',
                          onTap: () {
                            pop(context);
                          },
                        ),
                      ],
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
