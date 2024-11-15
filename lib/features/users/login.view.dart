import 'package:faircare/api/api.dart';
import 'package:faircare/api/api_exception.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/checkbox_tile.dart';
import 'package:faircare/widgets/icon.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:faircare/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../navigation/navigation.view.dart';
import 'register/register.view.dart';
import 'reset_password/reset_password.view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  color: FCColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListView(
                  shrinkWrap: true,
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

                    // password
                    MyTextField(
                      label: 'Passwort',
                      hint: 'Passwort',
                      obscure: true,
                      controller: passwordController,
                      suffixWidget: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            icon: 'hide',
                            color: FCColors.darkGrey,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacer(20),

                    // remember me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CheckboxTile(
                          true,
                          textMain: 'Remember Me',
                          onTap: () {},
                          onTextTap: () {},
                        ),
                        MyTextButton(
                          'Passwort vergessen?',
                          onTap: () {
                            navigate(context, const ResetPasswordView());
                          },
                        ),
                      ],
                    ),
                    const VerticalSpacer(24),

                    // login button
                    Button(
                      'Anmelden',
                      onPressed: () {
                        Api.login(emailController.text, passwordController.text,
                                true) //TODO make staying logged in conditional
                            .then((user) {
                          navigate(context, const NavigationView());
                        }, onError: (error) {
                          if (error is ApiException) {
                            error.showDialog(context);
                          }
                        });
                      },
                    ),
                    const VerticalSpacer(24),

                    // register account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Noch keinen Account? ',
                          style: style(fontSize: 14),
                        ),
                        MyTextButton(
                          'Account erstellen',
                          onTap: () {
                            navigate(context, const RegisterView());
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
