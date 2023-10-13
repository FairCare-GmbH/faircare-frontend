import 'package:faircare/views/available_tours/available_tours.dart';
import 'package:faircare/views/master/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final tabs = [
    const AvailableToursPage(),
    const AvailableToursPage(),
    const AvailableToursPage(),
    const AvailableToursPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: tabs[0],
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
