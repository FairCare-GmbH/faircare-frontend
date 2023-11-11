import 'package:faircare/blocs/master/navbar/nav_bar_cubit.dart';
import 'package:faircare/views/master/bottom_nav_bar.dart';
import 'package:faircare/views/my_revenues/my_revenues.view.dart';
import 'package:faircare/views/my_tours/my_tours.view.dart';
import 'package:faircare/views/preferences/preferences.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../open_tours/open_tours.view.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final tabs = [
    const OpenToursView(),
    const MyToursView(),
    const MyRevenuesView(),
    const PreferencesView(),
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
          body: BlocBuilder<NavBarCubit, int>(
            builder: (context, state) {
              return tabs[state];
            },
          ),
          bottomNavigationBar: const BottomNavBar(),
        ),
      ),
    );
  }
}
