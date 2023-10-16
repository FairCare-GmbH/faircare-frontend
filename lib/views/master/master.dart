import 'package:faircare/blocs/navbar/nav_bar_cubit.dart';
import 'package:faircare/views/available_tours/available_tours.dart';
import 'package:faircare/views/master/bottom_nav_bar.dart';
import 'package:faircare/views/my_sales/my_sales.dart';
import 'package:faircare/views/my_tours/my_tours.dart';
import 'package:faircare/views/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final tabs = [
    const AvailableToursPage(),
    const MyToursPage(),
    const MySalesPage(),
    const PreferencesPage(),
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
