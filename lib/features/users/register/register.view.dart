import 'package:faircare/features/users/register/pages/register_pages.widget.dart';
import 'package:faircare/features/users/register/widgets/next_button.widget.dart';
import 'package:faircare/features/users/register/widgets/page_progress.widget.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                  color: FCColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // logo
                    const AppLogo(),
                    const VerticalSpacer(24),

                    // pages
                    RegisterPagesWidget(pageController),
                    const VerticalSpacer(24),

                    // next button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: RegisterNextButtonWidget(pageController),
                    ),
                    const VerticalSpacer(16),

                    // progress
                    const RegisterPageProgressWidget(),
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
