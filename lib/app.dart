import 'package:faircare/features/users/login.view.dart';
import 'package:faircare/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api/api.dart';
import 'features/getting_started/getting_started_progress_cubit.dart';
import 'features/navigation/nav_bar.cubit.dart';
import 'features/navigation/navigation.view.dart';
import 'features/notifications/notifications.bloc.dart';
import 'features/performance/performance_tabs.cubit.dart';
import 'features/performance/tour_list_performance_display_type.enum.dart';
import 'features/users/register/register_cubit.dart';
import 'features/users/register/register_progress.cubit.dart';
import 'features/users/ratings_bloc.dart';
import 'global/fc_colors.dart';

class FairCareApp extends StatelessWidget {
  const FairCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // intro
        BlocProvider<GettingStartedProgressCubit>(
          create: (_) => GettingStartedProgressCubit(),
        ),

        // register
        BlocProvider<RegisterProgressCubit>(
          create: (_) => RegisterProgressCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(),
        ),

        // master
        BlocProvider<NavBarCubit>(
          create: (_) => NavBarCubit(),
        ),

        // notifications
        BlocProvider<NotificationsBloc>(
          create: (_) => NotificationsBloc()..add(GetNotifications()),
        ),

        BlocProvider(
          create: (_) => RatingsBloc()..add(GetRatingsData()),
        ),
        BlocProvider<PerformanceTabsCubit>(
            create: (_) =>
                PerformanceTabsCubit(TourListPerformanceDisplayType.startTime)),
      ],
      child: MaterialApp(
        title: 'Faircare',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        locale: const Locale('de'),
        supportedLocales: const [Locale('de')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: FutureBuilder<bool>(
          future: Api.isLoggedIn()
              .onError((error, stackTrace) =>
                  false) //TODO log error to figure out why this doesnt' work sometimes. also establish why login request sent twice on startup
              .timeout(const Duration(milliseconds: 3500),
                  onTimeout: () => false),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SafeArea(
                child: Scaffold(
                  backgroundColor: FCColors.white,
                  //TODO rest of splash screen
                ),
              );
            } else if (snapshot.data!) {
              return const NavigationView();
            } else {
              return const LoginView();
            }
          },
        ),
        // home: const RequestVacationPage(),
      ),
    );
  }
}
