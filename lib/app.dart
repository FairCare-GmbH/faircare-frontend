import 'package:faircare/global/theme.dart';
import 'package:faircare/views/splash/splash.dart';
import 'package:flutter/material.dart';

class FaircareApp extends StatelessWidget {
  const FaircareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faircare',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const SplashPage(),
    );
  }
}
