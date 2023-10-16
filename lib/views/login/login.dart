import 'package:faircare/global/colors.dart';
import 'package:faircare/global/global.dart';
import 'package:faircare/global/text_style.dart';
import 'package:faircare/views/master/master.dart';
import 'package:faircare/views/register/register.dart';
import 'package:faircare/views/reset_password/reset_password.dart';
import 'package:faircare/widgets/app_logo.dart';
import 'package:faircare/widgets/bg_image.dart';
import 'package:faircare/widgets/button.dart';
import 'package:faircare/widgets/checkbox_tile.dart';
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
                        CheckboxTile(
                          textMain: 'Remember Me',
                          onTap: () {},
                          onTextTap: () {},
                        ),
                        MyTextButton(
                          'Passwort vergessen?',
                          onTap: () {
                            navigate(context, const ResetPasswordPage());
                          },
                        ),
                      ],
                    ),
                    const VerticalSpacer(24),

                    // login button
                    Button(
                      'Anmelden',
                      onPressed: () {
                        navigate(context, const MasterPage());
                      },
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
                          onTap: () {
                            navigate(context, const RegisterPage());
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
