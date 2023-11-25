import 'package:faircare/features/getting_started/getting_started.view.dart';
import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/global/global.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () => navigateNext());
    super.initState();
  }

  void navigateNext() async {
    navigate(context, const GettingStartedView());
    // navigate(context, const NotificationsPage());
    // navigate(context, const MasterPage());
    // navigate(context, const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: FCColors.white,
      ),
    );
  }
}
