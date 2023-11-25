import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:faircare/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'reset_password_confirmation.dialog.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final emailController = TextEditingController();

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
                  horizontal: 16,
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

                    // email
                    MyTextField(
                      label: 'E-Mail',
                      hint: 'E-Mail',
                      controller: emailController,
                    ),
                    const VerticalSpacer(24),

                    // Reset password button
                    Button(
                      'Zurücksetzen',
                      onPressed: () {
                        showResetPasswordDialog(context);
                      },
                    ),
                    const VerticalSpacer(24),

                    // back to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Zurück zum ',
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
