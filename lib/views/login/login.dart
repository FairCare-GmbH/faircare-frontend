import 'package:faircare/global/colors.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/icon.dart';
import 'package:faircare/widgets/spacer.dart';
import 'package:faircare/widgets/text_button.dart';
import 'package:faircare/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

                    // password
                    MyTextField(
                      label: 'Passwort',
                      hint: 'Passwort',
                      obscure: true,
                      controller: passwordController,
                      suffixWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SvgIcon(
                            icon: 'hide',
                            color: MyColors.darkGrey,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              // padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: MyColors.prime,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: MyColors.white,
                                size: 16,
                              ),
                            ),
                            const HorizontalSpacer(6),
                            Text(
                              'Remember Me',
                              style: style(color: MyColors.darkGrey),
                            ),
                          ],
                        ),
                        MyTextButton(
                          'Passwort vergessen?',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const VerticalSpacer(24),

                    // login button
                    Button(
                      'Anmelden',
                      onPressed: () {},
                    ),
                    const VerticalSpacer(24),

                    // register account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Noch kein Account? ',
                          style: style(fontSize: 14),
                        ),
                        MyTextButton(
                          'Account erstellen',
                          onTap: () {},
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
