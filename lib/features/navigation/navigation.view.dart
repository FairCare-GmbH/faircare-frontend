import 'package:faircare/blocs/master/navbar/nav_bar_cubit.dart';
import 'package:faircare/features/navigation/bottom_nav_bar.widget.dart';
import 'package:faircare/features/preferences/preferences.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../patients/patients.view.dart';
import '../performance/performance.view.dart';
import '../tours/my_tours/my_tours.view.dart';
import '../tours/open_tours/open_tours.view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final tabs = [
    const OpenToursView(),
    const MyToursView(),
    const PerformanceView(),
    const PreferencesView(),
    const PatientsView(),
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
          bottomNavigationBar: const BottomNavBarWidget(),
        ),
      ),
    );
  }
}
